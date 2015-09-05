From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 5 Sep 2015 22:54:10 +0800
Subject: earlycon issues in -next with amba-pl011 updates
In-Reply-To: <20150904111318.GF21084@n2100.arm.linux.org.uk>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <CABymUCNYrDxciKrfWhcTp_kJT1cQFEpEYCkaZ7-sgBiJmgXuyQ@mail.gmail.com>
 <55E81F93.1020104@arm.com> <20150903155255.GA28336@kroah.com>
 <55E87095.4030600@arm.com> <20150904110651.GE4818@arm.com>
 <20150904111318.GF21084@n2100.arm.linux.org.uk>
Message-ID: <CABymUCPpbmDrTKo5rDcFurFyAByg3z9iPXoGGU=rXSyb651MKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-04 19:13 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Sep 04, 2015 at 12:06:52PM +0100, Will Deacon wrote:
>> On Thu, Sep 03, 2015 at 05:08:53PM +0100, Marc Zyngier wrote:
>> > On 03/09/15 16:52, Greg Kroah-Hartman wrote:
>> > > On Thu, Sep 03, 2015 at 11:23:15AM +0100, Marc Zyngier wrote:
>> > >> So -next has now been broken for a while on a number of ARM platforms
>> > >> because of this (they simply cannot boot), and no progress has been made
>> > >> towards resolving this problem.
>> > >>
>> > >> Can we please drop this series (at least commits 7b753f3 and following)
>> > >> from -next until is has been reworked and reviewed?
>> > >
>> > > I don't have any patches in my -next tree, everything is in Linus's tree
>> > > now.  So if I've missed something, or need to revert something, please
>> > > let me know specifcally what to do.
>> >
>> > Gahhh... Given that there is no obvious fix, that the discussion has
>> > stalled and that the author of the series is apparently away, the
>> > following patches should be reverted:
>> >
>> > 8cd90e50d140 uart: pl011: Add support to ZTE ZX296702 uart
>> > 09dcc7dfc05b uart: pl011: Improve LCRH register access decision
>> > 2c096a9eedc6 uart: pl011: Introduce register look up table
>> > 7b753f318d14 uart: pl011: Introduce register accessor
>> > 534e14e2293d uart: pl011: Rename regs with enumeration
>> >
>> > (7b753f318d14 being the one breaking everything, but it makes more sense
>> > to revert the whole series until it is properly fixed and reviewed).
>>
>> For the reverts (git revert 534e14e2293d~1..8cd90e50d140):
>>
>>   Acked-by: Will Deacon <will.deacon@arm.com>
>>   Tested-by: Will Deacon <will.deacon@arm.com>
>>
>> We can discuss what could've and should've happened 'til we're blue in
>> the face but, in the meantime, I'd like my serial console back.
>>
>> Greg -- any chance you could send these for -rc1, please?
>
> Given the number of reviews the patches went through, I eventually came
> to the conclusion that it would be far better if I were to write the
> set of patches for the driver - but I haven't had a slot to do that.
> I basically stopped reviewing them because I decided it wasn't worth
> spending the time anymore on the series.  That wasn't an implicit
> "I'm happy with the patch set" but more a "I've given up with this
> patch set, it's still not up to scratch."

Russell,

Thanks for your time for reviewing that patch set. I did made some
mistake for the register naming for not understand your intention
clearly. I thought reviewing out of date patches also made you
desperate because I update patches frequently. Anyway, the existing
merged patches are made per your suggestion except the bugs. Could you
help comments for the below patch set even they are already merged? So
that I can polish existing code or re-prepare those changes. Or you
have other plan on supporting pl011 controller with different register
mapping? Thanks for you any comments!

http://www.spinics.net/lists/linux-serial/msg18363.html

Jun

>
> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
