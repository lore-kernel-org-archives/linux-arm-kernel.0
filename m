From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 19 Jan 2010 13:29:43 +0800
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <4B55400C.1050109@tmtservices.co.za>
References: <201001182134.14226.epeer@tmtservices.co.za>
	<20100118215124.GE8970@buzzloop.caiaq.de>
	<4B55400C.1050109@tmtservices.co.za>
Message-ID: <f17812d71001182129v30b93f0dw72a950cec630bf10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 1:15 PM, Hennie van der Merwe
<hvdmerwe@tmtservices.co.za> wrote:
> Hi Daniel,
>
> Thanks for the comments.
>
> Daniel Mack wrote:
>>>
>>> +inline void mxm_8x10_mmc_init(void)
>>> +{
>>> +}
>>>
>>
>> You should make that inline function static.
>>
>
> I originally wrote it like this because I wanted the option for the machine
> implementing the MXM-8x10 module to initialise the MMC or not. I'm not sure
> static is appropriate (as it is exported in the header). Could we perhaps
> drop the inline and just ?make it a void __init instead?
>

You could make this declaration in .h file, e.g.

#ifdef ...
extern void mxm_8x10_mmc_init(void);
#else
static inline void mxm_8x10_mmc_init(void) {}
#endif

which will be optimized away by the compiler. Having a null global
function isn't very interesting.

>>> +inline mxm_8x10_nand_init(void)
>>> +{
>>> +}
>>
>> ?and it should return void.
>
> Agreed. This one must have just slipped by... Too much coffee, not enough
> sleep :)
>
> Thanks,
> Hennie
>
