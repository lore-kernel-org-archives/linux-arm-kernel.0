From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Jan 2018 14:12:16 +0800
Subject: [PATCH v2 05/12] drm/bridge/synopsys: dw-hdmi: Add deinit callback
In-Reply-To: <20180110192512.19684-6-jernej.skrabec@siol.net>
References: <20180110192512.19684-1-jernej.skrabec@siol.net>
 <20180110192512.19684-6-jernej.skrabec@siol.net>
Message-ID: <CAGb2v677HxKD2d+Jqsu7U5OuOCtFGf0u-1r=ewMrD3pu8B8YFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 3:25 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Some SoCs, like Allwinner A83T, have to do additional cleanup when
> HDMI driver unloads. When using DW HDMI through DRM bridge API, there is
> no place to store driver's private data so it can be accessed in unbind
> function. Because of that, add deinit function which is called at the
> very end, so drivers can do a proper cleanup.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

8242ecbd597d ("drm/bridge/synopsys: stop clobbering drvdata"), which is
already in drm-misc-next, is a much saner solution. :)

ChenYu
