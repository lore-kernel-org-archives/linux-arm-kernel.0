From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 12:44:37 +0000
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <20120315102944.GB3138@opensource.wolfsonmicro.com>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <201203150840.42659.arnd@arndb.de>
 <20120315102944.GB3138@opensource.wolfsonmicro.com>
Message-ID: <201203151244.37483.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Mark Brown wrote:
> Similar code is going in for regulators in 3.4 along with the core
> -EPROBE_DEFER change (though not OF specific) and I sent a similar patch
> for GPIOs too, hopefully Grant will ack it in time for it to make it in.
> 
> My theory is that since you need to explicitly know that the thing
> you're requesting is there in order to request it (eg, have a PWM number
> or DT link) the overwhemlingly common case for a failure to request will
> be that the provider didn't register yet which is exactly the case where
> deferral is desired.  It therefore seems sensible to have the framework
> default the drivers to retrying rather than have almost every individual
> driver look at the failure, figure out if it was a missing provider, and
> then retry.  Drivers that have a good reason to fail can always check
> for -EPROBE_DEFER and override it.
> 
> The result should be that we can take advantage of probe deferral over
> large areas of the kernel without having to go and explicitly modify so
> many drivers - if the frameworks like GPIO, clk and regulator can do
> this that ought to cover 90% of the cases where probe deferral will be
> needed without having to do anything more than have good error handling
> paths on probe which is a good idea anyway.

Ok, makes sense.

Thanks,
	
	Arnd
