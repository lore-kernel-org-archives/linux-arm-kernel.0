From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Jun 2012 17:54:16 +0200
Subject: [RFC 23/34] dmaengine: PL08x: re-jig the starting of txds
In-Reply-To: <20120601105228.GE21245@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIxA-00070E-Dc@rmk-PC.arm.linux.org.uk>
 <CACRpkdb15mx2jPZ3zqD01htvvLsQ27snsQQ+o=aSM8F6y=WKcw@mail.gmail.com>
 <20120601105228.GE21245@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaimR79ZQ95PNiDzViMvYBwTYfFyApqSRQMBLHSCGGRTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2012 at 12:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [Me]
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?*/
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_lock(&waiting->lock);
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pl08x_start_next_txd(waiting);
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_unlock(&waiting->lock);
>>
>> I've seen this construct in the past and have no better suggestions...
>
> I have no way to test whether my statement is true as I can't get enough
> DMA engine usage through the PL011 transmit support to check what happens.
> So the statement is purely theoretical.

Doesn't memcpy work on the Versatile?

What I did to stress the PB11MPcore was to compile in the DMAengine
test client and torture the DMAC with a bunch of parallell memcpy()
threads causing it to fail channel allocation and other nasty stuff,
then put the console on DMA and pour a lot of text in and out of the
console on top of that.

Yours,
Linus Walleij
