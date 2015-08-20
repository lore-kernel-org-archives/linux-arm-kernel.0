From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Aug 2015 14:14:24 -0700
Subject: [PATCH v1 0/6] Add fec1 and fec2 support for i.MX7d sdb board
In-Reply-To: <20150820.140531.1320709021949935376.davem@davemloft.net>
References: <1439962444-27486-1-git-send-email-b38611@freescale.com>
 <20150820.140531.1320709021949935376.davem@davemloft.net>
Message-ID: <55D64330.4020503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/15 14:05, David Miller wrote:
> From: Fugang Duan <b38611@freescale.com>
> Date: Wed, 19 Aug 2015 13:33:58 +0800
> 
>> The patch series is to add fec support for i.MX7d sdb board. Since i.MX7d fec ip is
>> the same as i.MX6SX, so there have no change for driver itself.
>>
>> Patch#1: add bcm54220 PHY ID entry into brcmphy.h file.
> 
> This is completely, and utterly, pointless.
> 
> The only reason a PHY ID should be defined in brcmphy.h is so that it can
> be used in the broadcom.c PHY driver or similar.
> 
> If there is no user in the tree, there is no reason to add it to the
> header file.

There is a valid reason for which you may have a PHY id, which is
defining a PHY fixup in your platform code like Andy is doing, however,
this should not be used in conjunction with the Generic PHY driver,
because this driver has absolutely no clue about your PHY fixup, and
this could create at best inconsistencies in how the fixup is managed
later on.

At the very least, I would like to see a change to
drivers/net/phy/broadcom.c which identifies this PHY id, and eventually
just invokes the genphy_* functions where relevant.
-- 
Florian
