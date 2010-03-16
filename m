From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 16 Mar 2010 20:49:51 +0800
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
Message-ID: <771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 7:52 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?5 -----
> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-pxa/poodle.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/plat-pxa/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?5 +++++
> ?arch/arm/plat-pxa/Makefile ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?.../include/mach => plat-pxa/include/plat}/ssp.h ? | ? ?0
> ?arch/arm/{mach-pxa => plat-pxa}/ssp.c ? ? ? ? ? ? ?| ? ?2 +-
> ?drivers/spi/pxa2xx_spi.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?sound/soc/pxa/pxa-ssp.c ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?9 files changed, 10 insertions(+), 10 deletions(-)
> ?rename arch/arm/{mach-pxa/include/mach => plat-pxa/include/plat}/ssp.h (100%)
> ?rename arch/arm/{mach-pxa => plat-pxa}/ssp.c (99%)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 8f7eb12..6dd450a 100644

Hi Eric,

I have some comments on this patch. I'm re-formating that patch in
sound-2.6 git tree and attach it for reference. I think more files
should be modified. Here's the file list in my patch.

 arch/arm/mach-pxa/Kconfig            |    5 -
 arch/arm/mach-pxa/Makefile           |    3 -
 arch/arm/mach-pxa/corgi_ssp.c        |    2 +-
 arch/arm/mach-pxa/include/mach/ssp.h |  107 -------
 arch/arm/mach-pxa/littleton.c        |    2 +-
 arch/arm/mach-pxa/poodle.c           |    4 +-
 arch/arm/mach-pxa/pxa3xx.c           |    2 +-
 arch/arm/mach-pxa/ssp.c              |  505 --------------------------------
 arch/arm/plat-pxa/Kconfig            |    5 +
 arch/arm/plat-pxa/Makefile           |    1 +
 arch/arm/plat-pxa/include/plat/ssp.h |  107 +++++++
 arch/arm/plat-pxa/ssp.c              |  527 ++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa-ssp.c              |    2 +-
 13 files changed, 646 insertions(+), 626 deletions(-)

By the way, I'm still format other patches for share more code between
pxa2xx-ssp & pxa168-sssp. Since you're updating ssp. The ssp code will
be different between your git tree and mark's asoc git tree. If my
patches are merged into asoc git tree, how to sync to your git tree?

Mark,
do you have any comments on syncing code?

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001--ARM-pxa-move-ssp-into-plat.patch
Type: application/octet-stream
Size: 35428 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100316/643de334/attachment-0001.obj>
