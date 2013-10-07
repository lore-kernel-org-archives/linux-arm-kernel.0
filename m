From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 07 Oct 2013 18:08:12 +0200
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007155326.GP21581@sirena.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk> <52529B1A.7060306@gmail.com>
 <20131007155326.GP21581@sirena.org.uk>
Message-ID: <5252DC6C.9060503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 05:53 PM, Mark Brown wrote:
> On Mon, Oct 07, 2013 at 01:29:30PM +0200, Sebastian Hesselbarth wrote:
>
>> I2S _can_ support more than two channels, but only if you wire up more
>> DATA lines. Those are not available on Dove, so its I2S is limited to
>> two channel audio.
>
> A lot of devices implement extra channels with TDM rather than with
> extra wires - you get all the left channels and all the right channels
> grouped together (like with DSP/PCM modes except the channels are
> ordered differently).  I'm never sure that's actually useful, though,
> since it's not something that just works with most hosts that don't
> understand it in hardware and most of those can do DSP/PCM anyway.

True, I didn't mention TDM modes squeezing multiple channels into one
L/R frame. Neither Dove nor TDA998x support this, but thanks for the
clarification.
