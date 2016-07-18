From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Jul 2016 14:42:43 +0800
Subject: [PATCH V2 03/10] Documentation: dt-bindings: firmware: tegra: add
 bindings of the BPMP
In-Reply-To: <5786995A.1090706@wwwdotorg.org>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-4-josephl@nvidia.com> <5786995A.1090706@wwwdotorg.org>
Message-ID: <578C7A63.1000004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2016 03:41 AM, Stephen Warren wrote:
> On 07/05/2016 03:04 AM, Joseph Lo wrote:
>> The BPMP is a specific processor in Tegra chip, which is designed for
>> booting process handling and offloading the power management, clock
>> management, and reset control tasks from the CPU. The binding document
>> defines the resources that would be used by the BPMP firmware driver,
>> which can create the interprocessor communication (IPC) between the CPU
>> and BPMP.
>
>> diff --git
>> a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>
>> +- Documentation/devicetree/bindings/mailbox/mailbox.txt
>> +- Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>
>> +- Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +- include/dt-bindings/clock/tegra186-clock.h
>> +- Documentation/devicetree/bindings/reset/reset.txt
>> +- include/dt-bindings/reset/tegra186-reset.h
>
> If you end up needing to repost this, it would be nice to make all those
> file references more generic. In particular, some SW projects store
> binding docs somewhere other than Documentation/devicetree/bindings/
> (e.g. U-Boot uses doc/device-tree-bindings/), and it's possible that the
> header files aren't stored in include/ but somewhere else. To make these
> file references valid everywhere, I'd suggest using relative paths for
> the binding docs, and #include style paths for the headers, e.g.:
>
> ../clock/clock-bindings.txt
>
> <dt-bindings/clock/tegra186-clock.h>
>
OK. Will fix this.

Thanks,
-Joseph
