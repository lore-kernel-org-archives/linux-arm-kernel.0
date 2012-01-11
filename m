From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jan 2012 21:16:17 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <CAMPhdO9sGWTomtyMSTe_jC2GfvtdLR=M-z3Uzpesm9efBzhSqA@mail.gmail.com>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
 <20120110142008.GE26599@S2101-09.ap.freescale.net>
 <20120110142939.GB2019@richard-laptop>
 <20120110153836.GA27831@S2101-09.ap.freescale.net>
 <20120111005322.GB2414@b20223-02.ap.freescale.net>
 <20120111014730.GE2414@b20223-02.ap.freescale.net>
 <CAMPhdO9sGWTomtyMSTe_jC2GfvtdLR=M-z3Uzpesm9efBzhSqA@mail.gmail.com>
Message-ID: <20120111131615.GC20968@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 02:37:08PM +0800, Eric Miao wrote:
> I think Richard has made the issue quite clear here, the original

Yes, he has made it clear, but only after I asked for more comments,
not with the empty commit message.

> code does seem to have some problems even to me, who do not
> understand the very details of the SDMA:
> 
> -                       sdmac->event_mask0 = 1 << sdmac->event_id0;
> -                       sdmac->event_mask1 = 1 << (sdmac->event_id0 - 32);
> 
> 1. if sdmac->event_id0 >= 32, which will cause event_mask0 to be incorrect
> 2. if sdmac->event_id < 32, sdmac->event_mask1 will be incorrect
> 
My testing tells this is not the case.  The event_mask0 will be 0 in
case 1) and event_mask1 will be 0 in case 2), which is quite what we
expect.  And I do not believe you will see any functionality bug with
the existing code.

See, that's why we need verbose commit message to make the patch and
the problem it's trying to address very clear.

Regards,
Shawn
