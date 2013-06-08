From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Jun 2013 10:28:38 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDxtC+OamcpVEQ3BULbN88hSJzKoi0fkNLBAdZD04LQCNQ@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <20130607205940.4816fed5@skate>
 <CAPweEDxtC+OamcpVEQ3BULbN88hSJzKoi0fkNLBAdZD04LQCNQ@mail.gmail.com>
Message-ID: <4247099.i8S79t0Pua@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Luke,

On Friday 07 of June 2013 22:29:34 luke.leighton wrote:
> On Fri, Jun 7, 2013 at 7:59 PM, Thomas Petazzoni
> 
> <thomas.petazzoni@free-electrons.com> wrote:
> > Maxime will reply to this in more details, but I believe the status 
is:
> >  * Interrupt controller is working.
> >  * Clock drivers are working.
> >  * Pinctrl is working.
> >  * GPIO is working.
> >  * Timer is working.
> >  * UART is working
> >  * Watchdog is on its way (patches posted)
> >  * Ethernet is on its way (patches posted)
> >  * I2C is on its way (patches posted)
> 
>  ok so i've got this now in
> http://hands.com/~lkcl/allwinner_linux_proposal.txt - that leaves...
> well there's quite a bit: usb, sd/mmc (both variants: they changed the
> data structures around sun5i), nand (probably both - the allwinner one
> and the mtd one being done, reminds me: we need full documentation on
> the NAND chip), scsi, g2d - cedarx and more.
> 
>  what else should be raised, and to what benefit?

Now that the discussion went off from "you stupid kernel developers 
adopted DeviceTree without even asking a closed company about their 
proprietary solution, which does the same" to something a bit more 
constructive, let me point some of the benefits.

First let me remind you the proposals from one of my previous posts:

 - let Allwinner engineers join the relevant mailing lists - mostly linux-
arm-kernel, but also all the topic-specific ones, like linux-mmc, linux-
usb, linux-pm, devicetree-discuss, etc.

 - adjust their workflow to comply with rules of Linux kernel open 
source community (i.e. sending RFCs of things in development, getting code 
reviewed, addressing comments)

 - rework existing code to use widely-accepted, standard solutions 
available in upstream Linux kernel (although this is already mostly done 
by sunxi community) to avoid reinventing wheels - this is not only about 
DeviceTree, which you mentioned already in your proposal list, but also 
all the generic frameworks present in the kernel

Now the benefits of cooperation with Linux kernel community:

 - access to big knowledge base of all the Linux kernel developers 
participating in discussions on the mailing lists; any technical (and 
maybe non-technical?) problems related to the kernel can be discussed on 
the lists at any time; also this would be a good form of communication 
between Allwinner engineers and sunxi community

 - in-depth code review by experienced kernel developers that allows early 
spotting of issues and finding possible improvements of design and 
implementation; having this would avoid things like you mentioned with 
their usb driver

 - extended testing coverage - anyone can access the patches in 
development (through the ML or linux-next integration tree), test them on 
their board with Allwinner SoC and report any issues on respective mailing 
lists

 - ability to participate in development of the whole Linux kernel, 
including any existing and new generic frameworks, drivers, etc., in terms 
of discussion, sending patches, reviewing patches of other developers;

	this is very important to make sure that the part being developed
	suits the needs of everyone (or at least most of the parties)
	- you can't know that without enough discussion;

	this is also important to avoid reinventing wheels - there might
	be a useful part of code available in some internal tree of some
	company or developer, which could be just extended (or even used
	as is), without the need to reinvent it, but people must know
	about it first

That's all I can think of at the moment (+ all the proposals and benefits 
you have in your file already).

Best regards,
Tomasz
