From: mlweber1@rockwellcollins.com (mlweber1 at rockwellcollins.com)
Date: Thu, 5 Dec 2013 21:14:31 -0600
Subject: MCS8142
In-Reply-To: <CAGVrzcb9asBzXqJBatksAXGevtsdpuS+nTZK7SHMgqsnzPYbgQ@mail.gmail.com>
References: <OF98E40A9C.2937821E-ON86257C35.0070EFA2-86257C35.0071D5A4@rockwellcollins.com>
 <CAGVrzcZf+wNXO54-_UDeToUCoqO9b2rosk7ugvQxT0joLRz3yQ@mail.gmail.com>	<OF178900CD.244DDA78-ON86257C36.004B4D2A-86257C36.004BEEAB@rockwellcollins.com>
 <CAGVrzcb9asBzXqJBatksAXGevtsdpuS+nTZK7SHMgqsnzPYbgQ@mail.gmail.com>
Message-ID: <OF8910DA33.769F3123-ON86257C39.000FEF6A-86257C39.0011CEEC@rockwellcollins.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> wrote on 12/05/2013 08:45:09 PM:

> From: Florian Fainelli <f.fainelli@gmail.com>
> To: Matthew Weber <mlweber1@rockwellcollins.com>
> Date: 12/05/2013 08:45 PM
> Subject: Re: MCS8142
> 
> Florian
> On Dec 3, 2013 5:49 AM, "Matthew Weber" <mlweber1@rockwellcollins.com> 
wrote:
> >
> > Florian Fainelli <f.fainelli@gmail.com> wrote on 12/02/2013 03:00:09 
PM:
> >
> > > From: Florian Fainelli <f.fainelli@gmail.com>
> > > To: Matthew Weber <mlweber1@rockwellcollins.com>
> > > Date: 12/02/2013 03:01 PM
> > > Subject: Re: MCS8142
> > >
> > > Hi Matthew,
> > >
> > > I never had a chance to get my hands around MCS8142 hardware, but if
> > > you have and would be okay with sending one to me, I would be happy
> > > to add support for it.
> > >
> > > Cheers
> > >
> >
> > I'm not able to send a board at this point, but we're actively working
> > to try to get the 814x BSP functional on it (we're hoping we can get
> > Moschip to give us the 2.6.24 BSP....)
> Last I looked at their BSP it was total crap, but that's not a surprise.

Ok, good to know :-) 

Currently I'm at the point of having a 3.3 kernel image built for fa526, 
but I never get console output beyond the uboot starting kernel message.

I think I have a couple items that I need to get past to make progress. 
The first is get a toolchain I can trust. I've build a newer toolchain 
(GCC4.7) that has fa526 support, but I think I need to back track and 
switch to your 4.6 openWRT toolchain and just make sure I get a kernel 
binary that "should" execute.  Do you happen to know if that toolchain
would support the fa526 arch? 
To boot that kernel, I'm using an existing uboot (2010) that seems 
adequate for now.  However I assume I'll have to build a uImage with 
appended device tree to get it to boot correctly without uboot DT 
support.
The other item that I need to figure out is what the default console
port name ended up as in the 3.3 or latest kernel.  One openWRT dts
file bootargs defined it as /dev/ttyMCS, but another defined it as the 
standard /dev/ttyS0.

Just to make this all a bit harder I don't currently have jtag 
capability to this board, so I'm not sure the state the kernel is 
getting to.  So to work around that I was going to start modifying 
the initial kernel asm to toggle gpio so I could start narrowing 
in on the failure point, but I'm still working on getting the gpio 
to toggle using uboot reg access (seems to bus hang when I use the 
gpio reg peripheral address defined in the 8140 gpio driver).

> > You wouldn't happen to have any technical material or knowledge
> > about the differences between the 8140 and 8142? (aside from the CPU)
> In fact I may, but certainly not as detailed for MCS8142 than it is 
> for MCS8142. Let me get back to you on this once I am done with moving 
in.
> In any case the code I wrote for OpenWrt should not be too bad to begin 
with.

Much appreciated.  Thanks
Matt
