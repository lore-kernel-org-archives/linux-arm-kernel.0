From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Dec 2017 09:59:50 +0100
Subject: [PATCH v4 05/15] drm/sun4i: Fix error path handling
In-Reply-To: <f83c1cebc731f0b4251f5ddd7b38c718cd79bb0b.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <f83c1cebc731f0b4251f5ddd7b38c718cd79bb0b.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171219085950.domvcod2dyqdi3v3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:58:50PM +0100, Maxime Ripard wrote:
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
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied this one as a fix.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171219/b463c0c3/attachment.sig>
