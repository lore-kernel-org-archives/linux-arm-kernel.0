From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 15:51:56 +0000
Subject: [V4 PATCH 18/26] usb: phy: mv_usb2_phy: add externel chip support
In-Reply-To: <1358762864-9249-19-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
 <1358762864-9249-19-git-send-email-chao.xie@marvell.com>
Message-ID: <20130121155156.GM23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 05:07:36AM -0500, Chao Xie wrote:
> +	mv_phy->extern_chip.head = devm_kzalloc(&pdev->dev,
> +					sizeof(*mv_phy->extern_chip.head),
> +					GFP_KERNEL);
> +	if (mv_phy->extern_chip.head == NULL)
> +		return -ENOMEM;
> +	ATOMIC_INIT_NOTIFIER_HEAD(mv_phy->extern_chip.head);

Why do you need to allocate an atomic notifier list head as an entirely
separate data structure?
