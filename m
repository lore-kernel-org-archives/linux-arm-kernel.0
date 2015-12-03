From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Dec 2015 12:08:11 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151203115143.GM8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
Message-ID: <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> On Thu, Dec 03, 2015 at 11:38:20AM +0000, Peter Rosin wrote:
> > Russell King wrote:
> > > On Thu, Dec 03, 2015 at 08:33:13AM +0000, Peter Rosin wrote:
> > > > I wrote:
> > > > > If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
> > > > > following (or very similar) on boot.
> > > > 
> > > > I should have said "if I don't disable", as the option is "default y".
> > > > 
> > > > Also, if it survives on boot, below is an example of later trouble (after
> > > > 30+ minutes on this occasion).
> > > 
> > > Please apply this patch so we (might) get a slightly better oops dump,
> > > and then try to reproduce.
> > 
> > Sure thing, but it's still "DAC: 00000051"...
> 
> Thanks, that confirms that something in the uaccess-with-memcpy code
> is clearing the DACR back to 0x51.
> 
> This has come up several times before, and I really can't spot the
> problem in this code, so I've always said to disable the
> uaccess-with-memcpy code.  Personally, I'd like to see the back
> of that code...

Ok, but it's not me doing crazy things if that's what you are implying
(not saying that you are), because the sama5_defconfig has

	CONFIG_UACCESS_WITH_MEMCPY=y

So, something needs to happen or sama5 remains default-broken.

Cheers,
Peter
