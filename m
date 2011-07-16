From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 16 Jul 2011 18:41:47 -0400 (EDT)
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRSQpThghsO0X=i8g3MmyZC+cDJaOJ1+MYZV3hvw-8=GXw@mail.gmail.com>
References: <CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
	<20110715080950.GL23270@n2100.arm.linux.org.uk>
	<CAMbhsRRCV0ukwbzFc6w_ba6xdVxs=TFmJMGd06UKTiNQPEJqpw@mail.gmail.com>
	<20110715161628.GA24628@n2100.arm.linux.org.uk>
	<CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
	<20110715181309.GD24628@n2100.arm.linux.org.uk>
	<CAMbhsRQRjwskzWB06g7rmSVgSdq5oVxA3yY+14qdtTxuQ=NeMQ@mail.gmail.com>
	<20110715210720.GF24628@n2100.arm.linux.org.uk>
	<CAMbhsRR=EVhKPkNUnzQ_2Ai9edWpmvHM_9TXwhh-xaa9Dk1Mcw@mail.gmail.com>
	<20110715215819.GG24628@n2100.arm.linux.org.uk>
	<CAMbhsRSQpThghsO0X=i8g3MmyZC+cDJaOJ1+MYZV3hvw-8=GXw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1107161837330.4069@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jul 2011, Colin Cross wrote:

> >> My initial offer was a patch that makes an incorrect overlapping mem=
> >> command line print a warning and ignore it, instead of doing something
> >> that is guaranteed to crash the kernel in an obscure way.  I'll post a
> >> patch.
> 
> I don't care about making overlapping mem= work, I'm just trying to
> make it easier to debug when someone screws up and passes conflicting
> mem= arguments, by printing a big warning.  When the warning is
> printed, the kernel might as well take a stab at picking which of the
> two mem= arguments might let it boot far enough to get the console up
> - taking the smaller of any two overlapping regions seems most likely
> to work.  If not, DEBUG_LL will show the warning.

Please do feel free to propose such a patch.  This is certainly a good 
thing on its own


Nicolas
