From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Jan 2014 18:10:32 +0000
Subject: Question: about wm8904's regulator consumer nodes
In-Reply-To: <B256D81BAE5131468A838E5D7A24364172F64369@penmbx01>
References: <B256D81BAE5131468A838E5D7A24364172F64369@penmbx01>
Message-ID: <20140121181032.GI17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 07:10:24AM +0000, Yang, Wenyou wrote:

>                                          DCVDD-supply = <&vcc_1v8_reg>;
>                                          DBVDD-supply = <&vddana_reg>;
>                                          AVDD-supply = <&vcc_1v8_reg>;
>                                          CPVDD-supply = <&vcc_1v8_reg>;
>                                          MICVDD-supply = <&vddana_reg>;

> 	But the power of DCVDD, DBVDD, AVDD, CPVDD and MICVDD is not supplied by any regulators, not the above regulator nodes.

> 	How do I deal with this case? Could you give me some advice?

You should set up the supplies to point to whatever regulator is
supplying the power.  If there are supplies on the board which are
generated using fixed voltage regulators then you should register those
using the fixed regulator driver.  Recent kernels are more tolerant of
missing supplies but it's still better to be explicit if you can be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/c4ed9767/attachment.sig>
