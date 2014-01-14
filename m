From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 14 Jan 2014 08:15:15 +0000
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <20140114003925.GH19878@titan.lakedaemon.net>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <1389174517.12612.87.camel@kazak.uk.xensource.com>
 <20140114003925.GH19878@titan.lakedaemon.net>
Message-ID: <1389687315.10695.12.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-01-13 at 19:39 -0500, Jason Cooper wrote:
> Ian,
> 
> On Wed, Jan 08, 2014 at 09:48:37AM +0000, Ian Campbell wrote:
> > What is the plan for the board files for the ts* platforms? Are they
> > going to go away? This seems to have happened for the Sheevaplug case,
> > which is causing some transition pain for distros (e.g.
> > http://bugs.debian.org/731345).
> 
> Sorry, I'm rather swamped at the moment.  From my cursory reading of the
> thread, is it correct to say that this problem can be solved by enabling
> the CONFIG_MACH_SHEEVAPLUG_DT config option?

That would have allows 3.11 to boot with DT, but for 3.11 we are OK with
the board file support from a Debian PoV

The real issue is the transition of the userspace components which
configure the bootloader (called "flash-kernel" in Debian) which needs
to know whether or not a DTB should be appended. I think we've now
mostly solved that by teaching flash-kernel what the minimum kernel
version which requires a DTB is (see [0] and [1]), I've set this to 3.12
for Sheevaplug and Guruplug, I'll set it to whatever is appropriate on
the ts* platforms when the time comes.

Ian.

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=731345http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=731345
[1] http://anonscm.debian.org/gitweb/?p=d-i/flash-kernel.git;a=commit;h=f656a00daa4d1ada46203e6e1831ae574eb005f8
