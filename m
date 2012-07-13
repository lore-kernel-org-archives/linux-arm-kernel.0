From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 13 Jul 2012 12:20:38 +0200
Subject: [PATCH v2] ARM: OMAP4: twl-common: Support for additional devices
 on i2c1 bus
In-Reply-To: <CAOMWX4e81gKYa_j8DHE_dn06+JfLwfEPuyj5kYVmDUBdG0n-1A@mail.gmail.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
 <CAOMWX4e81gKYa_j8DHE_dn06+JfLwfEPuyj5kYVmDUBdG0n-1A@mail.gmail.com>
Message-ID: <4FFFF676.1090304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2012 12:14 PM, Menon, Nishanth wrote:
> We still need a way to switch to I2C highspeed mode
> omap4_pmic_init still does register in 400KHz mode, while setting a bit in 6040
> should let us talk 3.3MHz on the bus.

We need to have a way to do this runtime I think. The twl6040 comes up with
100kbps as a default speed. So far we had no issue with 400kbps bus, but if we
increase it we might not be able to communicate with twl6040...

-- 
P?ter
