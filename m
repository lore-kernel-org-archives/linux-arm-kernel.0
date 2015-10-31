From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 31 Oct 2015 15:41:57 +0000
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <5633CF2A.4040504@free.fr> (Mason's message of "Fri, 30 Oct 2015
 21:12:26 +0100")
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
 <5633CF2A.4040504@free.fr>
Message-ID: <yw1xpozvavui.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 29/10/2015 19:04, M?ns Rullg?rd wrote:
>
>> There's also something wrong with the L2C-310 aux control register
>> setting.  The SMC call ID from OMAP (0x109) which is also used in some
>> Sigma code I found somewhere doesn't seem to do anything, so the
>> register is left at the value set by the secure boot code.  Perhaps you
>> can check with your firmware guy if there's another way of writing that
>> register.
>
> IIRC, only debug firmware allows writes to L2 AUXCTRL (after filtering
> some of the bits out), while production firmware ignores them completely.
>
> IME, the smc handler should default to return ENOTSUP; that way, when
> a syscall disappears due to ifdef-ery, the caller gets a meaningful
> answer.
>
> We just had an interesting internal discussion about L2 AUXCTRL.
> For my education, what value would you like to write to AUXCTRL? :-)

The best value to use depends on the workload, so it would be nice to be
able to control all the purely performance related bits.  I see no
possible benefit in restricting the non-secure kernel from writing
these.

-- 
M?ns Rullg?rd
mans at mansr.com
