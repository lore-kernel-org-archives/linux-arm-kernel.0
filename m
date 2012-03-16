From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 16 Mar 2012 02:07:42 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120316020111.GE6065@S2101-09.ap.freescale.net>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
Message-ID: <4F62A06C.5000304@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> This could probably change to check whether property codec-handle is
> present under SSI node to decide if it runs with "old binding" or
> "new binding".

I guess that's how we need to do it.  The SSI driver should not be looking 
for /sound node, but that's the most reliable way to know if we have a new 
or old binding.

>> +		ssi_private->imx_pcm_pdev =
>> +			platform_device_register_simple("imx-pcm-audio",
>>
> This is still IMX vs. PowerPC thing rather than "old binding" vs. "new
> binding" one.

What is "imx-pcm-audio"?

>> This prohibits me from using the new binding on any future PowerPC parts,
>> because it clearly says "iMX" on everything.
>
> I think we can change it later when the future PowerPC parts come to
> use the new binding.  In any case, I do not see this is an issue that
> should block the whole series.

At least get rid of any unnecessary references to "imx".

-- 
Timur Tabi
Linux kernel developer at Freescale
