From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 02 Apr 2015 11:28:23 -0600
Subject: [PATCH 2/6] selftest/kdbus: enable cross compilation
In-Reply-To: <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
 <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
Message-ID: <551D7C37.8030701@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2015 05:20 PM, Tyler Baker wrote:
> Use the CC variable instead of hard coding gcc and include lib.mk.
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>

Greg,

Will you be able to take this patch in with the other
kdbus sleftest patches?

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah

> ---
>  tools/testing/selftests/kdbus/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kdbus/Makefile b/tools/testing/selftests/kdbus/Makefile
> index f6cfab2..de8242f 100644
> --- a/tools/testing/selftests/kdbus/Makefile
> +++ b/tools/testing/selftests/kdbus/Makefile
> @@ -33,11 +33,13 @@ OBJS= \
>  
>  all: kdbus-test
>  
> +include ../lib.mk
> +
>  %.o: %.c
> -	gcc $(CFLAGS) -c $< -o $@
> +	$(CC) $(CFLAGS) -c $< -o $@
>  
>  kdbus-test: $(OBJS)
> -	gcc $(CFLAGS) $^ $(LDLIBS) -o $@
> +	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@
>  
>  run_tests:
>  	./kdbus-test --tap
> 


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
