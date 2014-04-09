From: bp@alien8.de (Borislav Petkov)
Date: Wed, 9 Apr 2014 13:03:39 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <CAGnW=BYJxEkhAitCGi-i6+260-i-+GPrg0yPcY=M+7YmDF6ZRw@mail.gmail.com>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic>
 <CAGnW=BYJxEkhAitCGi-i6+260-i-+GPrg0yPcY=M+7YmDF6ZRw@mail.gmail.com>
Message-ID: <20140409110339.GF6529@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 11:34:31AM +0530, punnaiah choudary kalluri wrote:
> Since it is recommended in Documentation/kernel-doc-nano-HOWTO.txt
> but also said it is low priority and at the discretion of the MAINTAINER of
> that kernel source file
> 
> So, if you recommend not use kernel-doc annotation then i will take care
> in next version.

I don't think there's need for documenting those functions for
kernel-doc - it is an EDAC driver and not some subsystem function with a
lot of users.

> devm_ioremap_resource function will check this condition, so not
> checking for the NULL explicitly

And it would say

	dev_err(dev, "invalid resource\n");

so we'll know what fails, ok.

> Since the probe returns error, it it that the devm_ framework will
> clean these resources automatically?

Ah, that's the managed thing, ok.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
