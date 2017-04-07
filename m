From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 7 Apr 2017 11:36:48 +0200
Subject: [RFC v2][PATCH 08/11] ARM: Implement __arch_rare_write_begin/end()
In-Reply-To: <1490811363-93944-9-git-send-email-keescook@chromium.org>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
 <1490811363-93944-9-git-send-email-keescook@chromium.org>
Message-ID: <20170407093648.k2hl6dswzlz5ashh@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:16:00AM -0700, Kees Cook wrote:
> +static inline unsigned long __arch_rare_write_end(void)
> +{
> +	BUG_ON(test_domain(DOMAIN_WR_RARE, DOMAIN_CLIENT));
> +	modify_domain(DOMAIN_WR_RARE, DOMAIN_CLIENT);
> +	preempt_enable_no_resched();

NAK

> +	return 0;
> +}
