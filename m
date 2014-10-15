From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 15 Oct 2014 14:52:13 +0200
Subject: [PATCH 0/7] power_supply: Decrement the device reference counter
In-Reply-To: <20141015121841.GA26579@amd>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
 <20141015121841.GA26579@amd>
Message-ID: <1413377533.26771.16.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-10-15 at 14:18 +0200, Pavel Machek wrote:
> Hi!
> 
> > The reference counter of device allocated for power supply was
> > incremented with each call to power_supply_get_by_name() and
> > power_supply_get_by_phandle().
> > 
> > Add a symmetric 'put' operation so the device could be released after
> > final put_device() call during supply unregistering.
> > 
> > 
> > Rebased on next-20141007 + mine [1] patchset.
> > Tested on Trats2 board (max77693 + charger manager).
> > 
> > Kindly asking for reviewing/testing other drivers.
> 
> I'm not sure if we should support power_supply_put(NULL), but
> otherwise the series looks ok to me.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for reviewing. I'll remove the non-NULL check and resend with
your ack.

Best regards,
Krzysztof
