From: per.forlin@linaro.org (Per Forlin)
Date: Thu, 21 Apr 2011 10:46:18 +0200
Subject: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
In-Reply-To: <20110421062924.GB4024@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
	<BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
	<20110420140120.GF1965@S2100-06.ap.freescale.net>
	<BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
	<20110421062924.GB4024@S2100-06.ap.freescale.net>
Message-ID: <BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2011 08:29, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Wed, Apr 20, 2011 at 05:30:22PM +0200, Per Forlin wrote:
> [...]
>> Remove dma_map and dma_unmap from your host driver and run the tests
>> (obviously nonblocking and blocking will have the same results). If
>> there is still no performance gain the cache penalty is very small on
>> your platform and therefore nonblocking doesn't improve things much.
>> Please let me know the result.
>>
> Sorry, I could not understand. ?What's the point to run the test when
> the driver is even broken. ?The removal of ?dma_map_sg and
> dma_unmap_sg makes mxs-mmc host driver broken.
The point is only to get a measurement of the cost of handling
dma_map_sg and dma_unmap_sg, this is the maximum time mmc nonblocking
can save.
The nonblocking mmc_test should save the total time of dma_map_sg and
dma_unmap_sg, if the pre_req and post_req hooks are implemented
correctly.
Running without dma_map_sg and dma_unmap_sg will confirm if the
pre_req and post_req hooks are implemented correctly.

>
> --
> Regards,
> Shawn
>
>
Regards,
Per
