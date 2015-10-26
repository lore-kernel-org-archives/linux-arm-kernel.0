From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 26 Oct 2015 14:00:51 +0000
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562E20B2.4050805@codeaurora.org>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
 <562E20B2.4050805@codeaurora.org>
Message-ID: <562E3213.8070602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 26/10/15 12:46, Timur Tabi wrote:
> Andre Przywara wrote:
>> I tried to refactor the driver lately to split up SBSA and PL011 support
>> and got something that compiles, though I wasn't fully satisfied and I
>> ran out of time. The refactor idea was to split driver runtime from
>> initialization, so the different probe and init functions can be moved
>> into separate files. There would be one stub file with all the core
>> driver logic (DMA, IRQ handling, buffer handling, communication
>> parameters setup) and one file for each subtype (PL011, SBSA, ZTE, you
>> name it).
>> If people are interested, I can try to clean this up and post it as an
>> RFC.
> 
> I am interested.  We need support for subtype 13, because our hardware
> only supports 32-bit access to all registers. 

Yeah, I was interested in that scenario too, because the SBSA spec
actually speaks of 32-bit registers and vendors may implement it
strictly as that. Still waiting for actual failure reports on this
before I wanted to push a fix, though.

> We have an internal patch
> that replaces all of the read/write routines with vendor function calls.
>  I would need to refactor our patch on top of yours.

But wouldn't Jun's patch address this more easily, because it wraps
every call already? TBH I found this change the most interesting.

I will prepare something this week.

Cheers,
Andre.
