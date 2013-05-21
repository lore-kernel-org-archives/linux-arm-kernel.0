From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 08:41:08 +0200
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <20130520.232619.964940909999914694.davem@davemloft.net>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
 <20130520.232619.964940909999914694.davem@davemloft.net>
Message-ID: <20130521084108.1a585f32@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David Miller,

On Mon, 20 May 2013 23:26:19 -0700 (PDT), David Miller wrote:
> From: Libo Chen <libo.chen@huawei.com>
> Date: Tue, 21 May 2013 10:42:00 +0800
> 
> > I find a lot of mistakes using struct platform_driver without owner.
> > So I pick up some of them including usb and net modules
> 
> Instead of doing it this way, which is obviously error prone and
> easy to forget, make platform_driver_register() be a macro which
> sets the module owner field then calls the real
> __platform_driver_register().

Or, maybe make the existing module_platform_driver() macro do this?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
