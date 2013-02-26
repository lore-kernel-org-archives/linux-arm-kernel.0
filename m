From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Feb 2013 11:42:34 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
 <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
Message-ID: <20130226094234.GC26189@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 05:24:42PM +0800, Peter Chen wrote:
> If the probe fails, the ci13xxx_add_device will not return error,
> (bus_probe_device doesn't has return value)
> therefore, the platform layer can't know whether core's probe
> is successful or not, if platform layer goes on using core's struct
> which is initialized at core's probe, the error will occur.
> 
> This error is showed when I only compile gadget, the host-only
> controller reports "no supported roles", and fails probe, but imx
> platform code doesn't know it, and goes on using core's private data.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

this just tells you that platform code shouldn't be using the driver
directly. passing probe_retval via platform_data is an abomination, fix
the real problem instead, whatever it is.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130226/b1d050bd/attachment.sig>
