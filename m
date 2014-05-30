From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 May 2014 19:20:37 +0100
Subject: [PATCH v6 1/2] arm64: adjust el0_sync so that a function can be
 called
In-Reply-To: <1401399904-24471-2-git-send-email-larry.bassel@linaro.org>
References: <1401399904-24471-1-git-send-email-larry.bassel@linaro.org>
 <1401399904-24471-2-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140530182037.GH22895@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 10:45:03PM +0100, Larry Bassel wrote:
> To implement the context tracker properly on arm64,
> a function call needs to be made after debugging and
> interrupts are turned on, but before the lr is changed
> to point to ret_to_user(). If the function call
> is made after the lr is changed the function will not
> return to the correct place.
> 
> For similar reasons, defer the setting of x0 so that
> it doesn't need to be saved around the function call
> (save far_el1 in x26 temporarily instead).

  Acked-by: Will Deacon <will.deacon@arm.com>

Thanks guys!

Will
