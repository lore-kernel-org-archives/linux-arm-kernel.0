From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Mon, 13 Dec 2010 12:28:24 -0600
Subject: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
In-Reply-To: <1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTi=HvDiirrfXMXmzZkrm6NwAdZJQERs5F86Jj6TG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> - ? ? ? mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
> - ? ? ? if (IS_ERR(mbox_ick_handle)) {
> - ? ? ? ? ? ? ? printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
> - ? ? ? ? ? ? ? ? ? ? ? PTR_ERR(mbox_ick_handle));
> - ? ? ? ? ? ? ? return PTR_ERR(mbox_ick_handle);
> - ? ? ? }
> - ? ? ? clk_enable(mbox_ick_handle);
> + ? ? ? pm_runtime_get_sync(&mbox_pdev->dev);

Might be good to check the return value.


Thank you,
Best regards,
Hari Kanigeri
