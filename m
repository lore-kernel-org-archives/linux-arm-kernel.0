From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Sep 2014 15:53:00 +0100
Subject: [PATCH 5/6] tty/serial: Add Spreadtrum's serial earlycon
In-Reply-To: <1411992293-7729-6-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-6-git-send-email-zhang.lyra@gmail.com>
Message-ID: <20140929145300.GQ16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 08:04:52PM +0800, zhang.lyra at gmail.com wrote:

> +config SERIAL_EARLYCON_SPRD
> +	bool "Early console using SPRD serial"
> +	depends on ARM64

This code doesn't appear to be ARM64 specific so adding an ||
COMPILE_TEST will allow better build time coverage for people doing
generic work on the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/7f95f88e/attachment.sig>
