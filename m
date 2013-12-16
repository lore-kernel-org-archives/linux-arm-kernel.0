From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 16 Dec 2013 10:04:38 +0100
Subject: [linux-sunxi] Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
In-Reply-To: <52ADBD41.4050104@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <20131215135854.GF3651@lukather> <52ADBD41.4050104@redhat.com>
Message-ID: <11015171.YHkHMOrD9M@pagira.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> Note as said before I expect David to take things from here.
I will start working on it this evening.

> I just took what David was using. I agree picking one and staying with
> it would be better.
There is a reason why my working branch was called "plsdsif"
(short for "Please don't shout at me in Finnish")

> Yes and no. The pullups are enabled by uboot and the allwinner
> sources, most of my testing has been done without them, which
> seems to work fine. I've enabled them to be consisten with the
> allwinner sources and u-boot.
Ok

> As for drive = <3>, we need drive = <2> for normal modes,
> and drive = <3> for ddr mode. I simply picked <3> to keep
> things KISS. It should not matter much in power usage, as
> it will only make the flanks of the signal more steep. Once the
> desired output level is reached the current will drop off. It will
> use more current when changing the level, but for half the time,
> so the effective power usage (current * time) is the same.
In this case lets implement a switch which enables the pull ups for DDR
mode and lets disable it by default in turn.
This way we can make sure that we don't have doubled pull up,
since this could actually mess up some circuitry.

> > Ideally, I'd like this patch to be splitted into three:
> >    - One that adds the MMC controller nodes to the DTSI
> >    - One that adds the muxing options you need to the pinctrl node
> >    - One that enables the controller on the boards
> Sounds like a good job for David. Note I've a lot more boards for
> which I would like to add mmc support or dts files in general
> (will do so as time permits).
Ok. I will work on it this evening.

> For those boards which already have a dts I'll send mmc adding dts
> patches to David for now so he can add the changes to the patch-set.
Ok. I will create another branch and will incorporate your DTS files.

> How do you want to deal with new boards ? Send the addition of the
> base board to you (and CC David as he will need them in his tree too),
> and then send a patch to add mmc to the dts to David ?
Sounds good to me...
 
> Or should I simply make it one big patch including mmc in the initial
> commit ?
I imagine that a messy approach. Especially if I'm supposed to refactor
the patchset into a new one...

cheers
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/21d5a173/attachment.sig>
