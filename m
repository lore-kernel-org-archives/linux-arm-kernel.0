From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 13:25:27 +0300
Subject: [RESEND PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <20160427095738.GG3217@sirena.org.uk>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-8-git-send-email-jszhang@marvell.com>
 <87bn4vpq7j.fsf@intel.com> <20160427095738.GG3217@sirena.org.uk>
Message-ID: <87oa8vmjqg.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Mark Brown <broonie@kernel.org> writes:
> On Wed, Apr 27, 2016 at 08:37:20AM +0300, Felipe Balbi wrote:
>> Jisheng Zhang <jszhang@marvell.com> writes:
>
>> > +	vbus = devm_regulator_get(&pdev->dev, "vbus");
>
>> devm_regulator_get_optional() ??
>
> Does USB work without a VBUS?  Unless the answer is yes then I'd expect

<joke> it can, just source VBUS from a lab power supply </joke>

> this to be just a normal regulator_get().

jokes aside, this regulator is optional because not all platforms
require a SW controlled regulator, no ? Will normal regulator_get() give
us a dummy regulator in case it's not listed in DT/ACPI ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/9958c49d/attachment.sig>
