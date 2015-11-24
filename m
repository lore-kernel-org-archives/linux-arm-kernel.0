From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 24 Nov 2015 23:22:17 +0900
Subject: [PATCH v6 1/6] arm64: ftrace: modify a stack frame in a safe way
In-Reply-To: <1447828989-4980-2-git-send-email-takahiro.akashi@linaro.org>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <FA6B3A9B-BE88-40B6-9334-1D5E13F12E91@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 18, 2015, at 3:43 PM, AKASHI Takahiro wrote:
> Function graph tracer modifies a return address (LR) in a stack frame by
> calling ftrace_prepare_return() in a traced function's function prologue.
> The current code does this modification before preserving an original
> address at ftrace_push_return_trace() and there is always a small window
> of inconsistency when an interrupt occurs.
> 
> This doesn't matter, as far as an interrupt stack is introduced, because
> stack tracer won't be invoked in an interrupt context. But it would be
> better to proactively minimize such a window by moving the LR modification
> after ftrace_push_return_trace().

There are two statements in my mind: 1)IRQ stack will be introduced on ARM64
in the future and 2)This change makes subtle variance compared to ARM and x86.
I'm not sure about this patch from those perspectives.

However, I have no objection to the change. I will piggyback on other folks
regarding this patch :)

Best Regards
Jungseok Lee
