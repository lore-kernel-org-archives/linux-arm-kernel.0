From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 20 Feb 2012 17:09:40 +0200
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <5e2eb160cb46960b705b71145f4d03c4@mail.fqingenieria.es>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
 <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
 <20120220135155.GC9921@sapphire.tkos.co.il>
 <5e2eb160cb46960b705b71145f4d03c4@mail.fqingenieria.es>
Message-ID: <20120220150940.GE9921@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi joancarles,

On Mon, Feb 20, 2012 at 03:40:35PM +0100, joancarles wrote:
> Hi Baruch
> >MTD support in your kernel seems to be missing.
> 
> Yep, kind of, even tough:
> 
> $> grep "^CONFIG.MTD" .config
> CONFIG_MTD=y
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_CHAR=y
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> CONFIG_MTD_CFI=y
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> CONFIG_MTD_CFI_NOSWAP=y
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_PHYSMAP=y
> 
> >What kind of flash do you have on your board? NOR? NAND?
> 
> That's most probably the culprit, thanks. We have a NOR flash, so I
> need to find a way to enable it. Funny enough, our working 2.6.39.3

Please send the console output of the working kernel.

Just a shot in the dark: have you looked into pin muxing?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
