From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 28 Mar 2013 10:07:00 +0530
Subject: [PATCH] ARM: davinci: use is IS_ENABLED macro
In-Reply-To: <20130327214347.f2a573510416b86223c58be1@canb.auug.org.au>
References: <1364210495-7938-1-git-send-email-prabhakar.csengg@gmail.com>
 <20130327214347.f2a573510416b86223c58be1@canb.auug.org.au>
Message-ID: <CA+V-a8urWyzaU-nKh7sumr3tbmswixzWsumVHMpis6=fgD3Z+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Wed, Mar 27, 2013 at 4:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi,
>
> On Mon, 25 Mar 2013 16:51:35 +0530 Prabhakar lad <prabhakar.csengg@gmail.com> wrote:
>>
>> --- a/arch/arm/mach-davinci/board-da830-evm.c
>> +++ b/arch/arm/mach-davinci/board-da830-evm.c
>> @@ -298,7 +298,7 @@ static const short da830_evm_emif25_pins[] = {
>>       -1
>>  };
>>
>> -#if defined(CONFIG_MMC_DAVINCI) || defined(CONFIG_MMC_DAVINCI_MODULE)
>> +#if IS_ENABLED(CONFIG_MMC_DAVINCI)
>>  #define HAS_MMC      1
>>  #else
>>  #define HAS_MMC      0
>
> Why not
>
> #define HAS_MMC         IS_ENABLED(CONFIG_MMC_DAVINCI)
>
> and similarly in the rest?
>
Stephen's suggestion looks good to me, if you haven?t queued it i'll post a v2,
or if you have already queued it I'll create a patch on top of the
same patch fixing it.
lemme know how would you want it.

Regards,
--Prabhakar

> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
