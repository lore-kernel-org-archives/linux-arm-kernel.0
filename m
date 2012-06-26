From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 26 Jun 2012 11:38:07 +0530
Subject: [PATCHv10 1/7] I2C: OMAP: I2C register restore only if context
 is lost
In-Reply-To: <20120625123000.GB30463@arwen.pp.htv.fi>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com>
 <20120625123000.GB30463@arwen.pp.htv.fi>
Message-ID: <4FE951C7.8070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 June 2012 06:00 PM, Felipe Balbi wrote:
>> Cc: Kevin Hilman <khilman@ti.com>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> how will this ever work with DT ? 
What you say makes sense however that is what currently
most of the omap drivers do.

Will check on this.
> I say we get rid of the OMAP-specific
> API and build this "context lost" status directly on dev_pm_info and
> have something like pm_runtime_lost_context() or something with pm QoS
> tell you if a device has lost its context.
>
> Also, your commit log doesn't really state any problems you might have
> reached before, or any improvements wrt latency coming out of suspend
> and so on.
>
> IMHO, drivers need a generic way to differentiate if they're resuming
> from OFF or RET, otherwise we will end up with a bunch of OMAP-specific
> hackery on all drivers
