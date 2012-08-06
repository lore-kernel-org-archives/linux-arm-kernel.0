From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Aug 2012 16:46:43 +0200
Subject: [PATCH] ARM: integrator: use clk_prepare_enable() for timer
In-Reply-To: <201208061437.52415.arnd@arndb.de>
References: <1344199075-4111-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZqaJhCYuW+3WYacjuwJ3zshAexDqLSUJgCCDzVS+=X7g@mail.gmail.com>
 <201208061437.52415.arnd@arndb.de>
Message-ID: <CACRpkdaqFqE5D5LkT0buof_5YZkpP_J_Y6qu0B5gKi4W3mFEkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 4:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 05 August 2012, Linus Walleij wrote:
>> On Sun, Aug 5, 2012 at 10:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > The Integrator timer is using the clock framework to get the
>> > timer frequency, but missed to prepare the clock before enabling.
>> >
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Arnd, Olof,
>>
>> If this patch looks OK to you I request that you apply it alone, no pull
>> requests, too much hazzle for a single patch...
>>
>
> Applying a patch is fine, but please explain which version(s) to apply
> this to? Is it a regression in v3.6, or should it be backported to
> earlier versions too?

Ah sorry. This is for the v3.6 rc:s.

The migration to common clock makes the kernel spit warnings
unless you prepare all clocks.

Yours,
Linus Walleij
