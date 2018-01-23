From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 23 Jan 2018 17:06:53 +0800
Subject: [PATCH v6 03/13] arm64: cpufeature: Detect CPU RAS Extentions
In-Reply-To: <5A663C59.6030205@arm.com>
References: <20180115193906.30053-1-james.morse@arm.com>
 <20180115193906.30053-4-james.morse@arm.com>
 <78d4374a-f75c-6860-38ab-6373ffae3eee@huawei.com> <5A663C59.6030205@arm.com>
Message-ID: <2fbdd6f2-3225-1993-cae5-0bc435189d36@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2018/1/23 3:32, James Morse wrote:
>> it seems this "CONFIG_ARM64_RAS_EXTN" is not enabled in the "arch/arm64/configs/defconfig",
>> if not, I want to enable this config to enable RAS feature in the defconfig. do you agree?
> Sure. This series doesn't do a lot on its own, it expects firmware-first or
> kernel-first support, which may in turn depend-on this feature. It means we
> don't panic() when notified of corrected errors, until we get the
> {firmware,kernel}-first support.
> 
> Don't defconfig changes get collected by arm-soc? (I'm not sure how these get
> picked up...)

Now we should have supported firmware-first, do you mean we do not enable "CONFIG_ARM64_RAS_EXTN" in the
defconfig for ARM's SOC until kernel-first RAS is supported?

> 
> 
> James
