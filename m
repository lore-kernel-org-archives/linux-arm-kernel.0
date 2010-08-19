From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Aug 2010 10:38:11 +0300
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <20100817154035.GD20325@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817135205.GC20325@n2100.arm.linux.org.uk>
	<20100817141210.GJ12184@atomide.com>
	<20100817154035.GD20325@n2100.arm.linux.org.uk>
Message-ID: <20100819073810.GR12184@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 18:33]:
> On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
> > Great, will give it a try hopefully tomorrow. Sounds like that's the way
> > to deal with fixing up things when booting up older UP ARMv6 without the
> > 32v6 support :)
> 
> What I've also been debating about is adding another word to the
> smpalt structure, that being a set of flags which denote the situation
> where the alternative should be used.
> 
> That means we can use it to do individual word replacements for SMP vs
> UP, ARMv6 vs ARMv6k etc.

Sounds good to me. Maybe it should then be called cpualt instead of smpalt?

Tried booting your patch and needed the following fix for Cortex-A8 UP.

Now it boots to the following error:

Machine configuration botched (nr -1073741824), unable to continue.

Does some struct size need to be changed or something?

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smp-on-up-fix.patch
Type: text/x-diff
Size: 667 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100819/088d7ba9/attachment.bin>
