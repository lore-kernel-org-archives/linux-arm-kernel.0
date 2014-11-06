From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 05:32:53 +0000
Subject: [PATCHv0 2/3] rtc: rtc-isl12057: fix isil vs isl naming for
 intersil
In-Reply-To: <2ac5b475fd757ea771296ea0731de75d963999ef.1415222752.git.arno@natisbad.org>
References: <cover.1415222752.git.arno@natisbad.org>
 <2ac5b475fd757ea771296ea0731de75d963999ef.1415222752.git.arno@natisbad.org>
Message-ID: <20141106053253.GK8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 10:42:41PM +0100, Arnaud Ebalard wrote:

> When Intersil ISL12057 driver was introduced by commit 70e123373c05
> (rtc: Add support for Intersil ISL12057 I2C RTC chip), the vendor
> prefix 'isl' was used instead of the expected 'isil' (Intersil
> NASDAQ symbol). Recently, a patch from Philip Zabel (7a6540ca856a,
> ARM: mvebu: Change vendor prefix for Intersil Corporation to isil)
> fixed that prefix in ReadyNAS devices .dts files (AFAICT, the only
> kernel users at the moment).

They may be the only in kernel users but someone with an out of tree DT
may be using the existing prefix, we shouldn't break compatibility with
them so we should support both compatible strings even if we want to
deprecate the isl, one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/78ac7a76/attachment-0001.sig>
