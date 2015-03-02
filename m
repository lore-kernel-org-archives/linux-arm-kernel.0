From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 02 Mar 2015 12:29:07 +0100
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <20150302083019.GD31325@x1> (Lee Jones's message of "Mon, 2 Mar
 2015 08:30:19 +0000")
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <87385r3uk9.fsf@free.fr> <20150227214941.GB12821@x1>
 <87sidq3ox8.fsf@free.fr> <20150302083019.GD31325@x1>
Message-ID: <87vbij1vuk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> On Sat, 28 Feb 2015, Robert Jarzmik wrote:
>
>> Lee Jones <lee.jones@linaro.org> writes:
>>     it doesn't specify which usecase is not covered by CLK_IGNORE_UNUSED, it
>>     says, up to my understanding, that is it another way to have to
>>     CLK_IGNORE_UNUSED flag applied.
>
> Well that is exactly what we're doing.  Is there an issue with that?
>
> This is a way to do it at a platform level.  It means we can support
> multiple platforms where clocksources have been switched around
> without writing new driver code in drivers/clk/st.
>
> If you have something else in mind, let me know.
>
>>  2) I still fail to see why this is necessary
>>     IOW why declaring the mandatory always-on clocks with the proper flag should
>>     be augmented with a new clock list. Isn't the existing flag the generic way
>>     ?
>
> I'm not sure what you mean by this, would you be able to expland a
> little?
>
>> I might not understand the real motivation behind that of course, that's why I'm
>> asking.
>
> Please bear in mind that we don't supply our clocks statically.  All
> of the information is extracted from DT, so if the always-on
> information does reside in there, where do you propose it comes from?

I thought the standard clock binding provided a way to set this flag. Now I
crosschecked the binding, it doesn't ...

My point was I didn't want the flag to be settable from 2 different places,
where consistency was to be kept across different device-tree leafs.

> We could just write this code inside our own driver and apply the
> CLK_IGNORE_UNUSED at a local level, but that's not the generic
> solution I am searching for.

All right, I'm convinced now I undertand the flag was not settable from
devicetree binding before this patchset.

You can add to patch 3/4 :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
