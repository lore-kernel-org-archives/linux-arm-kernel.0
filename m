From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Apr 2016 11:35:21 +0100
Subject: [RESEND PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <87oa8vmjqg.fsf@intel.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-8-git-send-email-jszhang@marvell.com>
 <87bn4vpq7j.fsf@intel.com> <20160427095738.GG3217@sirena.org.uk>
 <87oa8vmjqg.fsf@intel.com>
Message-ID: <20160427103521.GJ3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 01:25:27PM +0300, Felipe Balbi wrote:
> Mark Brown <broonie@kernel.org> writes:

> > this to be just a normal regulator_get().

> jokes aside, this regulator is optional because not all platforms
> require a SW controlled regulator, no ? Will normal regulator_get() give
> us a dummy regulator in case it's not listed in DT/ACPI ?

Yes we do that, but even regulators that are not software controlled
should really be described anyway since it's a much simpler rule for
people to understand, it ensures that we can just scale up on systems
where there does happen to be software control and it makes all the
resulting code much simpler and hence less error prone if we're not
randomly ignoring some errors.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/7754733e/attachment.sig>
