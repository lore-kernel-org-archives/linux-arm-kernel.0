From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 18:31:43 +0100
Subject: [PATCH 1/2] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <201211151225.31066.arnd@arndb.de>
References: <1352973847-21605-1-git-send-email-lee.jones@linaro.org>
 <CAH9JG2UX0Wyr-QKw3=tbUXeuEhHe04_cFkkAp6bB2Rr-x7ViHQ@mail.gmail.com>
 <20121115112543.GC21682@gmail.com>
 <201211151225.31066.arnd@arndb.de>
Message-ID: <CACRpkdb+hKL0mZLa=Kusoh9r5V6rukmTdLmxc2erwhA6-YLZjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 1:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 November 2012, Lee Jones wrote:
>>
>> > > +/* for automatic boot timing testcases */
>> > > +#define ATAG_BOOTTIME  0x41000403
>> > Where can I refer this ATAG usage? can you point out the reference URL
>> > or patches?
>>
>> I assumed this would be in Mainline u-boot, but apparently not.
>> On closer inspection of the internal ST-Ericsson u-boot, this
>> functionality appears to be provided by patches which currently
>> exist as delta. So in essence, the bootloader you use will have
>> to be patched in a similar way for you to retrieve information
>> surrounding bootloader boot times.
>>
>> And there was me thinking it was magic. ;)
>>
>
> And since we're moving away from ATAG on ux500 towards DT, it won't
> even work in the future. How essential is this part for the operation
> of your code?

To be fun we need some mechanism to pass this info from the
boot loader to the kernel.

I think most bootloaders are already dynamically altering their
device trees to put in things like memory size etc so this would
probably be done the same way: a standard binding like for
everything else, then put the data in there.

I don't know if Lee has a modifiable U-boot to try out such
concepts on though?

Yours,
Linus Walleij
