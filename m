From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Nov 2014 22:36:57 +0100
Subject: [RFC PATCH] clk: mvebu: armada-xp: Support for MSYS SoC
In-Reply-To: <546E5938.7060501@alliedtelesis.co.nz>
References: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141120051722.GC2596@lunn.ch>
 <546E5938.7060501@alliedtelesis.co.nz>
Message-ID: <20141120213657.GO31782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> msys is the name Marvell use for the embedded dual core CPU across 
> several product lines. I believe the CPU core is the same on all of 
> them. It's also the name used in the LSP Marvell provide. This was the 
> main reason I went with "msys" despite the possible confusion with 
> MSYS/MINGW.
> 
> > We need to be careful here,
> > because there could be other packet processors with embedded Armada-XP
> > cores with different tclk speeds. Rather than using msys, it might be
> > better to use the specific packet processor product ID.
> 
> The specific chip I'm working with is the 98DX4251 but there are at 
> least 4 variants in that product line. I could probably go with 98DX42xx 
> to cover all those variants but there is a whole other product line 
> (sorry don't know the model numbers) with the same embedded core.

In the DT world, you generally base the compatibility string on the
first device which gets added. So i would go with 98DX4251. The other
products in the family just need to say they are compatible with the
98DX4251.

> On a side note would people prefer I send my entire work in progress 
> get-linux-working-on-this-board series or drip feed individual patches 
> as I have been doing?

Release early, release often. It makes no sense to spend a lot of time
on polishing something, if we are going to rip it to shreds and tell
you to do it another way. Post something when it works, so that we can
review it and let you know if you are going in the right direction.

There is an interesting presentation by Thomas from ELC 2014

http://free-electrons.com/pub/conferences/2014/elc/petazzoni-soc-mainlining-lessons-learned/petazzoni-soc-mainlining-lessons-learned.pdf

See Lesson #0.

I also like Lesson #13 :-)

    Andrew
