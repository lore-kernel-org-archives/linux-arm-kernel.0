From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 11:51:43 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
Message-ID: <20151203115143.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 11:38:20AM +0000, Peter Rosin wrote:
> Russell King wrote:
> > On Thu, Dec 03, 2015 at 08:33:13AM +0000, Peter Rosin wrote:
> > > I wrote:
> > > > If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
> > > > following (or very similar) on boot.
> > > 
> > > I should have said "if I don't disable", as the option is "default y".
> > > 
> > > Also, if it survives on boot, below is an example of later trouble (after
> > > 30+ minutes on this occasion).
> > 
> > Please apply this patch so we (might) get a slightly better oops dump,
> > and then try to reproduce.
> 
> Sure thing, but it's still "DAC: 00000051"...

Thanks, that confirms that something in the uaccess-with-memcpy code
is clearing the DACR back to 0x51.

This has come up several times before, and I really can't spot the
problem in this code, so I've always said to disable the
uaccess-with-memcpy code.  Personally, I'd like to see the back
of that code...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
