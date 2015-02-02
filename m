From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 2 Feb 2015 20:07:56 +0530
Subject: [PATCH] phy: qcom-ufs: export symbols needed by main drivers
In-Reply-To: <7dbea2dd0edafbb35cbd36f8a9b135ed.squirrel@www.codeaurora.org>
References: <1840882.huchmEIh5K@wuerfel>
 <7dbea2dd0edafbb35cbd36f8a9b135ed.squirrel@www.codeaurora.org>
Message-ID: <54CF8BC4.8080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 02 February 2015 08:01 PM, ygardi at codeaurora.org wrote:
>> The qcom ufs phy support is split into three separate loadable
>> modules, however none of the interfaces are exported, resulting
>> in a link error:
>>
>> ERROR: "ufs_qcom_phy_power_off" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_power_on" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_exit" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_generic_probe" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_init_vregulators"
>> [drivers/phy/phy-qcom-ufs-qmp-20nm.ko] undefined!
>> ERROR: "ufs_qcom_phy_init_clks" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_calibrate" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_remove" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "get_ufs_qcom_phy" [drivers/phy/phy-qcom-ufs-qmp-20nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_power_off" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_power_on" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_exit" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_generic_probe" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_init_vregulators"
>> [drivers/phy/phy-qcom-ufs-qmp-14nm.ko] undefined!
>> ERROR: "ufs_qcom_phy_init_clks" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_calibrate" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "ufs_qcom_phy_remove" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>> ERROR: "get_ufs_qcom_phy" [drivers/phy/phy-qcom-ufs-qmp-14nm.ko]
>> undefined!
>>
>> This exports all of the symbols that are provided by the base library
>> module and used by the two driver modules.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: adaafaa393ef ("phy: qcom-ufs: add support for QUALCOMM Technologies
>> UFS PHY drivers")
>> ---
>>
>> The broken patch is currently in the scsi tree, so if the phy maintainer
>> thinks that my fix is correct, it should go there too.
> 
> I believe that exporting all interface functions is a good solution.
> 
>>
>> An alternative approach would be to link all three phy-qcom-ufs source
>> files into a single module.

where is this driver merged? it's not in linux-phy.

-Kishon
