From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 16 Feb 2013 09:04:28 +0100
Subject: [PATCH] ARM:kernel: a bug by a redundancy charactor ';'
In-Reply-To: <511F2C0D.4030206@asianux.com>
References: <511F2C0D.4030206@asianux.com>
Message-ID: <511F3D8C.6090603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.02.2013 07:49, schrieb Chen Gang:
>
>    delete the redundancy charactor ';', which will cause issue.
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>   arch/arm/kernel/perf_event.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 31e0eb3..a892067 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
>   	}
>
>   	if (event->group_leader != event) {
> -		if (validate_group(event) != 0);
> +		if (validate_group(event) != 0)
>   			return -EINVAL;
>   	}

Wondering against which branch this patch is, I found that this issue 
isn't in recent mainline from today, but in -next. Introduced by the patch

ARM: perf: simplify __hw_perf_event_init err handling
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=9dcbf466559f6f2f55d60eb5a1bbebc8e694b52a

While the subject/commit message could be improved (at least 
mentioning 'perf' somehow and charactor -> character), the change 
itself looks good.

Best regards

Dirk
