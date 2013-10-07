From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Oct 2013 18:05:48 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <5252DC6C.9060503@gmail.com>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
 <52529B1A.7060306@gmail.com> <20131007155326.GP21581@sirena.org.uk>
 <5252DC6C.9060503@gmail.com>
Message-ID: <20131007170548.GR21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 06:08:12PM +0200, Sebastian Hesselbarth wrote:

> True, I didn't mention TDM modes squeezing multiple channels into one
> L/R frame. Neither Dove nor TDA998x support this, but thanks for the
> clarification.

Depending on how the DMA and so on is done you can sometimes still do it
on the CPU side by lying to the CPU about the data format (eg, tell it
that two 16 bit samples are actually a 32 bit one) though it gets messy
for I2S since you need to be able to gather all the left samples and all
the right samples.  Though given that your CODEC doesn't support it it's
still all moot anyway as you say.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/bd99b77f/attachment.sig>
