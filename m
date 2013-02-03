From: anton@enomsg.org (Anton Vorontsov)
Date: Sat, 2 Feb 2013 19:21:30 -0800
Subject: [PATCH] ab8500: btemp: demote initcall sequence
In-Reply-To: <1358915205-7786-1-git-send-email-rajanikanth.hv@stericsson.com>
References: <1358915205-7786-1-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <20130203032130.GB25016@lizard.sbx00618.mountca.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 09:56:45AM +0530, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> Power supply subsystem creates thermal zone device for
> the property 'POWER_SUPPLY_PROP_TEMP' which requires
> thermal subsystem to be ready before 'ab8500 battery temperature monitor'
> driver is initialized.
> ab8500 btemp driver is initialized with subsys_initcall whereas thermal
> subsystem is initialized with fs_initcall which causes
> thermal_zone_device_register(...) to crash since the required structure
> 'thermal_class' is not initialized yet.
> 
> crash log:
[...]
> Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
> ---

Applied and added Cc: stable.

Thanks!
