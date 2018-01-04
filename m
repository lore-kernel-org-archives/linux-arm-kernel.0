From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 23:49:04 +0800
Subject: [PATCH v2 09/12] drm/sun4i: backend: Add a custom atomic_check
 for the frontend
In-Reply-To: <9c6cddb9eb16a8c4bdab2e66c072b2bc9a10fcd4.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
 <9c6cddb9eb16a8c4bdab2e66c072b2bc9a10fcd4.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66j9hhFue1x1HO_a3RULUP_qWL7ivZLGeYQRwdph2Md+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Now that we have everything in place, we can start enabling the frontend.
> This is more difficult than one would assume since there can only be one
> plane using the frontend per-backend.
>
> We therefore need to make sure that the userspace will not try to setup
> multiple planes using it, since that would be impossible. In order to
> prevent that, we can create an atomic_check callback that will check that
> only one plane will effectively make use of the frontend in a given
> configuration, and will toggle the switch in that plane state so that the
> proper setup function can do their role.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
