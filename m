From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 15 Sep 2011 08:32:02 -0300
Subject: [PATCHv2 3/3] picoxcell: add the DTS for the PC7302 board
In-Reply-To: <1314196906-20709-4-git-send-email-jamie@jamieiles.com>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
	<1314196906-20709-4-git-send-email-jamie@jamieiles.com>
Message-ID: <1316086322.2602.1.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-24 at 15:41 +0100, Jamie Iles wrote:

> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk loglevel=9 root=ubi0:rootfs rw rootfstype=ubifs ubi.mtd=5,2048";
> +		linux,stdout-path = &uart0;
> +	};

Hrm... we don't normally put the bootargs in the device-tree.

Either you have a way to pass it from a previous firmware (which
can then slap it into the device-tree at runtime), or you
can have a way to compile it in the kernel image but the device-tree
isn't the right place for it.

Cheers,
Ben.
