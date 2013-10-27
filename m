From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 26 Oct 2013 22:52:58 -0400 (EDT)
Subject: [PATCH v3 0/3] MCPM/TC2 support for CPU powerdown synchronisation
In-Reply-To: <20131025154651.GA3579@localhost.localdomain>
References: <CALicx6v86NMp53+zbE=A3ang-ftGE3KiUojkRZO4ss6Pmks1ow@mail.gmail.com>
 <CALicx6tUgu=OnrBo1NaUHQz=hd7zHrXNbDmUGKPj6EnnXRQWTw@mail.gmail.com>
 <CALicx6uAPM8x_BcqUWtrSAMPOmc=EGMiwMKFtxL=7sUMo7BmqA@mail.gmail.com>
 <20131025154651.GA3579@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310262158000.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Oct 2013, Dave Martin wrote:

> On Thu, Oct 24, 2013 at 06:19:42PM +0530, Vijay Kilari wrote:
> > Sorry. Below is the right DCC configuration for SCC 700
> > SCC: 0x700 0x0032F003           ;CFGRW48 - [25:24]Boot CPU [28]Boot
> > 
> > On Thu, Oct 24, 2013 at 6:18 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> > > Hi Dave Martin,
> > >
> > >    With the below configuration, I tried to check cpu hotplug as this
> > > is prerequisite for kexec.
> > > I see cpu hotplug fails. hot-unplug is OK but hot plug-in fails.
> 
> Thanks for giving this a try.
> 
> > > Below is my DCC board configuration
> 
> 
> I've attached my board.txt.
> 
> The only obvious difference that I think should have an impact is that
> bit 13 in SCC 0x700 needs to be 1 in order for the non-boot cluster to
> be powered down on startup.
> 
> In my board.txt, SCC 0x700 has the value 0x0032F003 -- you have that,
> but it's commented out.

Is there a way to programmatically determine from Linux if the necessary 
bits are set?

...

Yes, from physical 0x7fff0700.  I think we should test for the proper 
bits to be set such as bit 12 which is absolutely needed for the code in 
tc2_pm.c to work, and refuse to register the TC2 MCPM backend with a big 
warning in the boot log to that effect otherwise.  If Linux can flag 
inproper firmware config that might help with issues like this one.


> What happens if you set that bit, and make no other changes to your
> config?

That would be interesting to know indeed.


Nicolas
