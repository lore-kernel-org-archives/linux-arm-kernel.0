From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 8 Sep 2017 11:31:00 +0200
Subject: n900 in next-20170901
In-Reply-To: <20170905201314.GE5024@atomide.com>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
Message-ID: <20170908093100.GE18365@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > It compiles ok, but it hangs on boot; black screen, so sometime before
> > display is initialized.
> 
> Thanks for reporting it. Based on git bisect, the regression causing
> commit is 9caf25f996e8 ("mm/cma: manage the memory of the CMA area
> by using the ZONE_MOVABLE"). With this path applied, booting hangs
> with an error in omap3_save_secure_ram_context() after a call to
> _omap_save_secure_sram() that calls the related assembly code
> save_secure_ram_context.
> 
> However, looks like there is also some other commit causing issue.
> 
> Just reverting 9caf25f996e8 on Linux next causes the oops below.
> 
> Anybody got ideas why this now happens?

Thanks for quick bisect.

I take it 9caf25f996e8 is not going to be merged anywhere until this
is fixed...?

Best regards,
								Pavel
								

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/b6c71cac/attachment-0001.sig>
