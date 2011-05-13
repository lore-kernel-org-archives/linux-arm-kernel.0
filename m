From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 13 May 2011 16:24:02 +0200
Subject: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
	preprocessor.
In-Reply-To: <87aaeq3fmt.fsf@ti.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>	<20110513113013.GP31483@atomide.com>	<BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>	<4DCD2260.4090806@ti.com>
	<20110513130441.GH5323@atomide.com> <87aaeq3fmt.fsf@ti.com>
Message-ID: <4DCD3F02.50104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/13/2011 3:16 PM, Hilman, Kevin wrote:
> Tony Lindgren<tony@atomide.com>  writes:
>
>> * Cousson, Benoit<b-cousson@ti.com>  [110513 15:18]:
>>>>>> Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
>>>>>
>>>> Unfortunately I don't have an automated tool, but that would be great
>>>> to have such a script. For this time I've checked the correctness of the
>>>> change comparing the preprocessed output.
>>>
>>> In fact these files are already generated automatically, as written
>>> in the header file. So changing the output format should
>>> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
>>> manually some time ago.
>>
>> Sounds like the important thing to consider here is how these macros
>> should be set up considering the upcoming generic clock framework
>> and device tree changes.
>>
>> So let's wait a few days for comments from Benoit and Paul on the
>> format for the macros so we don't need to redo them again later.
>> Of course there might be other things to consider too..
>
> ... like readability.
>
> After seeing the patch (thanks Benoit), I think this is bad tradeoff
> between readability and lines-of-code.
>
> Personally, I don't think we should be trading readability for diffstat
> goodness.  I have a strong dislike for these multi-line macros, but
> it's up to Paul/Benoit to decide how this should look.

I'm sharing the same concern and after seeing the patch, I do thing as 
well that the readability is badly impacted.
My other concern is that these macros are too low level and does not 
bring a real abstraction of clock nodes.
Any change to the clock structure we will have to do in the near future 
with the common clock fmwk will probably have an impact on this file.

So if we want to reduce the file size using that kind of approach, we'd 
better provide improved macros that will help hiding some implementation 
details. It will ease the transition to the common clock fmwk.

Last but not least, since we do want to move this file to DT ASAP, is it 
worth it?

Regards,
Benoit
