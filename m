From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 21 Aug 2014 10:37:46 +0300
Subject: [PATCH v3 3/4] ARM: tegra: Add thermal trip points for Jetson TK1
In-Reply-To: <53F4FA80.9050103@wwwdotorg.org>
References: <1407320706-17440-1-git-send-email-mperttunen@nvidia.com>
 <1407320706-17440-4-git-send-email-mperttunen@nvidia.com>
 <53F4FA80.9050103@wwwdotorg.org>
Message-ID: <53F5A1CA.1010601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/14 22:44, Stephen Warren wrote:
> On 08/06/2014 04:25 AM, Mikko Perttunen wrote:
>> This adds critical trip points to the Jetson TK1 device tree.
>> The device will do a controlled shutdown when either the CPU, GPU
>> or MEM thermal zone reaches 101 degrees Celsius.
>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>
>> +    thermal-zones {
>> +        cpu {
>> +            trips {
> ...
>> +            };
>> +        };
>
> thermal.txt states that a cooling-maps sub-node is mandatory. However,
> it seems to be missing here. Is the DT binding documentation overly
> strict, or do we need to add such a node here?

Debatable. I can add an empty one, that's probably the easiest solution.

Mikko

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
