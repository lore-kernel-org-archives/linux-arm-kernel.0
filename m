From: danborkmann@iogearbox.net (Daniel Borkmann)
Date: Tue, 13 Nov 2012 20:25:21 +0100
Subject: [PATCH] arm: zynq: add system level control register manager
In-Reply-To: <20121113183700.GK1718@beefymiracle.amer.corp.natinst.com>
References: <20121031183610.GA2603@thinkbox> <20121108160125.GA5550@kryptos>
 <CAD6jFUQC+HPCT11_nWckUkhzgQtPkxLcqcTxbVb==kFmwCaTwA@mail.gmail.com>
 <20121113183700.GK1718@beefymiracle.amer.corp.natinst.com>
Message-ID: <CAD6jFUTYZFHzK5rB578WuTZt9_vUDwW3tieJzifb9-Ch0r2PrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 7:37 PM, Josh Cartwright <josh.cartwright@ni.com> wrote:
> On Fri, Nov 09, 2012 at 10:49:07AM +0100, Daniel Borkmann wrote:
>> On Thu, Nov 8, 2012 at 5:01 PM, Josh Cartwright <joshc@eso.teric.us> wrote:
>> > On Wed, Oct 31, 2012 at 07:36:12PM +0100, Daniel Borkmann wrote:
>> >> This patch for the Xilinx Zynq ARM architecture adds management of system
>> >> level control register. The code is taken from the Xilinx-internal Linux
>> >> Git tree and cleaned up a bit for mainline integration. Besides others,
>> >> this patch is needed in order to integrate further drivers for Zynq such as
>> >> the Zynq xemacps networking device driver. The patch is aganst the latest
>> >> arm-soc tree.
>> >>
>> >> Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
>> >> Cc: Michal Simek <michals@xilinx.com>
>> >> Cc: John Linn <john.linn@xilinx.com>
>> >> Cc: Arnd Bergmann <arnd@arndb.de>
>> >> ---
>> >
>> > These changes will conflict with my pending clk patchset [1], as I'm
>> > introducing bindings for the SLCR (and its clk interfaces).
>>
>> Oops, okay. Then your's has priority, of course.
>
> I did not mean to discourage.  I just meant to say that we should work
> out how this work can be done on top of the clk changes.
>
>> > It seems like a hefty chunk of the out-of-tree slcr driver is related to
>> > configuring MIO.  I think it would be really nice if this driver was
>> > reworked to use the pinctrl subsystem, and also to provide suitable
>> > device tree bindings.
>>
>> Agreed. If there's a chance to help with further Zynq integration and
>> to develop this driver with testing on Qemu for ARM Zynq, I'd like to
>> give it a try. (The board is a bit expensive as a hobby only.)
>
> My concern is that, especially regarding the configuration of MIO, being
> able to do adequate testing will require real hardware.  It isn't clear
> to me what the state of qemu's slcr/mio model is.

I added Peter Crosthwaite into CC, since he could provide an answer to
that (I've been told).
