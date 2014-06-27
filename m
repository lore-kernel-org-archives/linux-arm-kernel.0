From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 16:30:08 -0600
Subject: [RFC 0/5] Per-user clock constraints
In-Reply-To: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <53ADF070.8050002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> Hi,
> 
> I'm retaking Rabin's patches [0] for splitting the clk API in two: one API for
> clk consumers and another for providers. The consumer API uses a clk structure
> that just keeps track of the consumer and has a reference to the actual
> clk_core struct, which is used internally.
> 
> I have kept a patch from Rabin that aims to aid in debugging nested
> enable/disable calls, though my personal aim is to allow more than one consumer
> to influence the final, effective rate. For now this is limited to setting
> floor and ceiling constraints.
> 
> For those functions in the consumer clk API that were called from providers, I
> have added variants to clk-provider.h that are the same only that accept a
> clk_core instead. In this first version of the patchset, these functions are
> prepended with two underscores and have the _internal suffix at the end. Mike
> has stated his preference of not prefixing with underscores any public API and
> I agree with him, but we still need a way to distinguish e.g. clk_set_parent()
> in the provider API from that in the consumer API (and from the lock-less
> variant in clk-provider.h!).

The name clk_provider_set_rate would be a good hint that it's an API for
clock providers not consumers.

The name clk_core_set_rate would be a good hint that the function takes
a clk_core object rather than the clk (client) object.

Neither names see too unwieldy to me.

Anyway, that's the color of my bikeshed:-)
