From: dave.mueller@gmx.ch (=?UTF-8?Q?David_M=c3=bcller?=)
Date: Thu, 18 Jun 2015 11:10:49 +0200
Subject: [PATCH] ARM: imx6: Fix non-working MSI interrupts if PCIe
 switch is attached
In-Reply-To: <1434616169.3061.5.camel@pengutronix.de>
References: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
 <1434616169.3061.5.camel@pengutronix.de>
Message-ID: <55828B19.5070608@gmx.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas Stach wrote:
> I need more explanation for this one. MSI interrupts were certainly
> working fine even with a PCIe switchin between some time back. I think I
> personally tested things with 3.19.
> 
> In the bug report you mention that the MSI_ADDR registers are
> overwritten. Where does the write come from and why is it done?

I don't know. I just instrumented the driver with code to dump the
MSI_ADDR registers and noticed that they were programmed with the
correct value once, but at a later point in time, the value is gone.

Perhaps it's a some kind of partial HW reset of the PCIe host?

I'm working with a rev 1.2 silicon of the i.MX6Q.
