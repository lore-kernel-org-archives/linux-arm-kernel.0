From: anup.patel@broadcom.com (Anup Patel)
Date: Thu, 14 Apr 2016 08:43:55 +0530
Subject: [PATCH v2 1/5] phy: Rename phy-brcmstb-sata driver to
 phy-brcm-sata driver
In-Reply-To: <570E507C.4040306@ti.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-2-git-send-email-anup.patel@broadcom.com>
 <570E507C.4040306@ti.com>
Message-ID: <CAALAos_4MVsc0A9fCTgqCgBBU4p4rCqzhJ3zPJs=jzJMqtekGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Wed, Apr 13, 2016 at 7:28 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Monday 28 March 2016 10:18 AM, Anup Patel wrote:
>> Currently, we have a common SATA3 PHY driver for all Broadcom
>> STB SoCs. This driver can be extended and re-used for Broadcom
>> iProc SoCs having same SATA3 PHY.
>>
>> This patch renames existing Broadcom STB SATA3 PHY driver to
>> common Broadcom SATA3 PHY driver to share this PHY driver across
>> Broadcom SoCs.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  drivers/phy/Kconfig                                 | 18 +++++++++---------
>>  drivers/phy/Makefile                                |  2 +-
>>  drivers/phy/{phy-brcmstb-sata.c => phy-brcm-sata.c} |  8 ++++----
>>  3 files changed, 14 insertions(+), 14 deletions(-)
>>  rename drivers/phy/{phy-brcmstb-sata.c => phy-brcm-sata.c} (97%)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 26566db..c0187a7 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -403,15 +403,6 @@ config PHY_TUSB1210
>>       help
>>         Support for TI TUSB1210 USB ULPI PHY.
>>
>> -config PHY_BRCMSTB_SATA
>> -     tristate "Broadcom STB SATA PHY driver"
>> -     depends on ARCH_BRCMSTB || BMIPS_GENERIC
>> -     depends on OF
>> -     select GENERIC_PHY
>> -     help
>> -       Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
>> -       Likely useful only with CONFIG_SATA_BRCMSTB enabled.
>> -
>>  config PHY_CYGNUS_PCIE
>>       tristate "Broadcom Cygnus PCIe PHY driver"
>>       depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
>> @@ -421,4 +412,13 @@ config PHY_CYGNUS_PCIE
>>         Enable this to support the Broadcom Cygnus PCIe PHY.
>>         If unsure, say N.
>>
>> +config PHY_BRCM_SATA
>
> changing config name should be done with utmost care as it might break
> oldconfig users.
> Has this been fixed in all the defconfigs where it is included?

None of the existing defconfigs have PHY_BRCMSTB_SATA enabled. In fact,
no other Kconfig option currently selects PHY_BRCMSTB_SATA. I think we
are safe here.

Regards,
Anup
