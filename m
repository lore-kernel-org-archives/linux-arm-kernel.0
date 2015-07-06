From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Jul 2015 13:42:12 +0900
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703150951.GC19284@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
Message-ID: <CANqRtoTA=Yg5f4pQxPaNQP9L=XG3pfJWk18jsz2M15HY0yaN3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for investigating this.

On Sat, Jul 4, 2015 at 12:09 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Ok. So it's unrelated to deep idle states. Any chance of poking with
>> JTAG at the frozen box? If not, are there GPIOs which you could use to
>> monitor certain state?
>
> No JTAGger here at the moment. And no manual/schematics for this board
> :(

Since EMEV2 includes a dual Cortex-A9 you can use OpenOCD with a
Flyswatter JTAG.

I've tried the following lines for the openocd configuration file, if
you need any help let me know!

# --- emev2 (CA9 Dual) on KZM9D ---
#target create emev2.cpu0 cortex_a -chain-position auto0.tap -dbgbase
0x80010000 -coreid 0
#target create emev2.cpu1 cortex_a -chain-position auto0.tap -dbgbase
0x80012000 -coreid 1

Cheers,

/ magnus
