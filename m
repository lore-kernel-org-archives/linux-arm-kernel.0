From: linux-kernel.bfrz@manchmal.in-ulm.de (Christoph Biedl)
Date: Thu, 6 Sep 2012 19:28:34 +0200
Subject: Dockstar fails to boot since v3.0-rc6-6-g3835d69
In-Reply-To: <20120906071806.GA383@mannheim-rule.local>
References: <20120906054034.GA28549@lunn.ch>
 <1346915288@msgid.manchmal.in-ulm.de>
 <20120906071806.GA383@mannheim-rule.local>
Message-ID: <1346951929@msgid.manchmal.in-ulm.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

td;lr: It's all about Das U-Boot

Jonathan Nieder wrote...

> Christoph Biedl wrote:
> 
> >                                          Comparing .config and playing
> > suggests that disabling CONFIG_ARM_PATCH_PHYS_VIRT is a least a
> > workaround. Anything more I can test?
> 
> Hmm, my previous reaction might have been premature --- this might
> be [1] after all.  Any idea why 3835d69a6c70 affected anything?  If
> you take a .config that reproduced this and try
> 
> 	git checkout 3835d69a6c70^

3835d69a6c70^ is 43fc9d2, that one does fine.

> Do you use uBoot, and if so, what version?  If not, what bootloader?

Yes, that's an U-Boot as provided by Jeff Doozan two years ago:

    U-Boot 2010.09 (Oct 23 2010 - 11:49:22)
    Marvell-Dockstar/Pogoplug by Jeff Doozan

So it seemed I should dare an upgrade - I'm quite afraid of bricking
the dockstar so I'm rather reluctant to do these things. Now it's[1]

    U-Boot 2011.12 (Feb 12 2012 - 21:33:07)
    Seagate FreeAgent DockStar

and all the trouble is gone. The dockstar boots 3835d69, and the
v3.4.10 I initially discovered trouble with. Also "make Image" yields
an image now that boots without a flaw.

I'll leave up to you what to do next. I still have another dockstar
with an old U-Boot installed. If I should do further tests, please let
me know in the next days. If you declare "Upgrade your U-Boot" as
resolution for that ticket, no problem for me.

Thanks for your time in that matter,

    Christoph

[1] using http://projects.doozan.com/uboot/install_uboot_mtd0.sh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/70716fcb/attachment.sig>
