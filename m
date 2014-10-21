From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 21 Oct 2014 14:00:28 -0700
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <5446C775.3030707@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
 <5446C775.3030707@suse.de>
Message-ID: <10cbd78315a84262bc3f7474dc970bd4@BN1BFFO11FD015.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-21 at 10:52PM +0200, Andreas F?rber wrote:
> Hi Olof and S?ren,
> 
> Am 18.10.2014 um 06:28 schrieb Olof Johansson:
> > On Thu, Jul 24, 2014 at 4:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
> >> Hello,
> >>
> >> This patch series adds an initial device tree for the Parallella board.
> >> UART, SD card, Ethernet are enabled.
> >> Not yet enabled are HDMI, QSPI flash and 2x USB.
> > 
> > Andreas (Olofsson) kindly sent me a board, and I added it to the boot
> > farm today, it'll be included in boot reports from here on.
> 
> Good to hear.
> 
> > I did a test run with yesterday's -next It looks like networking isn't
> > working there at the moment, clock related. Same happens with 3.17 and
> > latest mainline, config multi_v7_defconfig:
> > 
> > [WARN] [    7.943648] macb e000b000.ethernet eth0: unable to generate
> > target frequency: 125000000 Hz
> > [WARN] [   10.948681] macb e000b000.ethernet eth0: unable to generate
> > target frequency: 125000000 Hz
> 
> I am unable to reproduce this in my setup - at Linus' tip
> c2661b806092d8ea2dccb7b02b65776555e0ee47 (v3.18-rc1-68-gc2661b8), make
> oldconfig'ing my /proc/config.gz.
> 
> S?ren, in light of your explanations, should I be expecting problems
> with 1GbE or with 100MbE? My board is connected to a 1GbE switch.

Not in general. As I said, I haven't seen that on our boards yet and I
did a little bit of testing making sure that the fundamental code to
switch between frequencies works. I.e. on our zc706 and zc702 boards I
usually can use ethtool to force a certain speed on the interface and
Zynq adjusts to it just fine.

But as I said, it does rely on the divider being sourced with a
frequency that allows generating the required Ethernet clock by
adjusting the 6-bit divider only. If this requirement is not met,
I expect you may see issues like Olof posted.

Are you (Andreas/Olof) using the same bootloaders?

I hope that helps.

	S?ren
