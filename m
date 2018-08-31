From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Sat, 1 Sep 2018 00:05:10 +0530
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <CAK8P3a0p2PdjVS+QVMtiYK+5=ToeLSfjvf5X85S0HK2Om4fZ1Q@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
 <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
 <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
 <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com>
 <CAK8P3a0p2PdjVS+QVMtiYK+5=ToeLSfjvf5X85S0HK2Om4fZ1Q@mail.gmail.com>
Message-ID: <CA+sq2Cc_fdTjSJx1BdietRThfK=gn3Sy__=K4iQNQDCBTa+JyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 11:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 31, 2018 at 6:01 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Fri, Aug 31, 2018 at 7:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> >
> > Thanks for the suggestion, that does makes sense.
> > Actually i did thought about it, but i was skeptical if it would be
> > acceptable to make
> > a single module out of drivers registering for two different PCI devices.
>
> I don't think it matters much whether there is one module or two
> (others might have a strong opinion one way or the other).
>
> What is important though are these two points:
>
> - How to represent the two PCI devices to user space: You should only
>   have one interface to user space I think, and this should be similar
>   to how other drivers manage similar cases (I don't actually know what they
>   do, but I assume you've done some research here)
>
> - How you connect find the pair of devices: Generally speaking while
>   the SoC might only have one of each, you shouldn't make that assumption
>   in the code, but instead have a reliable way of having one driver wait
>   for the other driver to finish probing so you can match the pair.
>

Agreed.
I do have a patch in works for that, i.e to defer AF driver probe till
CGX driver is loaded.
https://github.com/sunilkovvuri/rvu_drivers/commit/27b449087c16224a9e93dd91d6d9f734b5210bed

> > Will wait for few more days for more feedback from anyone and port v2 series.
>
> Ok.
>
>       Arnd
