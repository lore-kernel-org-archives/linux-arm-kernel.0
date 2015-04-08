From: geoff@infradead.org (Geoff Levand)
Date: Wed, 08 Apr 2015 10:14:19 -0700
Subject: [PATCH 0/6] arm64 kexec kernel patches V8
In-Reply-To: <55250E2A.80106@arm.com>
References: <cover.1426793116.git.geoff@infradead.org> <55250E2A.80106@arm.com>
Message-ID: <1428513259.11876.5.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2015-04-08 at 12:16 +0100, Suzuki K. Poulose wrote:
> Btw, I get the following build failure for kexec-tools master branch, 
> with Linaro tool chain (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro 
> GCC 4.9-2014.09 )
> 
>   $ ./configure --host=aarch64-linux-gnu
>   [...]
>   $ make -j4
> kexec/arch/arm64/kexec-arm64.c: In function ?machine_verify_elf_rel?:
> kexec/arch/arm64/kexec-arm64.c:970:29: error: ?EM_AARCH64? undeclared 

I guess that toolchain is using some ancient headers.  As a workaround
you can use configure CPPFLAGS='-DEM_AARCH64=183'.

-Geoff
