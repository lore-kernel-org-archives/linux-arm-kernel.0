From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 15 Nov 2011 19:31:24 +0800
Subject: [PATCH] ARM: mmp: encode device id into {pxa168, pxa910,
 mmp2}_add_*()
In-Reply-To: <1321327657-26790-1-git-send-email-eric.y.miao@gmail.com>
References: <1321327657-26790-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <CAN1soZxur0V8sn0WFCSEtJyOAcT06PZCXTpGQwgLDGMzrXh7_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 11:27 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Use
>
> ?pxa168_add_uart1();
>
> instead of
>
> ?pxa168_add_uart(1);
>
> to further eliminate the parameter passing to the function, which
> could be error prone, and also making the code a bit simpler and
> faster.
>
> Idea came from Russell King.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ?| ? ?6 +-
> ?arch/arm/mach-mmp/avengers_lite.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/brownstone.c ? ? ? ? ?| ? 10 ++--
> ?arch/arm/mach-mmp/flint.c ? ? ? ? ? ? ? | ? ?4 +-
> ?arch/arm/mach-mmp/gplugd.c ? ? ? ? ? ? ?| ? ?6 +-
> ?arch/arm/mach-mmp/include/mach/mmp2.h ? | ? 70 +++++++++++++-----------------
> ?arch/arm/mach-mmp/include/mach/pxa168.h | ? 72 +++++++++++-------------------
> ?arch/arm/mach-mmp/include/mach/pxa910.h | ? 51 ++++++++--------------
> ?arch/arm/mach-mmp/jasper.c ? ? ? ? ? ? ?| ? ?8 ++--
> ?arch/arm/mach-mmp/tavorevb.c ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mmp/teton_bga.c ? ? ? ? ? | ? ?4 +-
> ?arch/arm/mach-mmp/ttc_dkb.c ? ? ? ? ? ? | ? ?4 +-
> ?12 files changed, 100 insertions(+), 139 deletions(-)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
