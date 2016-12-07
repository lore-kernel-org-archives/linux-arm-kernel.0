From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 7 Dec 2016 17:03:13 -0300
Subject: [PATCH v6 0/5] davinci: VPIF: add DT support
In-Reply-To: <20161207183025.20684-1-khilman@baylibre.com>
References: <20161207183025.20684-1-khilman@baylibre.com>
Message-ID: <CABxcv=nrDACjfjStNPky5_y5zXBpzLZyO3g9WuOz95C6b_bgOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Wed, Dec 7, 2016 at 3:30 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Prepare the groundwork for adding DT support for davinci VPIF drivers.
> This series does some fixups/cleanups and then adds the DT binding and
> DT compatible string matching for DT probing.
>
> The controversial part from previous versions around async subdev
> parsing, and specifically hard-coding the input/output routing of
> subdevs, has been left out of this series.  That part can be done as a
> follow-on step after agreement has been reached on the path forward.

I had a similar need for another board (OMAP3 IGEPv2), that has a
TVP5151 video decoder (that also supports 2 composite or 1 s-video
signal) attached to the OMAP3 ISP.

I posted some RFC patches [0] to define the input signals in the DT,
and AFAICT Laurent and Hans were not against the approach but just had
some comments on the DT binding.

Basically they wanted the ports to be directly in the tvp5150 node
instead of under a connectors sub-node [1] and to just be called just
a (input / output) port instead of a connector [2].

Unfortunately I was busy with other tasks so I couldn't res-pin the
patches, but I think you could have something similar in the DT
binding for your case and it shouldn't be hard to parse the ports /
endpoints in the driver to get that information from DT and setup the
input and output pins.

> With this version, platforms can still use the VPIF capture/display
> drivers, but must provide platform_data for the subdevs and subdev
> routing.
>

I guess DT backward compatibility isn't a big issue on this platform,
since support for the platform is quite recently and after all someone
who wants to use the vpif with current DT will need platform data and
pdata-quirks anyways. So I agree with you that the input / output
signals lookup from DT could be done as a follow-up.

[0]: https://lkml.org/lkml/2016/4/12/983
[1]: https://lkml.org/lkml/2016/4/27/678
[2]: https://lkml.org/lkml/2016/11/11/346

Best regards,
Javier
