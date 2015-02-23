From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Feb 2015 16:26:06 +0100
Subject: [PATCH] [media] s5p-jpeg: Fix crash in jpeg isr due to multiple
 interrupts.
In-Reply-To: <1418797512-30226-1-git-send-email-tony.kn@samsung.com>
References: <1418797512-30226-1-git-send-email-tony.kn@samsung.com>
Message-ID: <54EB468E.2050505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/14 07:25, Tony K Nadackal wrote:
> In case of corrupt images, multiple interrupts may occur
> due to different error scenarios.
> 
> Since we are removing the src and dest buffers in the first
> interrupt itself, crash occurs in the second error interrupts.
> 
> Disable the global interrupt before we start processing
> the interrupt avoid the crash.
> 
> Disable System interrupt in isr to avoid the crash below.

Rather than disabling all interrupts, is there no way to check
the interrupt reason from some status register and decide
whether we return the buffers or just ignore the interrupt ?

-- 
Thanks,
Sylwester
