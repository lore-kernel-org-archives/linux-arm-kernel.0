From: sjg@chromium.org (Simon Glass)
Date: Tue, 5 Apr 2011 09:43:22 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <BANLkTik3Rf_NUNnqQLPxRdokJzFLcZPK9w@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
	<4D959058.7010606@codeaurora.org>
	<BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
	<4D981EAB.8070209@codeaurora.org>
	<BANLkTimhk_G0fapzHAf0Gc-XhqT0qu+VbQ@mail.gmail.com>
	<BANLkTinvbd9hmcsxhWQtM70uBzgv7sESTQ@mail.gmail.com>
	<BANLkTik3Rf_NUNnqQLPxRdokJzFLcZPK9w@mail.gmail.com>
Message-ID: <BANLkTima5DM6gm-1E_uGsM3cqPGd-U_how@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2011 at 9:02 AM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Hi,
>
> On Tue, Apr 5, 2011 at 12:46 AM, Simon Glass <sjg@chromium.org> wrote:
>> On Mon, Apr 4, 2011 at 7:29 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
>> ...

>>> OTOH, is not like "Use generic BUG() handler" gives the choice of
>>> removing GENERIC_BUG given that it is not prompted in menuconfig and
>>> auto selected, if this is the intention is there any reason to keep
>>> the #else part of /* not CONFIG_GENERIC_BUG */? there is no way we can
>>> use it with this patch, right?
>>
>> Well, er, the intention is that you use the patch. I kept the old code
>> around since people can then simply change the Kconfig option and be
>> back where they were, as indeed you have. I would be happy to remove
>> the old behavior, but I was concerned about a possible roasting in
>> this forum. Changing long-established behavior is sometimes tricky.
>
> Yes, but you can't change the Kconfig because it is not prompted with
> your patch, if that was the intention then an option to de/select
> GENERIC_BUG or not is needed:
>
> arch/arm/Kconfig
> @@ -204,6 +204,10 @@ config MMU
> ? ? ? ? ?Select if you want MMU-based virtualised addressing space
> ? ? ? ? ?support by paged memory management. If unsure, say 'Y'.
>
> +config GENERIC_BUG
> + ? ? ? bool "Generic BUG"
> + ? ? ? default y
> + ? ? ? depends on BUG

Yes that's right, it is a manual edit. But if there are no objections
I will create a patch to remove this and replace the old bug
infrastructure entirely. - Simon

>
> Regards,
>
> Omar
>
