From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 8 Mar 2018 19:05:16 +0100
Subject: Nokia N900: insecure W+X mapping at 0xd0050000
In-Reply-To: <20180308164652.GL5799@atomide.com>
References: <20180308142818.GA9439@amd> <20180308162446.GK5799@atomide.com>
 <20180308164652.GL5799@atomide.com>
Message-ID: <20180308180516.GB16940@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > * Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> > > Insecure W+X mappings, who cares about those? I have 7 pages...
> > 
> > Is this with CONFIG_DEBUG_WX=y?
> > 
> > My guess is that it's for mapping the PM assembly to SRAM. This
> > is already fixed for am335x that is using drivers/misc/sram*.c.
> > I think omap2 - omap4 still need fixing if this is the culprit.
> 
> Adding Dave to Cc, here's a quick fix for this one.

I did a quick testing and warning is gone. Thanks!

Tested-by: Pavel Machek <pavel@ucw.cz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/10049589/attachment.sig>
