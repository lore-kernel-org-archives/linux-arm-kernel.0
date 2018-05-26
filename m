From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 26 May 2018 10:37:49 +0200
Subject: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180525211025.c73zdcdtyuvlewng@localhost>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
Message-ID: <9f9cc086-6069-afbc-d3c6-46608ff35b79@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/05/2018 23:10, Olof Johansson wrote:
> On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
>> The cooling device properties, like "#cooling-cells" and
>> "dynamic-power-coefficient", should either be present for all the CPUs
>> of a cluster or none. If these are present only for a subset of CPUs of
>> a cluster then things will start falling apart as soon as the CPUs are
>> brought online in a different order. For example, this will happen
>> because the operating system looks for such properties in the CPU node
>> it is trying to bring up, so that it can register a cooling device.
>>
>> Add such missing properties.
> 
> This seems awkward compared to just having one cooling-cells in the /cpus node
> instead.
> 
> What's it used for? I don't see any properties in the device nodes on meson-gxm
> that have any cooling-foo cells in them? So why should #cooling-cells be
> needed?


There is no reason to have the cooling-cells on these other CPUs, the DVFS is
controlled on the first CPU of each cluster, here cpu0 and cpu4 and only
cpu0 and cpu4 are used as cooling-cells.

Neil

> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
