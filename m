From: loeliger@gmail.com (Jon Loeliger)
Date: Thu, 1 May 2014 11:18:45 -0500
Subject: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
In-Reply-To: <20140501151236.078E3C409DA@trevor.secretlab.ca>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
 <20140429000224.GA31083@verge.net.au>
 <20140429002140.GP27282@n2100.arm.linux.org.uk>
 <20140501151236.078E3C409DA@trevor.secretlab.ca>
Message-ID: <CAJgR-BiGjp9G=E7SzgidyVLTjpQ3ETFTFwxDapVc28PyokGa=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I emphatically second Grant's opinion here:
This is a good patch series and is a much-needed improvement.

I am in the middle of a board-port for an A9 system, and this
series will greatly simplify things for me *despite* the fact that
I will need to convert to the new write_sec() form of L2C control
on PSCI-enabled non-secure platforms.

To reiterate Grant's request, please re-consider applying
this L2C patch series!

Thank you,
jdl


On Thu, May 1, 2014 at 10:12 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, 29 Apr 2014 01:21:41 +0100, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Tue, Apr 29, 2014 at 09:02:27AM +0900, Simon Horman wrote:
>> > On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
>> > > Since we now automatically enable early BRESP in core L2C-310 code when
>> > > we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
>> > > explicitly.  Instead, they should seek to preserve the value of bit 30
>> > > in the auxiliary control register.
>> > >
>> > > Acked-by: Tony Lindgren <tony@atomide.com>
>> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >
>> > I would prefer if this patch was broken out into individual patches
>> > for each board or SoC file and that they were then picked up
>> > by their respective platform maintainers.
>> >
>> > Likewise for patch 66/97. Although it is only for shmobile
>> > I would prefer it broken out.
>>
>> Oh fuck that.
>>
>> Okay, I'm dropping the whole patch set right now and forgetting the whole
>> damned thing.  The L2 cache code can damned well stay as it is and remain
>> an unmaintainable mess.
>
> FWIW, there are an awful lot of people, myself included, who do care
> that you've done this work. It is 100% okay for you to say "no" to
> requests to split things up because of the complexity of the series.
>
> I really hope you're reconsider and not give up on this series.
>
> g.
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
