From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 13:55:29 +0100
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1437047261.28351.6.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl>
Message-ID: <20150716125529.GG4039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 01:47:41PM +0200, Paul Bolle wrote:
> On do, 2015-07-16 at 12:00 +0100, Mark Brown wrote:

> > You've got platform_device and platform_driver confused I think.

> I did? You mean that creating a platform_DRIVER triggers that
> MODALIAS=platform:{...] uevent?

No, in that case you've not understood what the MODULE_ALIAS is
for.  It's there so that userspace knows which module to load if it gets
a device with no driver, it goes in the driver not in the code
registering the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/6ba9189f/attachment.sig>
