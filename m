From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 15:05:20 +0100
Subject: [PATCH] kbuild: Demote 'sign-compare' warning to W=2
In-Reply-To: <1452605519-26797-1-git-send-email-lee.jones@linaro.org>
References: <1452605519-26797-1-git-send-email-lee.jones@linaro.org>
Message-ID: <5357543.n41BTU6AbM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 13:31:59 Lee Jones wrote:
> Ideally, a kernel compile with W=1 enabled should complete cleanly;
> however, when we run one currently we are presented with ~25k warnings.
> 'sign-compare' accounts for ~22k of those ~25k.
> 
> In this patch we're demoting 'sign-compare' warnings to W=2, with a view
> to fixing the remaining 3k W=1 warnings required for a clean build.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 

As per our discussion, I'd add that this was inadvertedly introduced
by Behan when he moved the clang specific warnings into an ifdef block
and did not notice that -Wsign-compare was interpreted by both gcc
and clang.

Earlier, it was introduced in just the same way by Jan-Simon as part
of 3d3d6b847420 ("kbuild: LLVMLinux: Adapt warnings for compilation with clang").

The new patch looks good to me, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 26ea6bb1fef0 ("kbuild, LLVMLinux: Supress warnings unless W=1-3")

I've started looking into building the kernel with clang, and will likely
follow up with further unrelated changes to the list, as clang-3.9
seems to generate a couple of extra warnings we want to suppress.

	Arnd
