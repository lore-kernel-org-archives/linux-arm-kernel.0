From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Oct 2015 16:15:10 +0200
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <561FAEBF.2090508@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
 <20151015113735.GB21930@cbox> <20151015124451.GI8825@leverpostej>
 <561FA6AE.6090707@arm.com> <20151015133001.GF21930@cbox>
 <561FAEBF.2090508@arm.com>
Message-ID: <20151015141510.GA12895@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 02:48:47PM +0100, Suzuki K. Poulose wrote:
> On 15/10/15 14:30, Christoffer Dall wrote:
> >On Thu, Oct 15, 2015 at 02:14:22PM +0100, Suzuki K. Poulose wrote:
> >>On 15/10/15 13:44, Mark Rutland wrote:
> >>>On Thu, Oct 15, 2015 at 01:37:35PM +0200, Christoffer Dall wrote:
> >>>>On Wed, Oct 14, 2015 at 12:20:26PM +0100, Suzuki K. Poulose wrote:
> 
> 
> >>  * The maximum number of levels supported by the architecture is 4. Hence at starting
> >>  * at level n, we hanve (4 - n) levels of translation. So, the total number of bits
> >
> >nit: s/hanve/have/
> 
> Fixed.
> 
> >
> >>  * mapped by an entry at level n is :
> >>  *
> >>  *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
> >>  *
> >>  * Rearranging it a bit we get :
> >>  *   (4 - n) * (PAGE_SHIFT - 3) + 3
> >>  */
> >>
> >>Or we could use the formula without rearranging.
> >>
> >Either way, even I get it now.
> >
> >Thanks for the explanation!!
> 
> :). I was involved too much in these calculations that, the formula looked
> obvious to me, when I wrote it. But yes, I did realise that it is indeed
> complicated, once I really started looking at explaining why I wrote it so.
> Thanks for being patient :) and complaining peacefully !
> 
> Btw, I have a revised (hopefully better) version here :
> 
> /*
>  * Size mapped by an entry at level n ( 0 <= n <= 3)
>  * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
>  * in the final page. The maximum number of translation levels supported by
>  * the architecture is 4. Hence, starting at at level n, we have further
>  * ((4 - n) - 1) levels of translation excluding the offset within the page.
>  * So, the total number of bits mapped by an entry at level n is :
>  *
>  *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
>  *
>  * Rearranging it a bit we get :
>  *   (4 - n) * (PAGE_SHIFT - 3) + 3
>  */
> 

Looks good.

> 
> >
> >Assuming some version of this goes in:
> >
> >Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> >
> 
> Thanks. I lost two interview questions though ;)
> 
There are plenty of good sources for that in the KVM/ARM code.

-Christoffer
