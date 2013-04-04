From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Apr 2013 15:30:01 -0600
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <515DF096.2000703@wwwdotorg.org>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <515DF096.2000703@wwwdotorg.org>
Message-ID: <515DF0D9.40007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:28 PM, Stephen Warren wrote:
> On 04/03/2013 08:45 AM, Thierry Reding wrote:
>> Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
>> directory. The motivation is to collect various host controller drivers
>> in the same location in order to facilitate refactoring.
>>
>> The Tegra PCIe driver has been largely rewritten, both in order to turn
>> it into a proper platform driver and to add MSI (based on code by
>> Krishna Kishore <kthota@nvidia.com>) as well as device tree support.
> 
>>  arch/arm/boot/dts/tegra20.dtsi                     |   53 +
> 
> I guess this has to touch both the driver and the dtsi file so that
> bisectabilty isn't broken? I guess that's OK.

Actually, can't you move all the *.dts/*.dtsi changes to the start of
the series, then put the driver conversion patch last, to avoid any
bisectability issues and still keep code and DT changes separate?
