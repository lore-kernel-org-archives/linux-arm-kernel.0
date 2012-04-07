From: stigge@antcom.de (Roland Stigge)
Date: Sat, 07 Apr 2012 19:45:37 +0200
Subject: [PATCH v2] gpio: Device tree support for LPC32xx
In-Reply-To: <CAKON4OxuP6AytcJDtDvbTaho4vFvUTQ0VfJiBnN5QEbK1xo1XQ@mail.gmail.com>
References: <1333497518-25838-1-git-send-email-stigge@antcom.de>
 <20120407035327.9D7923E246E@localhost> <4F80460E.50605@antcom.de>
 <CAKON4OxuP6AytcJDtDvbTaho4vFvUTQ0VfJiBnN5QEbK1xo1XQ@mail.gmail.com>
Message-ID: <4F807D41.5000008@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/12 19:17, jonsmirl at gmail.com wrote:
>> Please consider how the groups are specified in
>> drivers/gpio/gpio-lpc32xx.c. They each have different numbers of lines
>> and GPIO / GPI / GPO functionality. So they also have different callback
>> sets, and we need to do separate gpiochip_add()s which leads to the
>> separate gpio-bank specifications in the dtsi file. Separate enabling of
>> those banks via OF are a nice by-product.
> 
> When you have six banks of 32b registers with sparse, active GPIOs in
> the banks, is there any advantage to saying bank one has 8 gpios, bank
> 2 has 14, bank 3 has 2, etc in the gpiochip?  Or just just register
> them as six banks of 32 GPIOs without indicating which are
> valid/invalid?

I think it is a good idea to only register GPIOs that are real when we
already have many (~100) instead of registering hundreds of invalid
extra ones (that will _always_ be invalid for this very driver).

Also corresponds nicely to the hardware specs when there are banks of
odd sizes which can be found registered accordingly in the kernel.

Roland
