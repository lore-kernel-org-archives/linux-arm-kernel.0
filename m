From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 29 Nov 2010 07:52:47 +0100
Subject: [PATCH 9/9] ARM: S5PV310: Add audio platform devices
In-Reply-To: <1290072077-17573-1-git-send-email-jassisinghbrar@gmail.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
	<1290072077-17573-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <000201cb8f92$0abbd430$20337c90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, November 18, 2010 10:21 AM Jassi Brar wrote:

> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Define platform devices for all audio devices found on S5PV310
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Makefile            |    1 +
>  arch/arm/mach-s5pv310/dev-audio.c         |  364 +++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/include/mach/map.h  |   16 ++
>  arch/arm/plat-samsung/include/plat/devs.h |    9 +
>  4 files changed, 390 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/dev-audio.c
> 
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index d265adb..61e3cb6 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
> 
>  # device support
> 
> +obj-y += dev-audio.o

Why do you compile in audio support unconditionally? All other devices have the
respective Kconfig entry, so please add one for audio and use it. We really don't
want to have all devices compiled into the kernel all the times for all the boards.

<snip>

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
