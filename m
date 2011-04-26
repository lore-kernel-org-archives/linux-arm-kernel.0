From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 26 Apr 2011 12:21:08 +0200
Subject: [PATCH] mmc: sdhci: add support for pre_req and post_req
In-Reply-To: <20110426024758.GB6145@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
	<BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
	<4DB61F29.4090600@samsung.com>
	<20110426024758.GB6145@S2100-06.ap.freescale.net>
Message-ID: <BANLkTinmDS1MayqUwNvWKvhjV3LPbu1u=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2011 04:47, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Apr 26, 2011 at 10:26:01AM +0900, Jaehoon Chung wrote:
>> Hi Shawn
>>
>> I tested using ADMA with your patch...(benchmark : IOzone)
>> But I didn't get improvement of performance with ADMA..
>> (i can see improvement of performance with SDMA)
>>
>> I want to know how you think about this..
>>
> It's still an open question if pre_req and post_req were correctly
> added, even you have seen improvement of SDMA case with IOzone. ?I
> would leave the question to Per Forlin.
>
Performance numbers from user space may vary.
Currently I am looking into how the block layer adds request to the
mmc blockdev. I can see that if is common that one read request is
pushed to the mmc blockdev queue after the previous request has
already finished. For this scenario there will no improvement. If
running IOzone with large record sizes multiple requests are queued up
in the mmc blockdev queue and this results in increase of bandwidth.
The mmc_test are intended to help verifying if the pre_req and
post_req are implemented correctly and give a number of the maximum
gain in performance.

> --
> Regards,
> Shawn
Regards,
Per
