From: b32955@freescale.com (Huang Shijie)
Date: Mon, 13 Aug 2012 13:09:34 +0800
Subject: [PATCH v2] mtd: gpmi: add NAND write verify support
In-Reply-To: <CAF4G-tKN683_EQCGcG4G8jMU5K6TamaHUv__3ugGUoEg_LPrcQ@mail.gmail.com>
References: <1344698728-8709-1-git-send-email-shijie8@gmail.com>
 <CAF4G-tKN683_EQCGcG4G8jMU5K6TamaHUv__3ugGUoEg_LPrcQ@mail.gmail.com>
Message-ID: <50288C0E.5060400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?08?13? 12:44, Artem Bityutskiy ??:
> On Sat, Aug 11, 2012 at 6:25 PM, Huang Shijie<shijie8@gmail.com>  wrote:
>> Add NAND write verify support in gpmi-nand driver.
>>
>> This patch fixes a kernel crash when we select
>> CONFIG_MTD_NAND_VERIFY_WRITE=y, and do some write tests:
> I would just kill ONFIG_MTD_NAND_VERIFY_WRITE entirely. Some drivers
> do not support it and it does not work for sub-pages for long time.
> Both UBI and JFFS2 are able to read verify what they wrote already.
> There are also MTD tests which do this verification. So I think there
> is no reason to keep this in the NAND layer, let alone wasting RAM in
> the driver to support this feature.
>
> I am also removing the -stable mailing list - ne need to spam it.
>
thanks a lot. Maybe we should send a patch to remove the 
CONFIG_MTD_NAND_VERIFY_WRITE feature entirely.

Huang Shijie
