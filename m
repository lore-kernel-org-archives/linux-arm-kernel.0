From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 03:02:33 -0700
Subject: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <1304080796-625-6-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
Message-ID: <20110504100232.GA2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>
> Also during bootup console_lock is not available.
>        --> uart_add_one_port
> 	   --> console_register
> 	       --> console_lock
> 	        --> console_unlock
> 	             --> call_console_drivers (here yet console_lock is not released)
> 		          --> uart_console_write
> 
> Hence convert prints from omap_device_enable/disable to pr_debug.

This sounds like a hack considering we have things working with
pr_debug currently.

Tony
