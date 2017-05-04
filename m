From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:58:45 +0800
Subject: [PATCH v2 13/20] drm/sun4i: tcon: Change vertical total size
 computation inconsistency
In-Reply-To: <745b9fc450798635d50f449473e9263ab3ace48e.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <745b9fc450798635d50f449473e9263ab3ace48e.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66U9JzEr_xeifZGd9ws4uhHnYJAvsY9zmPArHFzn9LztQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Both TCON channels need to have the resolution doubled, since the size the
> hardware is going to use is whatever we put in the register divided by two.
>
> However, we handle it differently for the two channels: in the channel 0,
> our register access macro does the multiplication of the value passed as
> paremeter, while in the channel 1, the macro doesn't do this, and we need
> to do it before calling it.
>
> Make this consistent by aligning the channel 0 with the channel 1
> behaviour.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
