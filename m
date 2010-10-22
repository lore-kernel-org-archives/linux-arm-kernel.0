From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Oct 2010 11:05:53 -0700
Subject: [PATCH 1/3] OMAP: PM: formalize idle notifications
In-Reply-To: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20101022180553.GD17595@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101020 16:22]:
> Currently in the idle path, we have custom function calls into device
> code to handle device specific actions that need to be coordinated CPU
> idle transitions. Rather than continue this ad-hoc method of calling
> device code from the PM core, create a formal way for device/driver
> code to register for idle notifications.
> 
> Idle notifications are done late in the idle path when interrupts are
> disabled, hence use atomic notifier chains.  These notifications will
> also be atomic with respect to CPU idle transitions.

...

> +EXPORT_SYMBOL_GPL(omap_idle_notifier_register);
> +EXPORT_SYMBOL_GPL(omap_idle_notifier_unregister);

Let's rather set this up as a generic framework to avoid adding
more omap specific frameworks to the drivers.

Regards,

Tony
