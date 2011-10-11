From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 16:09:37 +0200
Subject: [PATCH 8/9] ARM: SPMP8000: Add support for the Letcool board
In-Reply-To: <1318178172-7965-9-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-9-git-send-email-zoss@devai.org>
Message-ID: <201110111609.37425.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 October 2011, Zoltan Devai wrote:
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
>  arch/arm/mach-spmp8000/board_letcool.c           |  154 ++++++++++++++++++++++
>  arch/arm/mach-spmp8000/include/mach/spmp8000fb.h |   32 +++++
>  2 files changed, 186 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-spmp8000/board_letcool.c
>  create mode 100644 arch/arm/mach-spmp8000/include/mach/spmp8000fb.h

Hi Zoltan,

We basically stopped doing board files for new platforms. Please get
rid of this and make sure that the spmp8000-letcool.dts describes
everything you need to get this board running. The DT_MACHINE_START
part should just be part of the core.c file and not mention the 
board name, since its intended to apply to all boards with this
SOC.

	Arnd
