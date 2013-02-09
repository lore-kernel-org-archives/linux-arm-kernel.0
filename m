From: nerv@dawncrow.de (=?ISO-8859-1?Q?Andr=E9_Hentschel?=)
Date: Sat, 09 Feb 2013 17:44:21 +0100
Subject: [PATCH] arm: Preserve TPIDRURW on context switch
In-Reply-To: <20130208154809.GF3495@mudshark.cambridge.arm.com>
References: <5112DC7E.4020108@dawncrow.de>
 <20130206225150.GL17833@n2100.arm.linux.org.uk>
 <5112E0C3.1080706@dawncrow.de>
 <20130208154809.GF3495@mudshark.cambridge.arm.com>
Message-ID: <51167CE5.6060303@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2013 16:48, schrieb Will Deacon:
> On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr? Hentschel wrote:
>> Am 06.02.2013 23:51, schrieb Russell King - ARM Linux:
>>> On Wed, Feb 06, 2013 at 11:43:10PM +0100, Andr? Hentschel wrote:
>>>> There are more and more applications coming to WinRT, Wine could support them,
>>>> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
>>>> This register must be preserved per thread instead of being cleared.
>>>
>>> I'd prefer this was done a little more sensitively to those CPUs where
>>> loads/stores are expensive, namely:
>>>
>>>> +
>>>> +	@ preserve TPIDRURW register state
>>>> +	get_tls2	r3, r4, r5
>>>> +	str	r3, [r1, #TI_TP2_VALUE]
>>>> +	ldr	r3, [r2, #TI_TP2_VALUE]
>>>> +	set_tls2	r3, r4, r5
>>>
>>> those two loads/stores get omitted from the thread switching if the CPU
>>> doesn't support it.  Do you think that's something you could do?
>>
>> No, i'm not sure how to improve this. How does the process can continue, can you or someone else fix that and add his Signed-off-by?
> 
> How about something like the (completely untested) diff below?
> 
> Andre: if this works for you, I'm happy to write a commit message etc.
> 
> Cheers,
> 
> Will
> 
> --->8

I'll try the next days and report back, thx.
-- 

Best Regards, Andr? Hentschel
