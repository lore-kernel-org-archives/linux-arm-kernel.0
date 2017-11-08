From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:26:48 -0800
Subject: [PATCH v2 06/12] hwrng: bcm2835-rng: Rework interrupt masking
In-Reply-To: <20171108004449.32730-7-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-7-f.fainelli@gmail.com>
Message-ID: <87k1z0y6c7.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> The interrupt masking done for Northstart Plus and Northstar (BCM5301X)
> is moved from being a function pointer mapped to of_device_id::data into
> a proper part of the hwrng::init callback. While at it, we also make the
> of_data be a proper structure indicating the platform specifics, since
> the day we need to add a second type of platform information, we would
> have to do that anyway.

I still think we should just unconditionally mask off the interrupt
regardless of platform if we're not going to use it in the driver and
some platforms need it.  Looks like a fine refactor, though:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/bfbdac45/attachment.sig>
