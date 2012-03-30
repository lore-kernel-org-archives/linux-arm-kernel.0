From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Mar 2012 22:50:42 +0800
Subject: How to add GPIO outputs to the PXA2xx MFP configuration?
In-Reply-To: <1333117833.65604.YahooMailClassic@web29013.mail.ird.yahoo.com>
References: <CAN1soZwgUooLEcDimUxyLO20x0__pAa+J3wRrH3zoW3pJsR2bg@mail.gmail.com>
 <1333117833.65604.YahooMailClassic@web29013.mail.ird.yahoo.com>
Message-ID: <CAN1soZwSOiKZQdRrykoP6oSPr-00svu+qKy4X61tCTSqQRv76w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> The GPIO output value I wish to add is specific to the hx4700 platform;
> it is not defined in any PXA27x documentation.
>
> Is it acceptable to add such platform-specific values to the generic
> mfp-pxa27x.h file?
>
Unless we append a new macro to resolve this issue. But I don't want to
put too much effort on MFP code. I'm planning to migrate to pinmux driver
since it could integrate with gpio and suspend code better.

Actually I appended pinmux driver for pxa3xx/mmp. They could be found
in linux-next tree. For next stage, I'll add support for DT and suspend.
If you like, you can also add pxa2xx support.

So I prefer you change mfp-pxa27x.h directly.

Best Regards
Haojian
