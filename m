From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 6 Jan 2016 12:49:52 +0000
Subject: [PATCH] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <20160106094616.GA563@leverpostej>
References: <1452073222-2956-1-git-send-email-jonathanh@nvidia.com>
 <20160106094616.GA563@leverpostej>
Message-ID: <568D0D70.4020309@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/01/16 09:46, Mark Rutland wrote:
> Hi,
> 
> On Wed, Jan 06, 2016 at 09:40:22AM +0000, Jon Hunter wrote:
>> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
>> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/Makefile           |  1 +
>>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 42 +++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
>> index a7e865da1005..0f7cdf3e05c1 100644
>> --- a/arch/arm64/boot/dts/nvidia/Makefile
>> +++ b/arch/arm64/boot/dts/nvidia/Makefile
>> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra132-norrin.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-0000.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
>> +dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
>>  
>>  always		:= $(dtb-y)
>>  clean-files	:= *.dtb
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> new file mode 100644
>> index 000000000000..a7474f5fcbcc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> @@ -0,0 +1,42 @@
>> +/dts-v1/;
>> +
>> +#include "tegra210.dtsi"
>> +
>> +/ {
>> +	model = "Google Pixel C";
>> +	compatible = "google,smaug-rev8", "google,smaug-rev7",
>> +		     "google,smaug-rev6", "google,smaug-rev5",
>> +		     "google,smaug-rev4", "google,smaug-rev3",
>> +		     "google,smaug-rev1", "google,smaug", "nvidia,tegra210";
> 
> This looks a little funky. Is each revision a strict superset of the
> previous version?

Yes this is based upon what Google have in the chromiumos branch [0] and
I have checked with them and they were ok with this.

Olof, let me know if you have any more comments here.

>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x70006000";
>> +	};
> 
> Use stdout-path.

Ok.

> Otherwise this looks ok.

Cheers
Jon

[0]
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.18/arch/arm64/boot/dts/tegra/tegra210-smaug-p1.dts
