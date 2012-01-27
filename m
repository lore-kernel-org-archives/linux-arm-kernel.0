From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 27 Jan 2012 09:10:33 +0100
Subject: [PATCH] arm: Fix missing api-change from subsys_interface change
In-Reply-To: <033301ccd18f$64ac8c60$2e05a520$%kim@samsung.com>
References: <201201121430.49448.heiko@sntech.de>
 <20120112160605.GA10831@suse.de>
 <033301ccd18f$64ac8c60$2e05a520$%kim@samsung.com>
Message-ID: <201201270910.34247.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. Januar 2012, 02:05:08 schrieb Kukjin Kim:
> Greg KH wrote:
> > On Thu, Jan 12, 2012 at 02:30:48PM +0100, Heiko St?bner wrote:
> > > Commit 4a858cfc9a (arm: convert sysdev_class to a regular subsystem)
> > > converted the samsung sysdevs into subsys_interface instances.
> > > 
> > > While the original add-function only had a (struct sys_device *)
> > > parameter, the dev_add from subsys_interface needs
> > > 
> > > 	(struct device *, struct subsys_interface *)
> > > 
> > > leading to "initialized from incompatible pointer type" warnings.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > The patch applies cleanly against the current driver-core git,
> > > hopefully it's the right tree.
> > 
> > Thanks for fixing this up, sorry for getting it wrong.
> > 
> > This should be done against the Samsung arm git tree, and go in through
> > that one.  The driver-core git tree is equal to Linus's tree of a few
> > days ago, there are no driver-core patches in it at the moment.
> > 
> > Kukjin, can you take these?
> 
> Sure, let me pick this up in my fixes.

Hi Kgene,

ping :-)

I checked the hopefully correct branch v3.3-samsung-fixes and the patch is not 
in there.

Heiko
