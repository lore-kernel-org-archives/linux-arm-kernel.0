From: robdclark@gmail.com (Rob Clark)
Date: Wed, 23 Oct 2013 21:14:17 -0400
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131021092730.GF30088@pengutronix.de>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
Message-ID: <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 5:27 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> If a subsystem doesn't work well with DT, then the choices are either:
>>
>> (a) don't use DT with the subsystem
>
> The underlying problem has nothing to do with DT. Multi component
> hardware does exist and won't vanish when we stop using DT.
>
>> (b) fix the subsystem
>
> I'd love to do that. Step one to this seems to be to increase the
> awareness that there's something wrong with DRM.


Note that I suspect your idea of "fixing drm" is going to break some
userspace assumptions about the hw (ie. userspace isn't expecting
crtcs/encoders/connectors to suddenly appear/disappear.  And the funny
thing is, on all of this hw, that isn't going to happen anyways.

In whatever is done, we need some way to know all the devices in hw
that comprise the "graphics card", so that we can -EPROBE_DEFER until
we have all the bits and pieces.

BR,
-R
