From: slash.tmp@free.fr (Mason)
Date: Fri, 30 Oct 2015 21:12:26 +0100
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <yw1xeggdd007.fsf@unicorn.mansr.com>
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
Message-ID: <5633CF2A.4040504@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2015 19:04, M?ns Rullg?rd wrote:

> There's also something wrong with the L2C-310 aux control register
> setting.  The SMC call ID from OMAP (0x109) which is also used in some
> Sigma code I found somewhere doesn't seem to do anything, so the
> register is left at the value set by the secure boot code.  Perhaps you
> can check with your firmware guy if there's another way of writing that
> register.

IIRC, only debug firmware allows writes to L2 AUXCTRL (after filtering
some of the bits out), while production firmware ignores them completely.

IME, the smc handler should default to return ENOTSUP; that way, when
a syscall disappears due to ifdef-ery, the caller gets a meaningful
answer.

We just had an interesting internal discussion about L2 AUXCTRL.
For my education, what value would you like to write to AUXCTRL? :-)

Regards.
