From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 20:42:52 +0100
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140702195154.47d6f6b4@armhf>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
Message-ID: <20140702194252.GN410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:51:54PM +0200, Jean-Francois Moine wrote:

> I tested this CODEC with both DAPM and DPCM. If the audio subsystem
> asks for streaming on both I2S and S/PDIF, only the last call is served
> (this depends on the order of the DAI links in the audio card creation
> table).

I'd expect this to return an error for the busy DAI rather than just
silently ignore it failing to start or (better) implement some control
to let the user select which of the DAIs is active.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/bc2ef7e8/attachment-0001.sig>
