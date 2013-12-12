From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 12:27:21 -0600
Subject: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
In-Reply-To: <20131209085245.GB5231@xps8300>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <525E8E93.9010503@ti.com> <525E9046.3090209@ti.com>
 <525E943E.3080706@ti.com> <20131017145425.GE11611@gimli>
 <20131203103950.GB26423@xps8300>
 <20131206201530.GA21086@saruman.home>
 <20131209085245.GB5231@xps8300>
Message-ID: <20131212182721.GL1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 10:52:45AM +0200, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, Dec 06, 2013 at 02:15:30PM -0600, Felipe Balbi wrote:
> > On Tue, Dec 03, 2013 at 12:39:50PM +0200, Heikki Krogerus wrote:
> > > On Thu, Oct 17, 2013 at 09:54:26AM -0500, Felipe Balbi wrote:
> > > > On Wed, Oct 16, 2013 at 04:27:26PM +0300, Roger Quadros wrote:
> > > > > On 10/16/2013 04:10 PM, Kishon Vijay Abraham I wrote:
> > > > > Do you know if there are users of dwc3 other than exynos5250 and omap5?
> > > > > If not, we should get rid of the old USB PHY altogether.
> > > > 
> > > > Intel's Baytrail, at least. But they don't use DT.
> > > 
> > > I don't see any use for the generic-phy when the device is enumerated
> > > from PCI. If dwc3 can live without phys, there should not be any
> > > problem dropping the old USB PHY support.
> > 
> > yeah, I don't want to drop PHY support, I want to require everybody to
> > provide a PHY, otherwise we have too many options to handle and that's
> > never clean.
> 
> I have to clarify in case there was a misunderstanding. When I said
> generic-phy I meant drivers/usb/phy/phy-generic.c and I was not
> talking about Kishon's new generic PHY framework.
> 
> So I was only saying that if the dwc3-pci.c is the only thing that
> needs the old usb phy support, then there should not be any problem
> dropping the support for it.

oh, ok. Got it now, thanks.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/f4014618/attachment.sig>
