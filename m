From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Oct 2013 16:53:26 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <52529B1A.7060306@gmail.com>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
 <52529B1A.7060306@gmail.com>
Message-ID: <20131007155326.GP21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 01:29:30PM +0200, Sebastian Hesselbarth wrote:

> I2S _can_ support more than two channels, but only if you wire up more
> DATA lines. Those are not available on Dove, so its I2S is limited to
> two channel audio.

A lot of devices implement extra channels with TDM rather than with
extra wires - you get all the left channels and all the right channels
grouped together (like with DSP/PCM modes except the channels are
ordered differently).  I'm never sure that's actually useful, though,
since it's not something that just works with most hosts that don't
understand it in hardware and most of those can do DSP/PCM anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/68e92cf3/attachment.sig>
