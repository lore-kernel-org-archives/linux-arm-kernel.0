From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 10:12:32 +0200
Subject: [alsa-devel] [PATCH 3/4] ASoC: mediatek: add BT implementation
In-Reply-To: <1467683533.4212.16.camel@mtksdaap41>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
 <20160704144406.GH6247@sirena.org.uk>
 <1467683533.4212.16.camel@mtksdaap41>
Message-ID: <20160705081232.GL6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 09:52:13AM +0800, Garlic Tseng wrote:
> On Mon, 2016-07-04 at 16:44 +0200, Mark Brown wrote:

> > We really shouldn't be writing the registers or other internal data of
> > the device.  Instead we should be getting the driver for the relevant
> > hardware component to do it.  If we just write to registers that makes
> > the interoperation with the real driver for the device more fragile than
> > it should be, people might update the main driver without noticing the
> > external driver.

> The AUDIO_TOP_CON4 is a reg of the ASoC hw module. All the registers
> which are set in the btmrg operator belong to ASoC hardware. The reg
> writing you mention above is to power up the MRG interface in the ASoC
> module.

The problem is that this is the machine driver, not a driver for the
chip that's being controlled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/3ec84cf9/attachment.sig>
