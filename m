From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 2 Jul 2014 23:14:47 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140702170141.GH24879@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk> <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk> <20140702170141.GH24879@arm.com>
Message-ID: <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 6:01 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jul 02, 2014 at 05:39:23PM +0100, Mark Brown wrote:
>> On Wed, Jul 02, 2014 at 11:01:33AM +0100, Will Deacon wrote:
>>
>> >   (1) The hardware doesn't have the instruction at all. If we start
>> >       emulating it, then we'll always have to emulate it and it doesn't
>> >       encourage software migration.
>>
>> That's what the logging other architectures did in similar situations
>> was intended to help address - even if people don't care about the
>> performance impact having loud complaints in the logs tends to cause
>> some useful subset of users to report it as a problem.
>
> I don't think logging something to dmesg is going to make a blind bit of
> difference on an Android device. Maybe we could get SWP emulation to request
> access to the users contacts and send everybody a text message each time
> they issue the instruction?
>
> Seriously though, nothing causes loud complaints like a SIGILL. This thread
> is evidence of that.

I think that looks at the problem entirely the wrong way around. We
don't break userspace. That's been a rule for a very long time.
Android is not the embedded world where we could get away with a whole
lot. There is a *freaking huge* installed base of applications.
Breaking them is not an option, and I think Colin's question makes it
clear that Android is going make sure that doesn't happen regardless
of what the mainline kernel does... and they are right to do so.

g.
