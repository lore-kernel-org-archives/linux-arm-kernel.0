From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 18:16:54 +0800
Subject: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <4FC72DDF.7080209@codethink.co.uk>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
 <4FC72DDF.7080209@codethink.co.uk>
Message-ID: <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 4:37 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 31/05/12 02:51, Linus Walleij wrote:
>>
>> You will need some add-on patch to the db8500 device tree moving this
>> over to the AMBA (PrimeCell) bus abstraction.
>
> What does AMBA win us over the platform device here?

In Alessandro's case I guess it's that he can use his PCI-to-AMBA wrapper, and
there is no similar PCI-to platformdevice wrapper. So it saves some work
on his part.

But since the device has PrimeCell ID registers, this is really the
right thing to
do anyway, since autodetecting from hardware is allways NiceToDo(TM).
Else ST and us shouldn't have put the magic numbers (0xB105F00D) in there
anyway.

Yours,
Linus Walleij
