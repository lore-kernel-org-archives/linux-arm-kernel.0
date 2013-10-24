From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 24 Oct 2013 16:50:25 +0200
Subject: [PATCH 2/2] ARM64: perf: wire up perf_regs and unwind support
In-Reply-To: <1382108078-8807-3-git-send-email-jean.pihet@linaro.org>
References: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
 <1382108078-8807-3-git-send-email-jean.pihet@linaro.org>
Message-ID: <20131024145025.GA1493@krava.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 04:54:38PM +0200, Jean Pihet wrote:

SNIP

> +	return -EINVAL;
> +}
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 75b93d7..15a69a5 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -29,11 +29,17 @@ ifeq ($(ARCH),x86_64)
>    NO_PERF_REGS := 0
>    LIBUNWIND_LIBS = -lunwind -lunwind-x86_64
>  endif
> +
>  ifeq ($(ARCH),arm)
>    NO_PERF_REGS := 0
>    LIBUNWIND_LIBS = -lunwind -lunwind-arm
>  endif

I dont see above 'ifeq' in acme's or in tip tree, so hunk
below fails to apply.. what tree was this based on?

otherwise the change looks good to me

jirka
