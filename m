From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Jan 2018 09:29:35 +0100
Subject: v4.14.9 on ARMv5: OK with gcc 4.8/5.4, NOK with gcc 7.2
In-Reply-To: <20180104224741.GA17719@n2100.armlinux.org.uk>
References: <20180104180238.581b202c@windsurf.lan>
 <20180104171637.GP28752@n2100.armlinux.org.uk>
 <CAAQYJAuwE9n-M7pcpJL53JLVY0PmO721mHh7aZ5KkCoYTzdRMQ@mail.gmail.com>
 <20180104224741.GA17719@n2100.armlinux.org.uk>
Message-ID: <20180105092935.1001e6f6@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 4 Jan 2018 22:47:41 +0000, Russell King - ARM Linux wrote:

> > I am happy to report the gcc bug has been fixed in trunk.
> > I am as well dubious where they say this should also fix gcc6 where we
> > have no known issues with gcc6.
> > 
> > "
> > This should also fix
> > incorrect generation of ldrd/strd with unaligned accesses that could
> > previously have occurred on ARMv5e where all such operations must be
> > 64-bit aligned."
> > 
> > https://github.com/gcc-mirror/gcc/commit/f59996b56aaa1c1d62a16cbb4010775b624cbde0
> > 
> > In OpenEmbedded we backported the patch a while ago, see the
> > discussion about qemu booting where real hw doesn't:
> > http://lists.openembedded.org/pipermail/openembedded-core/2017-November/144045.html  
> 
> Thanks for reporting the update Andrea!

Thanks Russell and Andrea for the feedback. Good to know that the
problem was already known and even fixed. I'll wait for the gcc 7.x fix
to land in my distro toolchain, and will keep using an older toolchain
until then.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
