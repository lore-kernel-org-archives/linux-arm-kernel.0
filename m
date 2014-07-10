From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jul 2014 09:48:10 +0100
Subject: [RESEND PATCH v4 2/2] arm64: Add seccomp support
In-Reply-To: <53BE17AE.7080301@linaro.org>
References: <1404459115-8292-1-git-send-email-takahiro.akashi@linaro.org>
 <1404459115-8292-3-git-send-email-takahiro.akashi@linaro.org>
 <20140709111239.GH9485@arm.com> <53BE17AE.7080301@linaro.org>
Message-ID: <20140710084810.GD2449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 05:33:50AM +0100, AKASHI Takahiro wrote:
> Will,
> 
>  >  (1) Updating syscallno based on w8, but this ties us to the current ABI
>  >      and could get messy if this register changes in the future.
> 
> So, is this the conclusion that I should follow?

I think so, with the exception that if the tracer/debugger sets it to -1 to
abort the syscall, then we should restore the original value.

Will
