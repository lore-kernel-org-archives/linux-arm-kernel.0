From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 18 Sep 2017 12:44:38 -0500
Subject: [RFC/PATCH v4 1/4] Document nexus nodes/specifier remapping
In-Reply-To: <20170811154236.12891-2-stephen.boyd@linaro.org>
References: <20170811154236.12891-1-stephen.boyd@linaro.org>
 <20170811154236.12891-2-stephen.boyd@linaro.org>
Message-ID: <CAL_Jsq+qRm=iAhQz6Ro3SAU45JEK8KNWpRBcXuRt47r8ncYYwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 10:42 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Document the generic nexus node properties. This can be used by
> any specifier that conforms to #<specifier>-cells where they
> want to support remapping phandle lists through nexus nodes. This
> is similar to interrupt remapping, but slightly different because
> we don't consider unit addresses when doing mappings. This is
> mostly a copy/paste of the interrupt specification, with the unit
> address parts removed and generalized to any specifier. There's
> also the addition of a pass through mechanism to make things more
> compact if desired in the mapping table.

Sorry for the slow response.

I'm still wondering how/if we can merge interrupts as part of this
(both the spec and parsing implementation). Could we simply require
that #address-cells is 0 or do we even need this distinction? If the
usecase is connectors, then we should typically be able to set
#address-cells to 0. Perhaps you could have a custom PCI connector
with additional signals and the slot/connector node would have the PCI
address. In this case, we would have #address-cells, but having them
and ignoring the address cells via the mask would still work.

Also, I don't see any issue if we allow the -map-pass-thru property
for interrupts.

>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>
> I still need to write the blurb about what this is all about, but
> I wanted to send this out now to get early feedback. Some starting
> points:
>
>  1) Replace child/parent with incoming/outgoing everywhere?

Parent/child is more common, so I think that's fine.

>
>  2) Make a pretty picture to describe remapping phandle+specifiers
>     similar to the interrupt hierarchy diagram?

Pictures are always nice, but I don't think required.

>
>  3) Come up with some better name than <specifier>? Kernel-doc uses <list>
>     but I'm not sure that's any better.

specifier seems fine to me.

Rob
