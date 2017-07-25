From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Jul 2017 01:55:17 -0700
Subject: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
In-Reply-To: <20170724095201.21601-1-johan@kernel.org>
References: <20170724095201.21601-1-johan@kernel.org>
Message-ID: <20170725085517.GQ10026@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <johan@kernel.org> [170724 02:53]:
> Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> device with an active child"), which went into 4.10, it is no longer
> permitted to set RPM_SUSPENDED state for a device with active children
> (unless power.ignore_children is set).
> 
> This specifically means that the attempts to do just that from the omap
> pm-domain suspend_noirq callback have since been failing whenever a
> child is active, for example:
> 
>   am335x-usb-childs 47400000.usb: runtime PM trying to suspend
>     device but active child
> 
> Silence this warning by dropping the broken pm_runtime_set_suspended()
> call from the omap suspend_noirq callback along with the redundant
> pm_runtime_set_active() in resume_noirq.

With this things still work for me for my PM tests on omap3. Device
suspends and resumes just fine hitting off mode during suspend.

Regards,

Tony
