From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Jul 2015 13:45:05 +0900
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <CAMuHMdWQeYA=LrYcsD8W_0ZQUp3BKYVxedhBDpD5kPQp++yu1A@mail.gmail.com>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <CAMuHMdWQeYA=LrYcsD8W_0ZQUp3BKYVxedhBDpD5kPQp++yu1A@mail.gmail.com>
Message-ID: <CANqRtoQpfJUKM7LMEDeGNFY6hfQieL32cPTnCNqzYg+qrbzxSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Sat, Jul 4, 2015 at 2:02 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Wolfram,
>
> On Fri, Jul 3, 2015 at 4:37 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>> So this is a single core machine and uses the em_sti timer w/o the
>>> broadcast nonsense. In Simons case it looks like em_sti is used as
>>> broadcast device.
>>
>> We use the same board. Just my kernel has SMP=n.
>
> Unlike our other multi-core A9 SoCs, emev2.dtsi doesn't have a node
> for the arm,cortex-a9-twd-timer?

That's right, the TWD was never enabled on upstream EMEV2. I believe
it is documented in the data sheet though, however the actual
vendor-specific glue is a bit different compared to other SoCs from
Renesas Electronics - this most likely since EMEV2 was initially made
by NEC Electronics instead of Renesas. I've been told that it was one
of the earlier Cortex-A9 designs around so some special surprises may
exist!

Cheers,

/ magnus
