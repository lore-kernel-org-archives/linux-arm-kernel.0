From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 17:34:52 +0000
Subject: [PATCH v3] arm: fix a wrong value returned from CALLER_ADDRn
In-Reply-To: <1363235701-21342-1-git-send-email-kpark3469@gmail.com>
References: <1363235701-21342-1-git-send-email-kpark3469@gmail.com>
Message-ID: <20130315173452.GQ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 01:35:01PM +0900, kpark3469 at gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> This makes return_address() return a correct value for CALLER_ADDRn.
> To have a correct value from CALLER_ADDRn, we need to fix three points.
> 
> * The unwind_frame() does not update frame->lr but frame->pc for backtrace.
> So frame->pc is meaningful for backtrace.
> 
> * data.level should be adjusted by adding 2 additional iteration levels.
> With the current +1 level adjustment, the result of CALLER_ADDR1 will
> be the same return address with CALLER_ADDR0.
> 
> * The initialization of data.addr to NULL is needed.
> When unwind_fame() fails right after data.level reaches zero,
> the routine returns data.addr which has uninitialized garbage value.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>
> Reviewed-by: Dave Martin <dave.martin@linaro.org>

Please send this to the patch system.  I think we should let this sit
in -next for a bit (which we'll get anyway) to see what the effect is.
