From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 16 Mar 2016 06:50:45 +0000
Subject: NVMEM usage question
In-Reply-To: <1457956899.20370.25.camel@mtksdaap41>
References: <1457956899.20370.25.camel@mtksdaap41>
Message-ID: <56E90245.1040203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/03/16 12:01, Eddie Huang wrote:
> Hi,
>
> Mediatek PMIC chip have some spare registers used to store information.
> The value of these registers will exist until user unplug battery or
> battery depletion. One of our usage example is store battery utilization
> in these spare registers. We want to implement NVMEM driver to
> read/write sparse registers, but binding document describe NVMEM is for
> "Non-volatile memory", and for hardware like eeprom, efuse. Since the
> usage here is some kind of "battery backup memory", but not real
> non-volatile memory, is NVMEM driver suitable for this case ?

If this battery usage information can be retrieved after full power 
cycle, then there should be some sort of non volatile memory involved.

If that's the case then you can use the nvmem.

--srini


>
> Eddie
>
>
