From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 May 2012 22:33:24 -0700
Subject: [GIT PULL] SPEAr clk updates for v-3.5
In-Reply-To: <20120510155327.GB12727@n2100.arm.linux.org.uk>
References: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
 <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
 <20120510085939.GC3190@n2100.arm.linux.org.uk>
 <20120510153745.GQ17875@S2101-09.ap.freescale.net>
 <20120510155327.GB12727@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMg+fNwxPYo+oDZm=uDKj4s7jZw_U91wfs=JE15xCZPomQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 8:53 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 10, 2012 at 11:37:47PM +0800, Shawn Guo wrote:
>> On Thu, May 10, 2012 at 09:59:39AM +0100, Russell King - ARM Linux wrote:
>> > On Thu, May 10, 2012 at 12:14:39AM -0700, Olof Johansson wrote:
>> > > Russell has published a clkdev branch that you pull instead of
>> > > applying his patch manually, that way there will be no surprises with
>> > > respect to conflicts, etc:
>> > >
>> > > git://ftp.arm.linux.org.uk/~rmk/linux-next.git clkdev
>> > >
>> > > It is also in arm-soc as depends/rmk/clkdev now.
>> >
>> > I'll mention that I'm considering a patch on top of this to add __must_check
>> > to the return values for these clkdev clk registration functions. ?I've
>> > noticed that many users aren't checking that, so there's no real way to
>> > be sure that these things are being created.
>> >
>> I have to admit I'm one of such users. ?Does that mean we have to
>> revise the platform porting again? ?So ...
>>
>> > The alternative is we make these functions void and/or add pr_err() inside
>> > them to report the failures.
>> >
>> ... I'd vote for this alternative. ?(Sorry for users that are checking
>> the return right now. ?Any?)
>
> It's one reason why I mentioned it in this email, to find out how folk
> would like to deal with this. ?I have no particular preference as to how
> it gets addressed, just as long as we don't end up with silent failures
> causing hard to debug problems.

How about adding the __must_check patch on your for-next branch for a
bit, so we can find and fix build fallout on the arm-soc branches
through linux-next, maintainers can add build fixes that we pick up
and then, after that, the __must_check fix can go upstream? That
maintains bisectability on the branches we already have and should
avoid more non-checking code to be introduced down the road.


-Olof
