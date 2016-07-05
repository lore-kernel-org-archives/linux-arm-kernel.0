From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 5 Jul 2016 09:12:44 +0800
Subject: atmel_ssc_dai.c, use of dai->id
In-Reply-To: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
References: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
Message-ID: <b50d70ac-a07f-2db5-7cc7-2cf7a23479f9@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/5/2016 03:00, Peter Meerwald-Stadler wrote:
> Hello,
>
> I am trying to use SSC1 (not SSC0 which might work) on a SAMA5D4-Xplained
> board (4.1 kernel, but close to mainline)
>
> c706f2e5 ASoC: atmel_ssc_dai: distinguish the different SSC
> fixes an issue with cpu_dai id being always 0, while the ssc id should
> have been used (or the platform_device id)
>
> I think there is a remaining issue with DMA parameters in
> atmel_ssc_startup():
>
> line 324:
> dma_params = &ssc_dma_params[dai->id][dir];
>
> I think it should be
> dma_params = &ssc_dma_params[pdev->id][dir];
>
> I am new to this platform, please comment
> I can submit a formal patch later-on of course
>
Hi Peter,

Yes, you are right. It should be fixed in atmel_ssc_startup().
Thank you.

> thanks, regards, p.
>
