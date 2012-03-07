From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 09:14:09 +0000
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <CACRpkdYQpnSMVWUizEYHTjx_AK5Ai7dos0SBd208Wf5ZJLdrCw@mail.gmail.com>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <201203061412.00073.arnd@arndb.de>
 <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
 <CACRpkdYQpnSMVWUizEYHTjx_AK5Ai7dos0SBd208Wf5ZJLdrCw@mail.gmail.com>
Message-ID: <20120307091409.GL17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 09:40:31AM +0100, Linus Walleij wrote:
> Network equipment seems to like using BE.
> 
> I have some vague idea that this is beacuse IP packets are big
> endian, and thus you can process them quickly by just casting fields
> to e.g. u32 pointers and read them.
> 
> I don't know if this is true, but seems to much of a correlation to
> be pure coincidence. Thus a pretty interesting subject in
> embedded ARM not used for tablets/mobile/generic computing
> kind of stuff.

ISTR Nicolas explained this to me as being an established thing in the
comms sector.  They expect BE and only understand BE.

I did point out that you end up with many more endian conversions by
going to BE, mainly because PCI is LE and all your PCI accesses have
to be endian-swapped.  So in terms of bandwidth, I'd expect an ARM
PCI platform running in BE mode to have worse throughput than a LE
PCI platform.

But... if BE allows the comms people to keep their warm fuzzy feeling
who are we to argue.
