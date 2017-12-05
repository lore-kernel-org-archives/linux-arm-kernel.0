From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 23:42:35 +0800
Subject: [PATCH v3 05/15] drm/sun4i: Fix error path handling
In-Reply-To: <1f2443c41082fc6e086570da38d20744c52fe636.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <1f2443c41082fc6e086570da38d20744c52fe636.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66kMOFyXa1DqBgKaX+74e6jqt2QVjQcvzEJ_r_Ccoj6vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 11:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The commit 4c7f16d14a33 ("drm/sun4i: Fix TCON clock and regmap
> initialization sequence") moved a bunch of logic around, but forgot to
> update the gotos after the introduction of the err_free_dotclock label.
>
> It means that if we fail later that the one introduced in that commit,
> we'll just to the old label which isn't free the clock we created. This
> will result in a breakage as soon as someone tries to do something with
> that clock, since its resources will have been long reclaimed.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 4c7f16d14a33 ("drm/sun4i: Fix TCON clock and regmap initialization sequence")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks.

I think this was reported, or I noticed it after the patch was merged,
but then I got busy with other stuff.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
