From: joel@jms.id.au (Joel Stanley)
Date: Fri, 17 Nov 2017 13:27:50 +1030
Subject: [GIT PULL] ARM: dts: aspeed: Changes for v4.15
In-Reply-To: <CAK8P3a1PNhysyCne-7CihaFucUvz7_ccWOzJjihsi3y_CjgEDQ@mail.gmail.com>
References: <CACPK8XdG=wjKuAJJ7yzu320UPxKAGA-A2DYtrL5=CwCN2DNpBg@mail.gmail.com>
 <CAK8P3a1PNhysyCne-7CihaFucUvz7_ccWOzJjihsi3y_CjgEDQ@mail.gmail.com>
Message-ID: <CACPK8XcdK9WxFAA-AztO1zfZyt2O4yLwVnnrSb0EnRKGvZmQjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 8:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Oct 6, 2017 at 9:05 AM, Joel Stanley <joel@jms.id.au> wrote:
>> Hello ARM SoC maintainers!
>>
>> Here are some ASPEED device tree updates for v4.15.
>>
>> Sadly our clk driver is still under review, so I have not been able to
>> include all of the patches I intended to. Alas, these improvements are
>> still useful.
>
> Pulled into next/dt

I noticed this didn't make it into Linus tree for 4.15 :(

Was it because of your question below?

>
>>     ARM: dts: aspeed: Add aliases for UARTs
>
> Can you explain this one? It looks like you now have aliases for
> all uart and i2c entries on all machines, even when they don't
> actually expose the ports. The purpose of the aliases is to
> only list the ones that are actually usable, so they should normally
> go into the board specific .dts files.

Sorry for not responding to this at the time. I was on vacation.

The idea was to maintain expectations for userspace where they assume
the character devices match the numbering of the hardware. So
/dev/ttyS4 is always the fifth uart, even when the board only has one
or two wired up.

If we don't do that, our userspace developers have trouble telling
which UART is actually /dev/ttyS0, for example.

Cheers,

Joel
