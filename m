From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 07:55:27 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731115027.GN9858@sirena.org.uk>
References: <1375232669-27846-2-git-send-email-festevam@gmail.com>
 <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
Message-ID: <20130731115527.GR2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 12:50:27PM +0100, Mark Brown wrote:
> Most things would work just fine - most of the uses of devm_ are just
> resource allocations that can safely be freed in essentially any order.
> It doesn't really matter if you free the driver's private structure
> before you free the clock that's pointing to it or whatever since
> neither has any real connection to the other.

If you have DMA / IRQ / command engine deactivations in devm path
which often is the case with full conversions, freeing any resources
including DMA areas and host private data in the wrong order is a
horrible idea.  It's worse as it won't really be noticeable in most
cases.

Thanks.

-- 
tejun
