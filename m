From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Wed, 31 Oct 2012 12:38:09 +0900
Subject: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
In-Reply-To: <20121030114428.45752bd0@skate>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
 <20121030114428.45752bd0@skate>
Message-ID: <CABMQnV+=+Crza9kjFk8jB5-1OXXhfFamLFd-3aGz=66g-Yh9sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 7:44 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Nobuhiro Iwamatsu,
>
> On Tue, 30 Oct 2012 19:39:41 +0900, Nobuhiro Iwamatsu wrote:
>> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
>> This validates to use mv64xxx in this SoC.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>>  drivers/i2c/busses/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 65dd599..ff53cf4 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -474,7 +474,7 @@ config I2C_MPC
>>
>>  config I2C_MV64XXX
>>       tristate "Marvell mv64xxx I2C Controller"
>> -     depends on (MV64X60 || PLAT_ORION)
>> +     depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)
>>       help
>>         If you say yes to this option, support will be included for the
>>         built-in I2C interface on the Marvell 64xxx line of host bridges.
>
> This is not needed: ARCH_MVEBU already selects PLAT_ORION.
>

Oh, I see. Thanks!

Nobuhiro
-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
