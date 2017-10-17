From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 17 Oct 2017 17:37:49 +0000
Subject: [PATCH 2/2] PCI: imx6: Check for link training status in link up
 check
In-Reply-To: <1508229842.2146.4.camel@pengutronix.de>
References: <20171017001159.109152-1-tpiepho@impinj.com>
 <20171017001159.109152-2-tpiepho@impinj.com>
 <1508229842.2146.4.camel@pengutronix.de>
Message-ID: <1508261868.110408.5.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-17 at 10:44 +0200, Lucas Stach wrote:
> Am Montag, den 16.10.2017, 17:11 -0700 schrieb Trent Piepho:
> > 
> > 
> > There result is no link training check.
> > 
> > Then commit dac29e6c5460 ("PCI: designware: Add default link up check if
> > sub-driver doesn't override")
> 
> I think you meant 01c076732e82 (PCI: designware: Check LTSSM training
> bit before deciding link is up) here.
> 
> >  added a link training check to the default
> > version of dw_pcie_link_up(), but since imx6 uses imx6_pcie_link_up() it
> > does not use the default version with this fix.

It was really the combination of both commits.  'dac added the common
link up check, which imx6 didn't use, and then '01c added the training
check to it.  It appears I've attributed both changes to 'dac in my
message and forgot '01c.  I'll fix.
