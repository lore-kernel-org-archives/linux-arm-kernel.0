From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 18 May 2011 00:02:00 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <78EB813416554F1A973EF20AA714ADF8@subhasishg>
References: <78EB813416554F1A973EF20AA714ADF8@subhasishg>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF13FC2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 10:47:18, Subhasish Ghosh wrote:
> Hi Sekhar,
> 
> >>> Say, if the driver is loaded as a module.
> >>> If I allocate the sram in the platform code, how to I
> >>> free it when the driver is unloaded. 
> >> 
> >> This is what I said in my last e-mail. What is
> >> the issue you see with this approach?
> >> 
> >> | Thanks for the clarification. In this case, the driver
> >> | should use platform callbacks to get/put fast fifo
> >> | space. In case this callback is not populated by the
> >> | platform or returns an error, the driver should fall
> >> | back to allocating from DDR.
> >> 
> > 
> > ok, so what you are suggesting is that I implement some
> > callbacks (like .fifo_alloc, .fifo_dealloc) which can allocate
> > memory using sram_alloc.
> > My doubt is, if already such API's are there (by Russel) or you
> > are suggesting to implement them.
> 
> I can add the fifo_alloc/dealloc as part of the suart platform_data,
> Is that's what you are suggesting. If you may please point me out 
> to any example. I am just not clear with this. 

Yes, that's what I am suggesting. I don't have an exact example
for you, but for an example of how function pointers can be passed
along in platform data you can look at the platform data for
DA8x FB driver in include/video/da8xx-fb.h.

Hope that helps.

Thanks,
Sekhar
