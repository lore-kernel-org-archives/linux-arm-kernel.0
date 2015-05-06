From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:23:23 -0600
Subject: [PATCH v4 7/7] selftests/exec: do not install subdir as it is
 already created
In-Reply-To: <1429656733-10893-1-git-send-email-tyler.baker@linaro.org>
References: <1429656733-10893-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A783B.1050607@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:52 PM, Tyler Baker wrote:
> Remove subdir from DEPS as it is already created at runtime. Without this,
> make install fails.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/exec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index 4edb7d0..6b76bfd 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,6 +1,6 @@
>  CFLAGS = -Wall
>  BINARIES = execveat
> -DEPS = execveat.symlink execveat.denatured script subdir
> +DEPS = execveat.symlink execveat.denatured script
>  all: $(BINARIES) $(DEPS)
>  
>  subdir:
> 

Applied to linux-kselftest next for 4.2

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
