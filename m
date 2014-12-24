From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 24 Dec 2014 18:03:44 +0530
Subject: [RFC PATCH v2 1/4] arm64: defconfig: increase NR_CPUS range to
 2-128
In-Reply-To: <2054688.iIEQnOEqVy@wuerfel>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <3519779.ILzEnWe9lP@wuerfel>
 <CAMDttNe33ie9vgyEn8GHz+8isadaDfXXUJcp5mQM-42_mx3Pbw@mail.gmail.com>
 <2054688.iIEQnOEqVy@wuerfel>
Message-ID: <CAFpQJXXVn2ohjdLPOOYfTynUD4++Y_Cbjgn-EEFHUJcv=Umbag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 9, 2014 at 1:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 December 2014 17:57:03 Zi Shen Lim wrote:
>> Hi Arnd,
>>
>> On Mon, Nov 24, 2014 at 3:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > On Saturday 22 November 2014 02:53:27 Ganapatrao Kulkarni wrote:
>> > > Raising the maximum limit to 128. This is needed for Cavium's
>> > > Thunder system that will have 96 cores on Multi-node system.
>> > >
>> > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
>> > >
>> >
>> > Could we please raise the compile-time limit to the highest number that
>> > you are able to boot successfully on some existing machine?
>> >
>> > There isn't much point in doubling this every few months.
>>
>> Agreed. If we look back at [1], Mark Rutland has actually compiled and
>> boot-tested NR_CPUS=4096 on Juno.
>>
>> [1] https://lkml.org/lkml/2014/9/8/537
>
> Ok, 4096 sounds like a good NR_CPUS limit then, it should last for a while.
Ok, will set range to 2-4096.
>
> For the defconfig, we probably want a much smaller value, either one that
> covers all known machines (96 at this time), or something that covers
> 95% of all users (maybe 32?) and does not have an serious impact on
> memory consumption or performance on small machines.
>
>         Arnd
thanks
Ganapat
