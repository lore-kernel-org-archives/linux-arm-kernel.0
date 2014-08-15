From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Sat, 16 Aug 2014 00:23:39 +0900
Subject: [PATCH v4] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <1407819388-52145-1-git-send-email-wangnan0@huawei.com>
References: <1407819388-52145-1-git-send-email-wangnan0@huawei.com>
Message-ID: <53EE25FB.4070201@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/08/12 13:56), Wang Nan wrote:
> +/* Caller must ensure addr & 3 == 0 */
> +static int can_optimize(unsigned long paddr)
> +{
> +	return 1;
> +}

As we have talked on another thread, we'd better filter-out all stack-pushing
instructions here, since (as you said) that will corrupt pt_regs on the stack.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
