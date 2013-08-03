From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Aug 2013 22:16:57 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802223247.GC28831@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802142010.GC7533@kroah.com>
 <20130802160932.GG5292@mudshark.cambridge.arm.com>
 <20130802223247.GC28831@kroah.com>
Message-ID: <CAOesGMgyQYTqObtvyJsVqxsrWz1rYTuA-qW4QwnZ+Co=1iKOBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 3:32 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, Aug 02, 2013 at 05:09:32PM +0100, Will Deacon wrote:
>> On Fri, Aug 02, 2013 at 03:20:10PM +0100, Greg KH wrote:
>> > On Fri, Aug 02, 2013 at 12:53:34PM +0100, Will Deacon wrote:
>> > > We can change the mindset by yelling, but if you're writing a new
>> > > driver for a peripheral on an ARM SoC, platform_bus is mighty tempting
>> > > because you get a bunch of device-tree parsing code for free (see
>> > > drivers/of/platform.c).
>> >
>> > I know :(
>> >
>> > So, who do I "yell at", and what do I do to make things easier for you
>> > from the driver-core perspective?
>>
>> I would anticipate most of these drivers going through the arm-soc tree, so
>> Olof and Kevin would be doing the yelling. You could join in the chorus too!
>>
>> We basically need reviewers to adopt the position that a new bus should be
>> considered and dismissed before using the platform_bus, then you can yell
>> transitively through them.
>
> I don't scale if I'm forced to review every driver to ensure that they
> shouldn't be using platform device and should be creating their own bus
> type.  You can do that, along with the other ARM developers reviewing
> these new subsystems and code being added.

For most new platforms, using basic platform_bus devices makes sense
when the setup is simple and just has a few devices. It's only when
they need to add support for {S,IO}MMUs and get the more advanced
functionality going that things get messy and platform_bus stops
working.

So, we have the option of having someone care about the {S,IO}MMU
pieces, and when they spot the attempts to make that work, push them
towards a proper bus architecture. Until then, the simpler solution is
probably a reasonable idea compared to having newcomers worry about
defining new bus architectures and raising the bar for what it takes
to sort out the initial contributions and getting engaged upstream.


-Olof
