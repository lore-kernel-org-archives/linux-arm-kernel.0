From: s-anna@ti.com (Suman Anna)
Date: Wed, 20 Sep 2017 11:55:12 -0500
Subject: [PATCH 0/3] Add and enable DSP device on OMAPL138 LCDK board
In-Reply-To: <8bd08406-3fd8-9742-c1b9-d3ec9712c4ee@ti.com>
References: <20170919002833.5677-1-s-anna@ti.com>
 <8bd08406-3fd8-9742-c1b9-d3ec9712c4ee@ti.com>
Message-ID: <be3c9155-efe1-7c14-0b04-bc25cb7e1d40@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2017 10:14 AM, Sekhar Nori wrote:
> Hi Suman,
> 
> On Tuesday 19 September 2017 05:58 AM, Suman Anna wrote:
>> Hi Sekhar,
>>
>> The following series adds the DT node for the DSP device present on
>> on DA850/OMAPL138 SoCs. The node is disabled in the base dts file, and
>> enabled in the corresponding LCDK board file alongside the reserved
>> CMA pool required by the DSP device. The DT bindings and driver
>> adaptation were added to mainline in 4.14-rc1, and this series adds
>> the remaining dt portions. Nodes are added as per bindings in
>> Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
>>
>> Patches are based on 4.14-rc1. The first 2 patches adds the base DTS
>> node and enables the device on OMAPL138 LCDK board. The last patch
>> allows the non-DT clock to be bound to the DT DSP device by using
>> of_auxdata which renames the device to the same as the non-DT device
>> name. This is required by the davinci remoteproc driver to properly
>> acquire and enable the clock for this device.
>>
>> Validation done on OMAPL138 LCDK board. Supported features include
>> basic load/boot (tested with rpmsg_client_sample) using external
>> memory from the CMA pool.
> 
> Applied for v4.15. The patches are on my master branch. They will be in
> linux-next when I send my pull request to ARM-SoC, which typically will
> take a couple of weeks more.

Thanks Sekhar.

> 
> davinci_all_defconfig seems to be missing the CMA options needed. Could
> you send a patch enabling them?

These are tracked as dependencies on the remoteproc Kconfig, so you
won't be able to enable the driver without turning them on. I left them
as there were before my DT adaptation, but I can enable the CMA options
by default going forward.

regards
Suman
