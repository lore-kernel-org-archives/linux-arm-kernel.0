From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 09:29:06 +0100
Subject: [PATCH] ARM: fix v7M build for !CONFIG_PRINTK
In-Reply-To: <1421036749-5308-1-git-send-email-robh@kernel.org>
References: <1421036749-5308-1-git-send-email-robh@kernel.org>
Message-ID: <1759104.LDHVCAfBKo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 January 2015 22:25:49 Rob Herring wrote:
> 
>  __invalid_entry:
>         v7m_exception_entry
> +#ifdef CONFIG_PRINTK
>         adr     r0, strerr
>         mrs     r1, ipsr
>         mov     r2, lr
>         bl      printk
> +#endif
>         mov     r0, sp
>         bl      show_regs
>  1:     b       1b
> 

Should the show_regs call be commented out as well? While
the function is still there without printk support, I believe
it doesn't actually do anything.

	Arnd
