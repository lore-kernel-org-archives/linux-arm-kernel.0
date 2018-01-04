From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 22:50:49 +0800
Subject: [PATCH v2 11/12] drm/sun4i: backend: Make sure we don't have a
 commit pending
In-Reply-To: <b25003511097304444302ba56d26ee9e47966b33.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
 <b25003511097304444302ba56d26ee9e47966b33.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66xjXgX4em1=Uv-sAoAX77B86EOgwuv_vYrbJ5015FcwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> If we try to read the backend registers while it fetches the new values, we
> end up with the value of some random register instead of the one we asked
> for.
>
> In order to prevent that, let's make sure that the very first thing we do
> during our atomic modesetting is to let the commit bit come to a rest.
>
> We don't have to worry about anything else since the only time we will
> trigger a new transaction is during the atomic_commit which comes much
> later.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
