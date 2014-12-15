From: ykk@rock-chips.com (Kuankuan.Yang)
Date: Mon, 15 Dec 2014 21:10:26 +0800
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <20141215120205.GZ11764@sirena.org.uk>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <20141215104029.GE11285@n2100.arm.linux.org.uk>
 <20141215120205.GZ11764@sirena.org.uk>
Message-ID: <548EDDC2.9050104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark & Russell:

thanks for your replay, what your say is right, those dt is merely 
describing the Linux kernel internals.
Instead of transmit cpu-of-node & codec-name & codec-dai-name through 
dt, i can give those an const
name to rockchip-hdmi-audio.c .

In that way, dt will only need compatible for creating sound device. is 
it ok  ?
sound {
     compatible = "rockchip,rk3288-hdmi-audio";
     status = "okay";
}
could you give me some advises.


Best Regards.

? 2014?12?15? 20:02, Mark Brown ??:
> On Mon, Dec 15, 2014 at 10:40:29AM +0000, Russell King - ARM Linux wrote:
>
>> Including details like this (because ASoC needs a separate DT node) is
>> the wrong approach.
> And indeed there should be no Linux-internal reason for that - we should
> be able to use whatever DT node makes sense, if there's some reason
> that's not possible we should fix that (we do have several drivers doing
> this sort of thing already though).
