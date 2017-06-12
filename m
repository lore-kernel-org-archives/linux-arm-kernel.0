From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Jun 2017 13:09:24 +0100
Subject: [PATCH 04/27] arm64: move generic-y of exported headers to
 uapi/asm/Kbuild
In-Reply-To: <1497238041-7011-5-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
 <1497238041-7011-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170612120923.GB24187@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 12:26:58PM +0900, Masahiro Yamada wrote:
> Since commit fcc8487d477a ("uapi: export all headers under uapi
> directories"), all (and only) headers under uapi directories are
> exported, but asm-generic wrappers are still exceptions.
> 
> scripts/Makefile.headersinst still need to deal with old-kbuild-file
> for headers listed in arch/*/include/asm/Kbuild, but actually exported.
> 
> As the last work to finish de-coupling the uapi from kernel headers,
> move generic-y of exported headers to uapi/asm/Kbuild.
> 
> For arm64, "generic-y += kvm_para.h" is doubled in asm/Kbuild and
> uapi/asm/Kbuild.  So, the one in the former can be simply removed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/include/asm/Kbuild      | 17 -----------------
>  arch/arm64/include/uapi/asm/Kbuild | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 17 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
