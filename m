From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 25 Jul 2016 11:32:32 +0100
Subject: [STLinux Kernel] [PATCH 1/1] drm/sti: use new Reset API
In-Reply-To: <20160725100933.9261-1-lee.jones@linaro.org>
References: <20160725100933.9261-1-lee.jones@linaro.org>
Message-ID: <20160725103232.GA4278@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 25 Jul 2016, Lee Jones wrote:

> Since 0b52297f228 ("reset: Add support for shared reset controls") the
> new Reset API now demands consumers choose either an *_exclusive or a
> *_shared line when requesting reset lines.
> 
> This issue was found when running a kernel containing the aforementioned
> patch  which includes an informitive WARN().  It implies that one or
> more used reset lines are in fact shared.  This is why we're using the
> *_shared variant.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_compositor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Your missing a changelog on the v2 version.

Apart from that:
 Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
