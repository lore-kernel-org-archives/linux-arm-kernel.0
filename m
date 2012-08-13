From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 13 Aug 2012 07:44:43 +0300
Subject: [PATCH v2] mtd: gpmi: add NAND write verify support
In-Reply-To: <1344698728-8709-1-git-send-email-shijie8@gmail.com>
References: <1344698728-8709-1-git-send-email-shijie8@gmail.com>
Message-ID: <CAF4G-tKN683_EQCGcG4G8jMU5K6TamaHUv__3ugGUoEg_LPrcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 6:25 PM, Huang Shijie <shijie8@gmail.com> wrote:
> Add NAND write verify support in gpmi-nand driver.
>
> This patch fixes a kernel crash when we select
> CONFIG_MTD_NAND_VERIFY_WRITE=y, and do some write tests:

I would just kill ONFIG_MTD_NAND_VERIFY_WRITE entirely. Some drivers
do not support it and it does not work for sub-pages for long time.
Both UBI and JFFS2 are able to read verify what they wrote already.
There are also MTD tests which do this verification. So I think there
is no reason to keep this in the NAND layer, let alone wasting RAM in
the driver to support this feature.

I am also removing the -stable mailing list - ne need to spam it.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
