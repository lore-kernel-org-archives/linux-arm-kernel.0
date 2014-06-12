From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Jun 2014 16:26:55 -0700
Subject: [PATCH 2/3 v4] spi: s3c64xx: for DT platofrms always get the
 chipselect info from DT node
In-Reply-To: <1402578821-27338-2-git-send-email-ch.naveen@samsung.com>
References: <1402578821-27338-1-git-send-email-ch.naveen@samsung.com>
 <1402578821-27338-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <CAD=FV=VoNbe_Hrr0tNTyQGyYcaUopAwzWAqMQG8HX+xcyVzD0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen,

On Thu, Jun 12, 2014 at 6:13 AM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> Use controller_data structure only for the Non Device tree  platforms.
> For Device tree platforms, always derive the chipselect info from
> DT node.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

I'm not planning to do an in-depth review of this patch since it seems
that others are on top of it, but I've tested it.  With it (and some
patches that haven't been sent up yet) I can talk to the EC on
exynos5420-pit (which uses device tree for specifying the cs-gpios)

Tested-by: Doug Anderson <dianders@chromium.org>
