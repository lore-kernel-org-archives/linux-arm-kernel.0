From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 10:07:58 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731135751.GT9858@sirena.org.uk>
References: <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <20130731134215.GS2810@htj.dyndns.org>
 <20130731135751.GT9858@sirena.org.uk>
Message-ID: <20130731140758.GT2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 02:57:51PM +0100, Mark Brown wrote:
> That's the only API I've ever heard of doing that.  Everything else is
> just using it to do deallocation.

I'm not sure why or what you're trying to argue here but take a look
at devm_pwm_release() for example.  It calls back into low level
driver free routine.  Are you arguing that it'd be a good idea to
release pci regions before this is complete?  It's just stupid to do
any differently.  There's nothing to argue about.

-- 
tejun
