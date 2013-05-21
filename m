From: davem@davemloft.net (David Miller)
Date: Mon, 20 May 2013 23:26:19 -0700 (PDT)
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
Message-ID: <20130520.232619.964940909999914694.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Libo Chen <libo.chen@huawei.com>
Date: Tue, 21 May 2013 10:42:00 +0800

> I find a lot of mistakes using struct platform_driver without owner.
> So I pick up some of them including usb and net modules

Instead of doing it this way, which is obviously error prone and
easy to forget, make platform_driver_register() be a macro which
sets the module owner field then calls the real __platform_driver_register().
