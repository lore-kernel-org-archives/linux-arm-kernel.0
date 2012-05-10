From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 17:11:55 +0800
Subject: [alsa-devel] [PATCH 2/6] ASoC: mxs: use devm_clk_get for
 mxs_saif_probe
In-Reply-To: <20120510091204.GH6622@shlinux2.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
 <20120510091204.GH6622@shlinux2.ap.freescale.net>
Message-ID: <CAAQ0ZWTvZtK1AsXD=5jfd-hjLoo9bFdps=hCQpHs9sHQxjnxVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 May 2012 17:12, Dong Aisheng <aisheng.dong@freescale.com> wrote:
>> ? ? ? dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> ? ? ? if (!dmares) {
>> - ? ? ? ? ? ? ret = -ENODEV;
> The 'ret' is used below.

Right, good catch.

> The following has the same issue.
>
>> ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to get dma resource: %d\n",
>> ? ? ? ? ? ? ? ? ? ? ? ret);
> I think we can remove the ret here since it does not help too much.
>
Ok, will do.

Regards,
Shawn
