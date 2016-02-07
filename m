From: slash.tmp@free.fr (Mason)
Date: Sun, 7 Feb 2016 17:04:54 +0100
Subject: Common/typical fractional divider HW API
In-Reply-To: <1454690599.31169.103.camel@linux.intel.com>
References: <56B4B67D.2080707@free.fr>
 <1454684758.31169.77.camel@linux.intel.com> <56B4C775.50808@free.fr>
 <1454688729.31169.87.camel@linux.intel.com> <56B4CDEF.3080606@free.fr>
 <1454690599.31169.103.camel@linux.intel.com>
Message-ID: <56B76B26.4050306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 17:43, Andy Shevchenko wrote:

> There are plenty of implementations of the divider.

I'd be happy to read an overview on the subject, if you have
some links to share.

> You might consider to use one than inventing new one

I find it hard to believe that the interface I'm discussing
has not been used (several times) in the past. (It's merely
a trivial floating point scheme.)

As a matter of fact, the integer divider driver supports
"I" and "2^I", so extending 2^I to "2^I * (1 + F/256)"
is an obvious step.

>> In this part of my message, I was trying to argue that one HW API
>> "2^I * (1 + F/256)" seemed better than another one "I + F/16" on
>> any hardware.
> 
> I disagree in a part 2^I.

I don't know what that means. If you speak Russian, maybe you
can write in Russian, and I'll try to figure it out.

>> Maybe the clk-fractional-divider could be made more generic by having
>> the register update part done in a call-back function?
> 
> Why do you need to touch that module at all if your hardware doesn't
> suit it?

What does it mean "your hardware doesn't suit it" ?

I am saying that if the register update were moved into a call-back
function, then any scheme could be supported. Maybe you think this
is just vague hand-waving. I'll send a patch to illustrate what
I'm saying.

Regards.
