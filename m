From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 16 May 2012 16:34:15 +0800
Subject: [PATCH v1 0/7] preliminary work for adding imx6q_sabrelite usb
 support
In-Reply-To: <20120516003748.GE29393@b20223-02.ap.freescale.net>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <201205151628.19020.marex@denx.de>
 <20120515152105.GE23916@kroah.com>
 <201205151830.15009.marex@denx.de>
 <20120516003748.GE29393@b20223-02.ap.freescale.net>
Message-ID: <20120516083414.GB22251@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Yes, I'd prefer to.
> Me too. I think we can start with review each other's patch.
> > 
> > Richard, are these 7 patches the only stuff that I have to apply on top of 
> > linux-usb/usb-next to get this working?
> Yes.

Hi Marek and Richard,

The i.mx28 and i.mx6q use the same USB controller and USB PHY,
Your patchset can be totally the same, only different is platform
part. Below are my commnets for your patchset:
- Use drivers/usb/otg/mxs-phy.c as PHY's driver.
- Use drivers/usb/chipidea/ci13xxx_imx.c as controller's driver,
all freescale usb uses the same controller.
- Use DT for platform support, phandle can work around current
multi-phy support problem. 

My proposal how you work together (already discussed with richard)
- Richard picks marek's controller's patch, and add DT support for
i.mx28, send marek, me, shawn privately.
- Marek tunes this DT patched patchset at i.mx28 platform,
and add Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
for patchset, and send to mail list for review
- Richard tests it and give some comments if there is any problems
at i.mx6q.
- Marek re-sends this patchset to mail list for review

Marek, if you agree with it, please take the responsibilities of the
owner with this patchset, and be active during this patchset review
procedure.

-- 

Best Regards,
Peter Chen
