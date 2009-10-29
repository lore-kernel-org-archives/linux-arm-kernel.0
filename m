From: pieterg@gmx.com (pieterg)
Date: Thu, 29 Oct 2009 12:35:55 +0100
Subject: pxafb: RGBT555 support
Message-ID: <200910291235.55826.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Great to see the 'recent' work on overlay support and color format fixes in 
pxafb.c.
Looks like I no longer need my local patches.

However, there is one thing that I cannot seem to accomplish just yet.
We have an LCD which is connected in an RGBT555 configuration.
That means somehow var->transp.length should be set to 1.
After that, it looks like pxafb_set_pxifmt should do its job just fine.

Would it make sense to add transparency info to pxafb_mode_info?
After all it is a hardware property, with our LCD and the way it is 
connected we won't be able to do RGB565, so our var->transp.length should 
be fixed at 1.
If pxafb_setmode could do that, based on the pxafb_mode_info, that would 
probably solve my problem.
Maybe something could be done by comparing 'depth' and 'bpp', if one is 16 
and the other 15, one could make the assumption the remaining bit is used 
for transparency.

Or am I overlooking something here, and is there a better way to force pxafb 
to RGBT555 for my LCD?

Rgds, Pieter
