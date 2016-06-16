From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 16 Jun 2016 12:19:13 +0100
Subject: [QUERY] AMBA: PM domains when !CONFIG_PM
Message-ID: <57628B31.3090901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, Kevin,

I have a situation where we need to enable the power domain to access an
AMBA device. This is all fine with patches from Ulf and Marek in amba/bus.c

The problem is when we disable CONFIG_PM, dev_pm_domain_attach
returns -ENODEV irrespective of whether a DT node has a PM domain
in it or not. If dev_pm_domain_attach returns anything other than
-EPROBE_DEFER, we ignore the error and proceed to access the device
which will explode.

Basically, we need a way to prevent addition of that amba device if DT
node has PD specified but CONFIG_PM=n. Any thoughts ?

-- 
Regards,
Sudeep
