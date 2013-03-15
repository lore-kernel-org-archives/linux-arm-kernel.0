From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 16 Mar 2013 00:17:43 +0530
Subject: [PATCH V3 5/5] ARM: tegra: add spi nodes to Tegra114 DT
In-Reply-To: <51436BB1.8060005@wwwdotorg.org>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
 <1363204194-19487-6-git-send-email-ldewangan@nvidia.com>
 <51436BB1.8060005@wwwdotorg.org>
Message-ID: <51436CCF.6040908@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 March 2013 12:12 AM, Stephen Warren wrote:
> On 03/13/2013 01:49 PM, Laxman Dewangan wrote:
>> NVIDIA's Tegra114 has 6 spi controllers. These controllers are
>> redesign on T114 with different register interface.
>> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
>> +		reg = <0x7000d400 0x200>;
> ...
>> +		reg = <0x7000d600 0x200>;
> ...
>> +		reg = <0x7000d480 0x200>;
> ...
>> +		reg = <0x7000da00 0x200>;
> ...
>> +		reg = <0x7000dc00 0x200>;
> ...
>> +		reg = <0x7000de00 0x200>;
> I assume that third entry should be 0x7000d800 not 0x7000d480; the TRM
> certainly thinks so. I fixed this up when I applied this patch.

Yes, this is bug in my patch and unfortunately exist in tegra20 and 
tegra30 also.

grep d480 tegra*
tegra114.dtsi:        reg = <0x7000d480 0x200>;
tegra20.dtsi:        reg = <0x7000d480 0x200>;
tegra30.dtsi:        reg = <0x7000d480 0x200>;

We need to fix this. I will post a patch now to correct it.


>
> I've applied the series to Tegra's for-3.10/dt branch. I made a few
> node/property ordering changes for consistency, and some capitalization
> fixes in the commit subjects/descriptions.

Thank you very much for taking care of this.
