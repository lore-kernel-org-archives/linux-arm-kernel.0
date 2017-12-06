From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Dec 2017 16:32:05 +0100
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
Message-ID: <20171206153205.k3l5sofdco3t75mi@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 03:17:39PM -0800, Vasily Khoruzhick wrote:
> On Tue, Dec 5, 2017 at 12:04 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
> >> Digital part of audio codec block in the A64 is very similar to what
> >> is used by the A33(sun8i) devices. However, it uses different LRCK
> >> divider.
> >>
> >> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >
> > What makes it impossible to derive from the sample rate and number of
> > channels?
> 
> It's BCLK / LRCK ratio as per A64 user manual, so it doesn't depend on
> sample rate. BSP driver always uses a fixed value of 64 here.

Well, it kind of does.

BCLK is sample rate * sample size * channels, and LRCK is running at
the sample rate. So the ratio is the sample size * channels.

Anything deviating from those standard i2s concepts should at least be
documented, with arguments to back them off.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/20e46530/attachment.sig>
