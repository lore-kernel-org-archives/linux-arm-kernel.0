From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 Apr 2014 18:49:53 +0200
Subject: dma_alloc_coherent and cache?
In-Reply-To: <30E320E3-FE79-4E2B-89D3-07E0D6EE975C@nowonline.co.uk>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
 <4356499.vN3lxjGqPZ@wuerfel>
 <E94CEA02-A987-4212-A0CA-D0CDC80E7250@nowonline.co.uk>
 <4292964.mUEmdLVWYx@wuerfel>
 <30E320E3-FE79-4E2B-89D3-07E0D6EE975C@nowonline.co.uk>
Message-ID: <20140415164953.GE1871@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ENTRY(cpu_arm926_do_idle)
> #ifdef CONFIG_ARCH_FEROCEON
>         /* Implement workaround for FEr# CPU-C16: Wait for interrupt command */
>         /* is not processed properly, the workaround is not to use this command */
>         /* the erratum is relevant for 5281 devices with revision less than C0 */

5281 is the old Orion5x devices, not kirkwood. So is not relevant. You
should be keeping an eye out for 6xxx issues, which would be Kirkwood.

       Andrew
