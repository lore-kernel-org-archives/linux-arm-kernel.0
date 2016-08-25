From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 25 Aug 2016 14:45:58 +0100
Subject: [PATCH v2 0/7] scpi: Add support for legacy SCPI protocol
In-Reply-To: <f6c7249f-f103-fd91-2c89-a30c191427aa@baylibre.com>
References: <1471952816-30877-1-git-send-email-narmstrong@baylibre.com>
 <f6c7249f-f103-fd91-2c89-a30c191427aa@baylibre.com>
Message-ID: <73cce388-219d-2daa-811a-059c3d84c2e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/16 14:18, Neil Armstrong wrote:
> On 08/23/2016 01:46 PM, Neil Armstrong wrote:
>> This patchset aims to support the legacy SCPI firmware implementation that was
>> delivered as early technology preview for the JUNO platform.
>>
>> Finally a stable, maintained and public implementation for the SCPI protocol
>> has been upstreamed part of the JUNO support and it is the recommended way
>> of implementing SCP communication on ARMv8 platforms.
>>
>> The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
>> platforms. This patchset will only add support for Amlogic GXBB SoC.
>>
>> This patchset add support for the legacy protocol in the arm_scpi.c file,
>> avoiding code duplication.
>>
>> Last RFC discution tread can be found at : https://lkml.org/lkml/2016/8/9/210
>>
>> The last patch depends on the "Platform MHU" dtsi patch.
>>
>> Changes since v1 at : http://lkml.kernel.org/r/1471515066-3626-1-git-send-email-narmstrong at baylibre.com
>>  - Dropped vendor_send_message and rockchip vendor mechanism patches
>>  - Merged alternate functions into main functions using is_legacy boolean
>>  - Added DT match table to set is_legacy to true
>>  - Kept alternate scpi_ops structure for legacy
>>
>> Neil Armstrong (7):
>>   scpi: Add alternative legacy structures, functions and macros
>>   scpi: Use legacy variants command index calling scpi_send_message
>>   scpi: Add support for Legacy match table for Amlogic GXBB SoC
>>   scpi: grow MAX_DVFS_OPPS to 16 entries
>>   dt-bindings: Add support for Amlogic GXBB SCPI Interface
>>   ARM64: dts: meson-gxbb: Add SRAM node
>>   ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
>>
>>  Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  45 ++++
>>  drivers/firmware/arm_scpi.c                        | 279 +++++++++++++++++++--
>>  3 files changed, 302 insertions(+), 30 deletions(-)
>>
>
> Hi Sudeep,
>
> Sorry but I posted this V2 before you had time to look at my
> previous  v1 replies...
>

That's fine.

> In this series, I merged the scpi_send_message, but I must still
> evaluate how it's possible  to use the list to queue commands.
>

Ah OK.

> Here I used if(is_legacy) to stop duplicating functions, is this ok
> for you ?
>

I am still thinking if it can be abstracted well, some kind of mapping
but haven't thought too much about that yet. Also I was thinking about
bitmap for high priority commands. I remember doing something before but
seem to have lost that copy. I will try to dig it out..

-- 
Regards,
Sudeep
