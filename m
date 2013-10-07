From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 07 Oct 2013 13:29:30 +0200
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007110902.GL12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
Message-ID: <52529B1A.7060306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:09 PM, Russell King - ARM Linux wrote:
> On Mon, Oct 07, 2013 at 12:48:20PM +0200, Jean-Francois Moine wrote:
>> On Mon, 7 Oct 2013 10:44:04 +0100
>> Rabeeh did the most he could to have a working Cubox. He used bad
>> written drivers and he had not the time to think about how the drivers
>> could be enhanced.
>
> What does I2S give us in terms of "enhancement" which SPDIF does not,
> remembering that audio is transmitted over HDMI in a format which closely
> resembles SPDIF (but with a 28-bit subframe size.)

With respect to what _most_ users want, we should use SPDIF and ignore
I2S. Consumer audio fits well into SPDIF and we get pass-through, which
we loose on I2S.

I2S _can_ support more than two channels, but only if you wire up more
DATA lines. Those are not available on Dove, so its I2S is limited to
two channel audio.

The CuBox is simply not designed for HBR or multi-channel PCM, it is a
_consumer_ settop box replacement.

Sebastian
