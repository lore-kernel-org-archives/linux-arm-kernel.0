From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Tue, 2 Jan 2018 12:34:59 +0000
Subject: [PATCH] arch: drop duplicate exports of abort()
In-Reply-To: <20180102113829.GD28752@n2100.armlinux.org.uk>
References: <20180102103311.706364-1-arnd@arndb.de>
 <20180102113417.GA5078@sudip-tp>
 <20180102113829.GD28752@n2100.armlinux.org.uk>
Message-ID: <20180102123459.GA6354@sudip-tp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 11:38:29AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 02, 2018 at 11:34:45AM +0000, Sudip Mukherjee wrote:
> > Hi Arnd,
> > 
> > On Tue, Jan 02, 2018 at 11:31:12AM +0100, Arnd Bergmann wrote:
> > > We now have exports in both architecture code in in common code,
> > > which causes a link failure when symbol versioning is eanbled, on
> > > four architectures:
> > > 
> > > kernel/exit.o: In function `__crc_abort':
> > > exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
> > > 
> > > This removes the four architecture specific exports and only
> > > leaves the export next to the __weak symbol.
> > 
> > Will it not be better to remove the abort() as they are exactly same
> > like the weak function. That was the original plan we had when this
> > weak function was done. Like in the attached patch..
> 
> If that was the plan, why wasn't it done - why did we end up with a
> build-breaking patch merged in -mm?

The proposed patch (which I attached in the earlier mail) was breaking
the build unless weak abort() is exported. So, ideally the export of
weak abort() and the proposed patch should have been part of a series.
But afaik, the export has been done to fix another build failure reported
by Vineet.

Andrew, I think the best way now is to apply the patch sent by Arnd,
and I will send a separate patch to remove abort() after proper testing.


--
Regards
Sudip
