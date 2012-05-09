From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 May 2012 17:32:07 +0800
Subject: [PATCH 2/6] dma: mxs-dma: let dma_is_apbh and apbh_is_old take
 parameter
In-Reply-To: <201205091116.41037.marex@denx.de>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <201205091100.34314.marex@denx.de>
 <1336554165.1540.172.camel@vkoul-udesk3>
 <201205091116.41037.marex@denx.de>
Message-ID: <CAAQ0ZWSB6Yf3cY=nQDBEYD9bE0T3BuBSqkYYTqyMeY2nKXux3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 17:16, Marek Vasut <marex@denx.de> wrote:
> Yep, I'm on the same boat with you. Check Shawn's reply to my mail, carrying the
> same concern. Well ... Shawn, I guess now that we're two, you better make
> another set of macros ;-)
>
I still do not think we need to necessarily have another set of
macros.  I would take your suggestion to add a comment there.

/*
 * The offset of NXTCMDAR register is different per both dma type and version,
 * while stride for each channel is all the same 0x70.
 */
#define HW_APBHX_CHn_NXTCMDAR(d, n) \
        (((dma_is_apbh(d) && apbh_is_old(d)) ? 0x050 : 0x110) + (n) * 0x70)
#define HW_APBHX_CHn_SEMA(d, n) \
        (((dma_is_apbh(d) && apbh_is_old(d)) ? 0x080 : 0x140) + (n) * 0x70)

Regards,
Shawn
