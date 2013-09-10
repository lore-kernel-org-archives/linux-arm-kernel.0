From: dsahern@gmail.com (David Ahern)
Date: Tue, 10 Sep 2013 12:14:30 -0700
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case .eh_frame
 is not present
In-Reply-To: <1378720815-23964-4-git-send-email-jean.pihet@linaro.org>
References: <1378720815-23964-1-git-send-email-jean.pihet@linaro.org>
 <1378720815-23964-4-git-send-email-jean.pihet@linaro.org>
Message-ID: <522F6F96.8030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/9/13 3:00 AM, Jean Pihet wrote:
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 7014373..54532b8 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -222,7 +222,7 @@ endif
>
>   FLAGS_UNWIND=$(LIBUNWIND_CFLAGS) $(CFLAGS) $(LIBUNWIND_LDFLAGS) $(LDFLAGS) $(EXTLIBS) $(LIBUNWIND_LIBS)
>   ifneq ($(call try-cc,$(SOURCE_LIBUNWIND),$(FLAGS_UNWIND),libunwind),y)
> -  msg := $(warning No libunwind found, disabling post unwind support. Please install libunwind-dev[el] >= 0.99);
> +  msg := $(warning No libunwind found, disabling post unwind support. Please install libunwind-dev[el] >= 1.1);
>     NO_LIBUNWIND := 1
>   endif # Libunwind support
>   endif # NO_LIBUNWIND

Is the 1.1 version required for x86 too?

David
