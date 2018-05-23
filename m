From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 22 May 2018 18:20:41 -0700
Subject: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
In-Reply-To: <20180523001503.GA16062@lunn.ch>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
 <20180523001503.GA16062@lunn.ch>
Message-ID: <89a1f8d7-5303-f3c0-aa38-43e64488ec5a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 05/22/2018 05:15 PM, Andrew Lunn wrote:
> On Tue, May 22, 2018 at 05:04:49PM -0700, Florian Fainelli wrote:
>> On newer PHYs, we need to select the expansion register to write with
>> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
>> to being migrated to generic code under bcm-phy-lib.c which
>> unfortunately used the older implementation from the BCM54xx days.
> 
> Hi Florian
> 
> Does selecting the expansion register affect access to the standard
> registers? Does this need locking like the Marvell PHY has when
> changing pages?

We should probably convert this to the page accessors since the
expansion, misc and other shadow 0x1c accesses are all indirection
layers to poke into a different address space of the PHY. That would be
a separate fix though for a number of reasons.
-- 
Florian
