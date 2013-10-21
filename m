From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 20 Oct 2013 17:13:15 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131020235104.GT25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <52646AF9.3050309@roeck-us.net>
 <20131020235104.GT25034@n2100.arm.linux.org.uk>
Message-ID: <5264719B.5070603@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2013 04:51 PM, Russell King - ARM Linux wrote:
> On Sun, Oct 20, 2013 at 04:44:57PM -0700, Guenter Roeck wrote:
>> On 10/20/2013 04:11 PM, Russell King - ARM Linux wrote:
>>> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
>>>> The only thing we've really moved out of the kernel is the exact IDs of
>>>> which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
>>>> simple stuff not the hard stuff. The code hasn't really been simplified
>>>> by DT - if anything, it's more complicated since we now have to parse
>>>> those values from DT rather than putting them into simple data-structures.
>>>
>>> Here's my random thoughts this evening on DT, orientated mostly on a
>>> problem area I've been paying attention to recently.
>>>
>>> In some ways, DT has made things much harder.  I don't know whether
>>
>> On the other side, DT has made some things much simpler.
>
> Yes, it's made simple things easier, but note the problem I also
> pointed out towards the end of the email (I assume you stopped reading
> it towards the end?)
>

No, not really.

> DT also makes it much easier to make mistakes which take hours to find.
>

Yes, I would agree. Guess to solve this kind of problem you might need
some kind of semantics checker, one that knows all existing properties.

> DT has also made hard things much harder to solve - and because they're
> hard to solve people are hacking around the problem creating their own
> custom solutions, thereby making the problem much worse to solve in the
> future.  That's a disease - "we must have DT and sod everything else"
> is a very bad thing to do.  The bad news is, it *is* happening.
>

For the DRM problem you described in your original e-mail, frankly I don't
have an idea how to solve it. So I'd rather not even try. For the semantics
checking problems, maybe someone with some free time will step up and write
one ... if that is even feasible. But even then I suspect it will always be
easy to make mistakes in property values.

Guenter
