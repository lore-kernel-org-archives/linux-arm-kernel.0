From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 25 Aug 2014 23:18:23 +0200
Subject: [PATCH 04/29] drivers: base: add notifier for failed driver bind
In-Reply-To: <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140825211823.GH16329@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 12:47:32PM +0200, Marek Szyprowski wrote:
> +	if (failed && dev->bus)
> +		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> +					     BUS_NOTIFY_DRVBIND_FAILED, dev);
> +

Why can't you just use the notifier for BUS_NOTIFY_UNBIND_DRIVER or
BUS_NOTIFY_UNBOUND_DRIVER when something goes wrong in driver
initialization?


	Joerg
