From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 1 Nov 2015 17:30:03 +0900
Subject: [PATCH v4 6/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1446182741-31019-7-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
 <1446182741-31019-7-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <9BDC406F-52E1-4F8C-8245-7B49EC4C861D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 30, 2015, at 2:25 PM, AKASHI Takahiro wrote:

Hi Akashi,

> Stack tracer on arm64, check_stack(), is uniqeue in the following
> points:
> * analyze a function prologue of a traced function to estimate a more
>  accurate stack pointer value, replacing naive '<child's fp> + 0x10.'
> * use walk_stackframe(), instead of slurping stack contents as orignal
>  check_stack() does, to identify a stack frame and a stack index (height)
>  for every callsite.
> 
> Regarding a function prologue analyzer, there is no guarantee that we can
> handle all the possible patterns of function prologue as gcc does not use
> any fixed templates to generate them. 'Instruction scheduling' is another
> issue here.
> Nevertheless, the current version will surely cover almost all the cases
> in the kernel image and give us useful information on stack pointers.

Can I get an idea on how to test the function prologue analyzer? It pretty
tough to compare stack trace data with objdump one. Is there an easier way
to observe this enhancement without objdump?

Best Regards
Jungseok Lee
