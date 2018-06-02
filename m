From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 2 Jun 2018 19:43:07 +0200
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
Message-ID: <20180602174307.GB14870@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > And you should explain what exactly in PCI is "optional".  Who defines
> > this and where is that list and what can go wrong if those options are
> > not enabled?
> 
> Bjorn and I discussed the need for such a "safe" mode feature when you
> want to bring up PCI for a platform. You want to turn off everything as
> a starter and just stick to bare minimum.
> 
> I can add a few words describing them. The goal of this option is to keep
> base PCI features with MSI only. Things like PME, AER, ASPM, Extended
> Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. safemode
> is certainly not intended for production environments. 
> 
> I can taint the kernel as a suggestion.

I don't think tainting is required. even modern platforms should work
in the safe mode.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180602/317d320c/attachment.sig>
