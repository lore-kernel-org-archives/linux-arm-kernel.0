From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 19:04:24 -0300
Subject: mx6 hdmi resolution behaviour
In-Reply-To: <20150623205837.GE7557@n2100.arm.linux.org.uk>
References: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
 <20150623164443.GC7557@n2100.arm.linux.org.uk>
 <CAOMZO5BjuOGgqsUNG6K6N-QU1a4oWTdynxsoAECYLeQK_9Kk9g@mail.gmail.com>
 <20150623204154.GD7557@n2100.arm.linux.org.uk>
 <CAOMZO5CkxjtH7ZnOcbDWdwwwHH4xT4UhXXWpA3O9afbP9XRBaQ@mail.gmail.com>
 <20150623205837.GE7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DG7OM7Rcvu5JcdeZdsswju-a2r+7_p2VpefzVC=kGBXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 5:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> That's the point that makes me confused: shouldn't it report a higher
>> resolution like 1080p?
>
> No - it won't go higher than the initial mode that was set.  See
> drm_fb_helper_hotplug_event():
>
>         max_width = fb_helper->fb->width;
>         max_height = fb_helper->fb->height;
>
>         drm_fb_helper_probe_connector_modes(fb_helper, max_width, max_height);
>
> This calls connector->funcs->fill_modes with the max width/height,
> which calls down into drm_helper_probe_single_connector_modes_merge_bits()
> and there's limitations in there which means that we won't try to
> increase the size of the framebuffer.

Got it, thanks for the clarification, Russell.
