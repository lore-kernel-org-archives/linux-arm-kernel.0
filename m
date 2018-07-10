From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:31:08 +0800
Subject: [PATCH 07/17] drm/sun4i: DW HDMI: Release nodes if error happens
 during CRTC search
In-Reply-To: <20180706175113.26698-8-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-8-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65q5OkVnnjufc1kHP=sc+6Kw5EHGmNDwuguTnrgPgxJbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> If error happens in sun8i_dw_hdmi_find_possible_crtcs(), nodes are not
> released with of_node_put() before returning.
>
> Fix that by calling of_node_put() when necessary. While on it, clean up
> the code by using of_graph_get_remote_node() which also lowers number of
> cases where error handling has to be performed.

Good job!

> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
