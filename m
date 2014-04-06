From: w@1wt.eu (Willy Tarreau)
Date: Mon, 7 Apr 2014 00:04:34 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
References: <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
Message-ID: <20140406220434.GO29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 10:57:40PM +0100, Neil Greatorex wrote:
> Good work - I've been doing similar things myself! I can confirm that I 
> see exactly the same thing with similar printks:

Great! A reproduceable bug is always half-resolved :-)

> The physical addresses match those given in the lspci -vvv output

same here.

> (see 
> https://gist.github.com/ngreatorex/9772195). I don't know enough about 
> PCIe, the SoC *or* the Intel card to know if these addresses look correct 
> or even sane! I did wonder if there was some issue due to the fact that 
> the resources for 01:00.0 and 01:00.1 overlap, but I would guess(!?) that 
> it's common in hardware that presents multiple devices.

My understanding and old memories tell me that's OK.

> It is perhaps noteworthy that this is the first access to the hardware for 
> the 2nd port - i.e. there are no successful accesses, other than to enable 
> the hardware, which AFAICT is simply accessing registers on the PCIe 
> controller.

Indeed, I forgot to mention that but you're right, enabling only the
second function leads to an immediate panic as well.

> I've tried playing around with a few things but not discovered 
> anything even close to useful. Hopefully Thomas will be able to debug 
> further when he gets the time.

Yeah, let's hope we have not opened a can of worms!

Willy
