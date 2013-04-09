From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Apr 2013 09:46:04 -0600
Subject: [PATCH 2/3] ARM: dts: tegra: Correct PCIe entry
In-Reply-To: <20130409083050.GQ3572@tbergstrom-lnx.Nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <1365435688-4179-2-git-send-email-jagarwal@nvidia.com>
 <51630BF4.6000605@wwwdotorg.org>
 <20130409083050.GQ3572@tbergstrom-lnx.Nvidia.com>
Message-ID: <516437BC.8060707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2013 02:30 AM, Peter De Schrijver wrote:
> On Mon, Apr 08, 2013 at 08:27:00PM +0200, Stephen Warren wrote:
>> On 04/08/2013 09:41 AM, Jay Agarwal wrote:
>>> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
>>
>> Your s-o-b line should be below the patch description, not above it.
>> Please see Documentation/SubmittingPatches.
>>
>> I also don't see a --- line between the patch description and diffstat.
>> How are you generating these patch emails? Please see our internal wiki,
>> or other git documentation.
>>
>>> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
>>
>>> -		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
>>> +		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml0";
>>
>> Can you please explain more about this change?
>>
>> I see the Tegra clock driver provides both a "cml0" and a "cml1" clock.
>> Are both of those used for PCIe?
>>
> 
> cml0 is used for pcie and cml1 is used for sata.

OK, so the PCIe drivers' clock-names property may as well contain just
cml then. Same for SATA. The clock name at the provider isn't relevant.
