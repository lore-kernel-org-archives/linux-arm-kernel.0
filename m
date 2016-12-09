From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Dec 2016 16:25:40 -0800
Subject: [PATCH v6 0/5] davinci: VPIF: add DT support
In-Reply-To: <CABxcv=nrDACjfjStNPky5_y5zXBpzLZyO3g9WuOz95C6b_bgOg@mail.gmail.com>
 (Javier Martinez Canillas's message of "Wed, 7 Dec 2016 17:03:13
 -0300")
References: <20161207183025.20684-1-khilman@baylibre.com>
 <CABxcv=nrDACjfjStNPky5_y5zXBpzLZyO3g9WuOz95C6b_bgOg@mail.gmail.com>
Message-ID: <m2oa0maqyj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Javier Martinez Canillas <javier@dowhile0.org> writes:

> On Wed, Dec 7, 2016 at 3:30 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Prepare the groundwork for adding DT support for davinci VPIF drivers.
>> This series does some fixups/cleanups and then adds the DT binding and
>> DT compatible string matching for DT probing.
>>
>> The controversial part from previous versions around async subdev
>> parsing, and specifically hard-coding the input/output routing of
>> subdevs, has been left out of this series.  That part can be done as a
>> follow-on step after agreement has been reached on the path forward.
>
> I had a similar need for another board (OMAP3 IGEPv2), that has a
> TVP5151 video decoder (that also supports 2 composite or 1 s-video
> signal) attached to the OMAP3 ISP.
>
> I posted some RFC patches [0] to define the input signals in the DT,
> and AFAICT Laurent and Hans were not against the approach but just had
> some comments on the DT binding.
>
> Basically they wanted the ports to be directly in the tvp5150 node
> instead of under a connectors sub-node [1] and to just be called just
> a (input / output) port instead of a connector [2].
>
> Unfortunately I was busy with other tasks so I couldn't res-pin the
> patches, but I think you could have something similar in the DT
> binding for your case and it shouldn't be hard to parse the ports /
> endpoints in the driver to get that information from DT and setup the
> input and output pins.

Thanks for pointing that out.  I did see this in Hans' reply to one of
my earlier versions.  Indeed I think this could be useful in solving my
problem.

>> With is version, platforms can still use the VPIF capture/display
>> drivers, but must provide platform_data for the subdevs and subdev
>> routing.
>>
>
> I guess DT backward compatibility isn't a big issue on this platform,
> since support for the platform is quite recently and after all someone
> who wants to use the vpif with current DT will need platform data and
> pdata-quirks anyways.

That's correct.

> So I agree with you that the input / output signals lookup from DT
> could be done as a follow-up.

Thanks. I'll happily add the input/output signals once they're agreed
upon.  In the mean time, at least we can have a usable video capture on
this platform, and it's at least a step in the right direction for DT
support.

Thanks for the review,

Kevin
