From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 28 Mar 2017 16:37:36 +0100
Subject: [PATCH] arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210
 platforms
In-Reply-To: <e3ab2e09-ee32-96e2-b0c8-f7def668bf31@nvidia.com>
References: <1490701718-16571-1-git-send-email-jonathanh@nvidia.com>
 <bf527c4b-f17c-bfcf-e7fa-dab64b131996@arm.com>
 <e3ab2e09-ee32-96e2-b0c8-f7def668bf31@nvidia.com>
Message-ID: <29312056-accf-cd4b-b0c2-d02fc085cb60@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/03/17 16:32, Jon Hunter wrote:
> 
> On 28/03/17 15:55, Sudeep Holla wrote:
>> On 28/03/17 12:48, Jon Hunter wrote:
>>> Add the CPU and PSCI nodes for the NVIDIA Tegra210 platforms so that
>>> all CPUs can be enabled on boot. This assumes that the PSCI firmware
>>> has been loaded during the initial bootstrap on the device before the
>>> kernel starts (which is typically the case for these platforms). The
>>> PSCI firmware version is set to v0.2 which aligns with the current
>>> shipping version for Tegra.
>>>
>>> Reported-by: Martin Michlmayr <tbm@cyrius.com>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 23 +++++++++++++++++++++++
>>>  arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi | 24 ++++++++++++++++++++++++
>>>  2 files changed, 47 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>>> index 906fb836d241..de1696c28140 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>>> @@ -296,6 +296,29 @@
>>>  		};
>>>  	};
>>>  
>>> +	cpus {
>>> +		cpu at 0 {
>>> +			enable-method = "psci";
>>
>> Is some firmware expected to populate other required properties ?
>>
>> If yes, why not populate everything in the firmware ?
>>
>> If no, how does it even boot secondaries without the "reg" property
>> that usually contains MPIDR.
> 
> Please see 'arch/arm64/boot/dts/nvidia/tegra210.dtsi' which has these
> fields. So far we have been populating the psci information at the board
> level and so I have kept with that here and so the above is just the
> delta. Maybe the $subject could be a little clearer!

Sorry for the noise, I traversed files/headers upwards and missed
the innermost tegra210.dtsi :(

-- 
Regards,
Sudeep
