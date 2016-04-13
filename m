From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Wed, 13 Apr 2016 17:58:03 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <CAOMZO5D80VWGad7Lz+Crp8on5xLJzHDXL88FBh7x8d4Mc2XKww@mail.gmail.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
 <CAOMZO5D80VWGad7Lz+Crp8on5xLJzHDXL88FBh7x8d4Mc2XKww@mail.gmail.com>
Message-ID: <570EB2DB.20707@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 11-04-2016 22:04, Fabio Estevam wrote:
> Hi Sergio,
>
> On Mon, Apr 11, 2016 at 9:25 PM, Sergio Prado
> <sergio.prado@e-labworks.com> wrote:
>> Embest MarS Board [1] is a multi-core platform based on Freescale i.MX6
>> Cortex-A9 Dual Core, running up to 1GHz with 1 GB of RAM, 4GB of eMMC
>> and with a 4MB SPI flash.
>>
>> [1] http://www.embest-tech.com/shop/star/marsboard.html
>>
>> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> Can't the Mars board re-use arch/arm/boot/dts/imx6dl-riotboard.dts ?
>

Although the boards are similar, there are a lot of differences:

Marsboard -> imx6dual, no sound, sst25vf016b spi flash, 1 external 
sd/mmc interface (sdhc2) and one eMMC (sdhc3), different PMUX config for 
no sdhc3, no pmic, i2c1, i2c2 and i2c3 externally available, no ssi 
interface.

Riotboard -> imx6solo, sound (sgtl5000), no spi flash, 2 external sd/mmc 
interface (sdhc2 and sdhc3) and one eMMC (sdhc4), pmic (pfuze100), i2c1, 
i2c2 and i2c4 externally available, ssi interface.

We could certainly create a dtsi file to be shared between them, but I 
do not know if it is worth the effort.

What do you think?

Best regards,

Sergio Prado
