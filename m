From: pieterg@gmx.com (pieterg)
Date: Wed, 4 Nov 2009 10:28:28 +0100
Subject: pxafb: RGBT555 support
In-Reply-To: <200910291235.55826.pieterg@gmx.com>
References: <200910291235.55826.pieterg@gmx.com>
Message-ID: <200911041028.28859.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 October 2009 12:35:55 pieterg wrote:
> Great to see the 'recent' work on overlay support and color format fixes
> in pxafb.c.
> Looks like I no longer need my local patches.
>
> However, there is one thing that I cannot seem to accomplish just yet.
> We have an LCD which is connected in an RGBT555 configuration.
> That means somehow var->transp.length should be set to 1.
> After that, it looks like pxafb_set_pxifmt should do its job just fine.
>
> Would it make sense to add transparency info to pxafb_mode_info?
> After all it is a hardware property, with our LCD and the way it is
> connected we won't be able to do RGB565, so our var->transp.length should
> be fixed at 1.
> If pxafb_setmode could do that, based on the pxafb_mode_info, that would
> probably solve my problem.
> Maybe something could be done by comparing 'depth' and 'bpp', if one is
> 16 and the other 15, one could make the assumption the remaining bit is
> used for transparency.
>
> Or am I overlooking something here, and is there a better way to force
> pxafb to RGBT555 for my LCD?

Sorry to ask again, but is there an official/preferred way to select RGBT555 
mode in pxafb, or should I just continue hacking it in for now?

Rgds, Pieter
