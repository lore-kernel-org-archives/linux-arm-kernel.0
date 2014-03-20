From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 20 Mar 2014 10:34:40 +0100
Subject: [PATCH RESEND v2 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <20140320090330.49a1d372@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Thu, 20 Mar 2014 09:03:30
 +0100")
References: <20140317144016.0508cc4d@marrow.netinsight.se>
 <20140317144235.546d2e19@marrow.netinsight.se>
 <201403181558.37094.arnd@arndb.de>
 <20140320090330.49a1d372@marrow.netinsight.se>
Message-ID: <m31txxjjrj.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> Thanks. However, Krzysztof thinks that this implementation is
> incorrect. It certainly fixes my ixp4xx issues, but might not be good
> for everyone.

It because you don't have PCI devices setting coherent mask to 32-bits
(and that's what normal PCI devices do).

BTW PCI (and other) devices requesting 32-bit coherent allocs don't care
if they're given 26-bit memory. 26 bits fit perfectly in 32 bits. It's
the streaming mapping which is (may be) constrained by hardware.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
