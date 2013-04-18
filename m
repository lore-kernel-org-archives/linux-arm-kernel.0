From: cb@sgoc.de (Christoph)
Date: Thu, 18 Apr 2013 15:13:55 +0200 (CEST)
Subject: Problem porting driver for OTP cells on Freescale i.MX28
Message-ID: <2001207140.384354.1366290836027.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello list,

currently I'm porting some drivers from the Freescale SDK based on 2.6.35 for
the i.MX28 to 3.7+ .
Working on the OTP eFuses I ran into a problem concerning clock sources. The OTP
driver requires to change the clock frequency of some logic blocks when writing
to OTP cells. In the original code from Freescale it requested "hclk" via
clk_get(). As this seems to be named "hbus" in the vanilla kernels I changed
this, but still clk_get() fails.
My patch can be found at http://www.sgoc.de/Downloads/fsl-otp.patch (NOTE: It
contains some printk for debugging and as stated above writing does not work).
Are there any hints on the clock API?



Regards,
Christoph Baumann
