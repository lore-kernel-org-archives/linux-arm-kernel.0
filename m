From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Sep 2009 02:02:02 +0800
Subject: [PATCH 4/17] pxa: enable onenand for ttcdkb board
In-Reply-To: <771cded00909142303n18a15e93leaa980e13a1a091a@mail.gmail.com>
References: <771cded00909142303n18a15e93leaa980e13a1a091a@mail.gmail.com>
Message-ID: <f17812d70909221102p2e10c0ak41399d706b446940@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 2:03 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From da4ebc9254d072b69f17b2fc2980c0b17d9d9aa8 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 9 Sep 2009 18:22:33 +0800
> Subject: [PATCH] pxa: enable onenand for ttcdkb board
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/devices.c????????????? |??? 1 +
> ?arch/arm/mach-mmp/include/mach/devices.h |??? 2 +
> ?arch/arm/mach-mmp/ttc_dkb.c????????????? |?? 77
> +++++++++++++++++++++++++++++-
> ?3 files changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
> index 548ca76..23b3ae1 100644
> --- a/arch/arm/mach-mmp/devices.c
> +++ b/arch/arm/mach-mmp/devices.c
> @@ -79,6 +79,7 @@ PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000,
> 0x10);
> ?PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE, 0xd401a400, 0x10);
> ?PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
> ?PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
> +PXA168_DEVICE(onenand, "onenand", -1, NONE, 0x80000000, 0x100000);

Mmm... this isn't really a SoC device, this should be somewhere within
board code. What about the patch below?
