From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jul 2016 22:23:48 +0200
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <2773873.Jjn1O47GXr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> This patch disables deprecated IDE subsystem in assabet_defconfig
> (no IDE host drivers are selected in this config so there is no
> valid reason to enable IDE subsystem itself).
> 
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I think the series makes a lot of sense. I have checked your assertions
in the changelogs and found no flaws in your logic, so I think we should
take them all through arm-soc unless there are other concerns.

Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
how you determined that they need it?

I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
have no libata replacement, are there any others like that, or are
they all platforms that should in theory work with libata but need
testing?

	Arnd
