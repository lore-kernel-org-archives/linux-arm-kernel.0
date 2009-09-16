From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 17 Sep 2009 00:21:11 +0400
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253112555.3273.164.camel@linux-1lbu>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>	<20090915103739.GA19519@elf.ucw.cz>	<1253017761.3273.117.camel@linux-1lbu>	<200909151541.08852.marek.vasut@gmail.com>	<1253032210.3273.128.camel@linux-1lbu>	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>	<1253043875.3273.131.camel@linux-1lbu>	<m3k4zzdimy.fsf@intrepid.localdomain>	<1253053609.3273.139.camel@linux-1lbu>	<m33a6nddvd.fsf@intrepid.localdomain>	<1253089566.3273.152.camel@linux-1lbu>	<m3ljkfoywm.fsf@intrepid.localdomain>
	<1253112555.3273.164.camel@linux-1lbu>
Message-ID: <4AB148B7.90306@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Steve Chen wrote:

>>> +config OLD_CPU_DELAY
>>> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
>>> +	bool "Accurate delays for some older CPUs"
>>> +	def_bool n
>>> +	help
>>> +	  Try enable this if observing longer than expected delays and need
>>> +	  more accuracy.  May cause instability in some CPUs.
>>> +
>>>       
>> There is still this uncertain "accurate" in the text. Why don't just
>>
>> +	bool "Different delay() code for some older CPUs"
>>     
>
> Sounds good.  I also update text under help to better quantify
> "accuracy".  Updated patch below.  Separately, as Russel pointed out,
> this should only be done by experienced people, so we even bother with
> this patch since the only people should touch this are the people who
> knows all the details.
>
> Document #if 0 code block in delay.S and make it selectable for compile.
>
> Signed-off-by: Steve Chen <schen@mvista.com>
>
> ---
>
>  arch/arm/Kconfig     |    8 ++++++++
>  arch/arm/lib/delay.S |    2 +-
>  2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..ca8d535 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,6 +813,14 @@ config ARM_ERRATA_460075
>  	  ACTLR register. Note that setting specific bits in the ACTLR
> register
>  	  may not be available in non-secure mode.
>  
> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Different delay() code for some older CPUs"
> +	def_bool n
> +	help
> +	  Try enable this if observing longer than expected delays.  This code
>   

   Only "enabling"... ;-)

WBR, Sergei
