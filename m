From: alchark@gmail.com (Alexey Charkov)
Date: Fri, 24 Aug 2012 09:54:25 +0400
Subject: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
In-Reply-To: <1345787536.23177.3.camel@gitbox>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <201208231322.23077.arnd@arndb.de> <1345758702.2061.6.camel@gitbox>
 <201208240540.12316.arnd@arndb.de>
 <1345787536.23177.3.camel@gitbox>
Message-ID: <CABjd4Yxxf5XDc6gs0WABZgF3SOd89J7CfjsU9uitOg4qpQ4WEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/24 Tony Prisk <linux@prisktech.co.nz>:
> On Fri, 2012-08-24 at 05:40 +0000, Arnd Bergmann wrote:
>> On Thursday 23 August 2012, Tony Prisk wrote:
>> > I was about to say that if Mike has any issues with the driver that I
>> > can fix the patch conflict at the same time, but I just realised that
>> > its more work than I originally thought :)
>> >
>> > I was going to move the arch-vt8500 part of the clocks patch back into
>> > the clocks patch - but that will just move the issue from arm-soc to
>> > clocks because Mike's branch won't have the arch-vt8500 patch so the
>> > patch will fail.
>>
>> But that's ok, because without the arch-v8500 part, nothing uses
>> the vt8500-clock driver, so nothing breaks. You can introduce broken
>> code in the meantime as long as it's impossible to enable and it will
>> work afterwards.
>>
>>       Arnd
>
> You lost me a little bit there :)
> If it stays as is now, the arch-vt8500 patch will introduce an
> unresolved symbol.
> If I move the clock code from the arch-vt8500 patch to the clock patch,
> then the clock patch won't apply because it needs the arch-vt8500 patch
> first and Mike won't have that patch, but it would be fine if both
> patches went in via your tree.

Why don't you add a #define in the first patch that makes your
to-be-unresolved symbol a no-op and then drop it within the clock
patch?

Best,
Alexey
