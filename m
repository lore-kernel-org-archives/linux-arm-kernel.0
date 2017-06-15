From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jun 2017 18:42:32 +0100
Subject: [PATCH 5/5] arm64: signal: Allow expansion of the signal frame
In-Reply-To: <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170615174231.GE17424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 03:03:42PM +0100, Dave P Martin wrote:
> This patch defines an extra_context signal frame record that can be
> used to describe an expanded signal frame, and modifies the context
> block allocator and signal frame setup and parsing code to create,
> populate, parse and decode this block as necessary.
> 
> To avoid abuse by userspace, parse_user_sigframe() attempts to
> ensure that:
> 
>  * no more than one extra_context is accepted;
>  * the extra context data is a sensible size, and properly placed
>    and aligned.
> 
> The extra_context data is required to start at the first 16-byte
> aligned address immediately after the dummy terminator record
> following extra_context in rt_sigframe.__reserved[] (as ensured
> during signal delivery).  This serves as a sanity-check that the
> signal frame has not been moved or copied without taking the extra
> data into account.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
