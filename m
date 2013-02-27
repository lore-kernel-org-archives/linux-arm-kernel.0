From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Wed, 27 Feb 2013 16:21:52 +0100
Subject: [RFC/PATCH 1/5] context tracking: conditionalize guest support
 based on CONFIG_KVM
In-Reply-To: <87621dygvw.fsf@linaro.org>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
 <1361389302-11968-2-git-send-email-khilman@linaro.org>
 <20130222132750.GE17948@somewhere.redhat.com>
 <87fw0izxe4.fsf@linaro.org> <1361916782.1740.2.camel@leonhard>
 <87621dygvw.fsf@linaro.org>
Message-ID: <CAFTL4hzFBgT-hKHEdGshoGnWwbfrANaEQonXe3O03Oe6L2=_nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/27 Kevin Hilman <khilman@linaro.org>:
> From 61e35f069a64c03a2bce348487d41072aeb9f36b Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@linaro.org>
> Date: Thu, 14 Feb 2013 10:17:37 -0800
> Subject: [PATCH] context tracking: conditionalize guest support based on
>  CONFIG_KVM
>
> So that it can build on !KVM systems too.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  kernel/context_tracking.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 74f68f4..fda6cd6 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -1,5 +1,7 @@
>  #include <linux/context_tracking.h>
> +#if IS_ENABLED(CONFIG_KVM)
>  #include <linux/kvm_host.h>
> +#endif

Please fix the header rather than its inclusion.
General purpose headers like this must be able to handle the off-cases.

Thanks.
