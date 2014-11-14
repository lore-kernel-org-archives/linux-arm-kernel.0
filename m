From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Nov 2014 17:28:06 +0000
Subject: [PATCHv4 1/5] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <1415792692-11189-2-git-send-email-punit.agrawal@arm.com>
References: <1415792692-11189-1-git-send-email-punit.agrawal@arm.com>
 <1415792692-11189-2-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141114172805.GD6755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 11:44:48AM +0000, Punit Agrawal wrote:
> +int register_undef_hook(struct undef_hook *hook)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&undef_lock, flags);
> +	list_add(&hook->node, &undef_hook);
> +	raw_spin_unlock_irqrestore(&undef_lock, flags);
> +
> +	return 0;
> +}

I missed this. Why do we need this function to return something? I don't
see how it would fail.

-- 
Catalin
