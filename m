From: mmarek@suse.com (Michal Marek)
Date: Tue, 12 Jan 2016 16:08:14 +0100
Subject: [PATCH] kbuild: Demote 'sign-compare' warning to W=2
In-Reply-To: <1452608658-28190-1-git-send-email-lee.jones@linaro.org>
References: <1452608658-28190-1-git-send-email-lee.jones@linaro.org>
Message-ID: <569516DE.1020002@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-01-12 15:24, Lee Jones wrote:
> Ideally, a kernel compile with W=1 enabled should complete cleanly;
> however, when we run one currently we are presented with ~25k warnings.
> 'sign-compare' accounts for ~22k of those ~25k.
> 
> In this patch we're demoting 'sign-compare' warnings to W=2, with a view
> to fixing the remaining 3k W=1 warnings required for a clean build.
> 
> Arnd adds:
>   "As per our discussion, I'd add that this was inadvertedly introduced
>    by Behan when he moved the clang specific warnings into an ifdef block
>    and did not notice that -Wsign-compare was interpreted by both gcc
>    and clang.
> 
>    Earlier, it was introduced in just the same way by Jan-Simon as part
>    of 3d3d6b847420 ("kbuild: LLVMLinux: Adapt warnings for compilation
>    with clang")."
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 26ea6bb1fef0 ("kbuild, LLVMLinux: Supress warnings unless W=1-3")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to kbuild.git#kbuild.

Michal
