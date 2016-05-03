From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 May 2016 17:29:38 +0100
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160503162938.GT6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2016 at 11:15:34PM +0200, Robert Jarzmik wrote:
> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
> controller to 0 to 4 AC97 codecs.

> The goal of this new implementation is to implement a device/driver
> model for AC97, with an automatic scan of the bus and automatic
> discovery of AC97 codec devices.

I think this is basically what I was thinking of, yes.  One thing we'll
need to do is work out how to handle systems that need some explicit
action to start clocks for the bus clock, though they were never very
common and it's entirely possible nobody cares any more so perhaps we
just punt and see if anyone notices for now.

> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
> +				     struct device *dev);
> +int ac97_digital_controller_unregister(const struct device *dev);

Why "digital"? 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160503/22fb87c5/attachment.sig>
