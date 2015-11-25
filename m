From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 25 Nov 2015 13:39:36 +0900
Subject: [PATCH v6 2/6] arm64: pass a task parameter to unwind_frame()
In-Reply-To: <70D4F7ED-B4CF-4AC0-B85A-2491786847FC@gmail.com>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-3-git-send-email-takahiro.akashi@linaro.org>
 <70D4F7ED-B4CF-4AC0-B85A-2491786847FC@gmail.com>
Message-ID: <56553B88.6090507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 10:42 PM, Jungseok Lee wrote:
> On Nov 18, 2015, at 3:43 PM, AKASHI Takahiro wrote:
>> The change here doesn't make any difference in this patch, but is
>> a preparation for later fixing a problem where stacktrace functions,
>> unwind_frame() and walk_stackframe(), may return useless call stacks
>> under function graph tracer.
>
> I'm aligned with the argument. The case cannot be handled correctly
> without ret_stack[] of struct task_struct.

Thanks. I will add some description about why we need 'tsk' in a commit message.

-Takahiro AKASHI

> Best Regards
> Jungseok Lee
>
