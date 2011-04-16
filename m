From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 16 Apr 2011 18:06:00 -0500
Subject: [PATCH] mmc: sdhci: add support for pre_req and post_req
In-Reply-To: <1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sat, Apr 16, 2011 at 11:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> If not calling pre_req() before sdhci_request(), request()
> will prepare the cache just like it did it before.
> It is optional to use pre_req() and post_req().
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> I worked out the patch by referring to Per's patch below.
>
> ?omap_hsmmc: add support for pre_req and post_req
>
> It adds pre_req and post_req support for sdhci based host drivers to
> work with Per's non-blocking optimization. ?But I only have imx esdhc
> based hardware to test. ?Unfortunately, I can not measure the
> performance gain using mmc_test, because the current esdhc driver on
> mainline fails on the test. ?So I just did a quick test using 'dd',
> but sadly, I did not see noticeable performance gain here. ?The
> followings are possible reasons I can think of right away.
>
> * The patch did not add pre_req and post_req correctly. ?Please help
> ?review to catch the mistakes if any.
> * The imx esdhc driver uses SDHCI_SDMA (max_segs is 1) than SDHCI_ADAM
> ?(max_segs is 128), due to the broken ADMA support on imx esdhc. ?So
> ?can people holding other sdhci based hardware give a try on the
> ?patch?
>
> Hopefully, I can find some time to have a close look at the mmc_test
> failure and the broken ADMA with imx esdhc.
>

I'll try it out...

A
