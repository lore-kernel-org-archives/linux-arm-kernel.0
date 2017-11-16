From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:50:12 +0000
Subject: [PATCH v2 10/18] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <20171115213428.22559-11-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-11-samitolvanen@google.com>
Message-ID: <20171116115012.GE9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:20PM -0800, Sami Tolvanen wrote:
> CONFIG_CLANG_LTO depends on GNU gold and due to a known bug, the
> linker crashes when ARM64_MODULE_PLTS is enabled:
> 
>   https://sourceware.org/bugzilla/show_bug.cgi?id=14592
> 
> To work around the problem, this change removes NOLOAD from .plt
> and .init.plt, which allows us to link modules with ld.gold.

Why don't we just not do LTO if the toolchain is busted? This feels like
it will end up being a game of whack-a-mole as code could be introduced
that tickles known bugs on older toolchains.

Will
