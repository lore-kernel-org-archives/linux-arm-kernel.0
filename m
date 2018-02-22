From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Feb 2018 22:13:13 +0800
Subject: [PATCH v3 4/8] drm/sun4i: backend: Assign the pipes automatically
In-Reply-To: <e9caf21d831438d36a3ccc7cef229c9a7ea7f69f.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <e9caf21d831438d36a3ccc7cef229c9a7ea7f69f.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66rCu5gX4MNf09LpJjm88uacOuRdJFHw2RrermX5Z94bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Since we now have a way to enforce the zpos, check for the number of alpha
> planes, the only missing part is to assign our pipe automatically instead
> of hardcoding it.
>
> The algorithm is quite simple, but requires two iterations over the list of
> planes.
>
> In the first one (which is the same one that we've had to check for alpha,
> the frontend usage, and so on), we order the planes by their zpos.
>
> We can then do a second iteration over that array by ascending zpos
> starting with the pipe 0. When and if we encounter our alpha plane, we put
> it and all the other subsequent planes in the second pipe.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
