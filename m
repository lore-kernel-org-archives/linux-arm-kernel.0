From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Mar 2018 12:22:31 +0100
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
In-Reply-To: <5AA0F10D.9010602@samsung.com>
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
 <20180307171111.14551-1-s.nawrocki@samsung.com>
 <5AA0B59F.3070402@samsung.com>
 <3c68c3da-a0c3-4e4e-da6b-3e4b1af6d19d@samsung.com>
 <5AA0DD39.3040108@samsung.com>
 <9f1e8619-974d-cd07-79c3-c6d9a4dc0f97@samsung.com>
 <5AA0F10D.9010602@samsung.com>
Message-ID: <e3e1c628-d88f-6fb4-171e-a49c7ee38135@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

Cc: alsa-devel at alsa-project.org

On 03/08/2018 09:15 AM, Inki Dae wrote:
> By the way, it seems 'sound-dai-cells' property never affect Exynos4210/4212> 5420/5433. It seems that even through ALSA TM2 audio driver(tm2_wm5110.c) 
> exists the driver never check the property.
>
> However, this patch adds below description.
>
> "Optional properties for Exynos 4210, 4212, 5420 and 5433"
> 
> Is there a possibility for other boards based on Exynos4210/4212/5420/5433 
> SoC to use this property later?

All these SoCs have the HDMI IP block which has one input DAI, connected 
internally over I2S bus with the IS2 controller.

I think there is no advantage in limiting ourselves now only to SoC's 
for which we currently rely on that DT property in current kernel code, 
just to update this documentation later when we actually put the property 
in dts files. 

In case of exynos5420 we already require #sound-dai-cells for Odroid and 
I have also a patch for exynos5420-peach-pit board which will need it as 
well.

As far as exynos4210 and exynos4212 are concerned it's a matter of adding
support for Odroid-U3, then we will also need this property because
we are going to use "multi-codec" (HDMI and external I2S0 pins for CODEC
are wired in parallel).

In case of exynos5433 it just happens that the code in current driver 
doesn't require #sound-dai-cells property - one of the reasons I made it
this way was to avoid dependency on dts, but it doesn't imply we should 
describe the HW in DT incompletely. Once the property is in dtbs we can 
update the driver to use more generic code, instead of open coding things.

Actually I have forgotten to add also exynos5250 to the list.

-- 
Regards,
Sylwester
