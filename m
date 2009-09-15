From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 15 Sep 2009 21:58:19 +0300
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253032210.3273.128.camel@linux-1lbu>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
Message-ID: <94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 7:30 PM, Steve Chen <schen@mvista.com> wrote:
> On Tue, 2009-09-15 at 15:41 +0200, Marek Vasut wrote:
>> > -#if 0
>> > +#if CONFIG_OLD_CPU_DELAY
>>
>> ifdef please
>>
> I assume this a vote in favor of considering this patch as an
> alternative :) ?The updated patch is below. ?Since I'm only summarizing
> the e-mail thread and put them into a patch (which is a less time
> consuming process than continue reading and deleting e-mails on this
> thread), contributors can add signed off before submitting to Russel.
>
> Document #if 0 code block in delay.S and make it selectable for compile.

Nice :)

A few nitpicks though:

> Signed-off-by: Steve Chen <schen@mvista.com>
>
> ---
>
> ?arch/arm/Kconfig ? ? | ? ?8 ++++++++
> ?arch/arm/lib/delay.S | ? ?2 +-
> ?2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..ca8d535 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,6 +813,14 @@ config ARM_ERRATA_460075
> ? ? ? ? ?ACTLR register. Note that setting specific bits in the ACTLR
> register
> ? ? ? ? ?may not be available in non-secure mode.
>
> +config OLD_CPU_DELAY
> + ? ? ? depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> + ? ? ? bool "Accurate delays for older CPU"

s/older CPU/old CPUs/

Or even better, since this option will only appear on older CPUs:
"Accurate delays"

> + ? ? ? def_bool n
> + ? ? ? help
> + ? ? ? ? Enable if observing longer than expected delays and need more
> + ? ? ? ? accurate delays on older CPUs.

How about:
> +         Enable if observing longer than expected delays and need more
> +         accuracy. This should only be considered for old CPUs (e.g. foo, bar).

Cheers.

-- 
Felipe Contreras
