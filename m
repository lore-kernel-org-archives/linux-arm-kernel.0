From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 26 Apr 2016 10:23:02 -0700
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <20160426121335.GC11668@lunn.ch>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
 <20160425205650.GA31129@lunn.ch>
 <666dffb41a922b0c8638f2f002a2de08@mail.gmail.com>
 <20160426121335.GC11668@lunn.ch>
Message-ID: <571FA3F6.7000903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 05:13, Andrew Lunn wrote:
>> 4. Apart from these, by using MDIO mux framework we are making our
>> non-ethernet PHYs dependent on Linux network drivers which is not
>> acceptable. What if some product line does not need network subsystem at
>> all?
> 
> This is your only valid point. However, does Broadcom have a product
> line which does not include networking? Is not Broadcom a network SoC
> vendor?

But even with that, there is no reason why we could not decouple the
PHYLIB MDIO framework from PHYLIB and make it available as a more
standalone subsystem which can be utilized when you have a mix of MDIO
devices like here.

I am not clear on how common a shared MDIO bus is on other SoCs, but the
other Broadcom SoCs I am familiar with have dedicated MDIO buses
instances per type of PHY (PCIe, BUSB, Ethernet), thus making the split
a ton easier.
-- 
Florian
