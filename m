From: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Fri, 4 Jul 2014 15:09:52 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <7255305.EKPTbfD3OE@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140704085745.GB16404@arm.com>
 <20140704092519.GC21766@n2100.arm.linux.org.uk>
 <7255305.EKPTbfD3OE@wuerfel>
Message-ID: <20140704140952.GA31399@gallifrey>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann (arnd at arndb.de) wrote:
> On Friday 04 July 2014 10:25:19 Russell King - ARM Linux wrote:
> > Moreover, when you download from the play store, you are only presented
> > with the version which is appropriate for your device - when you buy a
> > new device, and you re-fetch your apps, you don't get the same version
> > that you've had on previous device if there's one more appropriate for
> > your new device.
> 
> This is certainly true, but at the same time the device makers have
> a valid interest in making as many apps as possible be enabled without
> requiring a recompile. If it becomes known that device A supports 90%
> of the popular apps while device B only supports 70% of the same apps
> (until they get recompiled), the decision whether to put emulation in
> or not is more about maximizing revenue than about theoretical
> correctness.

I've got a case of mislabelled/misdelivered CPU type in the play store,
where it's delivering my ARMv6t phone a library that has v6t2 instructions
in (cbz/cbnz) - for Google's own Google+ app.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
