From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 May 2015 12:10:28 +0100
Subject: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
In-Reply-To: <CAEUnVG6QLtV3AXjdPAp5mYDTnmNVsyLfYQmLykeLMd-KgnX+5A@mail.gmail.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
 <555659DB.9010204@metafoo.de> <20150519111602.GG2761@sirena.org.uk>
 <CAEUnVG6QLtV3AXjdPAp5mYDTnmNVsyLfYQmLykeLMd-KgnX+5A@mail.gmail.com>
Message-ID: <20150521111028.GZ21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:37:58AM -0700, Dylan Reid wrote:

> Can the jacks can each be an aux_dev?  The jack driver would create
> the jack at probe time and register it with the card in aux_dev->init.
> cht_bsw_max98090_ti.c is already doing something similar, although all
> contained in the machine driver.

Yes, that's just a CODEC driver registered without any DAIs connected so
it'd just be another CODEC driver.

> Then simple-card can have an optional property to specify aux devs.  A
> GPIO jack device could handle simple switch-based jack detection.

That's useful anyway for external headphone/speaker drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/cf4d2197/attachment.sig>
