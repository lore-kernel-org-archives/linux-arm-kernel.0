From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 8 Nov 2017 19:46:37 +0100 (CET)
Subject: [PATCH v2 06/12] hwrng: bcm2835-rng: Rework interrupt masking
In-Reply-To: <20171108004449.32730-7-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-7-f.fainelli@gmail.com>
Message-ID: <1086045224.63286.1510166797078@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Florian Fainelli <f.fainelli@gmail.com> hat am 8. November 2017 um 01:44 geschrieben:
> 
> 
> The interrupt masking done for Northstart Plus and Northstar (BCM5301X)
> is moved from being a function pointer mapped to of_device_id::data into
> a proper part of the hwrng::init callback. While at it, we also make the
> of_data be a proper structure indicating the platform specifics, since
> the day we need to add a second type of platform information, we would
> have to do that anyway.

in the lack of proper documentation for bcm2835 rng, is it possible that we should mask the interrupts for bcm2835 as well?
