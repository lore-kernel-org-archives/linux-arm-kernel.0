From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Dec 2012 11:23:14 +0000
Subject: CoreSight framework and drivers
In-Reply-To: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
Message-ID: <20121219112314.GA26329@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratik,

On Tue, Dec 18, 2012 at 07:19:17PM +0000, pratikp at codeaurora.org wrote:
> This RFC is aimed at introducing CoreSight framework as well as
> individual CoreSight trace component drivers adhering to ARM
> CoreSight specification. Some prior discussion on this can be
> referred at [1].
> 
> There are 3 kinds of CoreSight trace components:
> 
> * Sources: Responsible for producing trace data to provide
>   visibility for the associated entity.
> 
> * Links: Transport components that carry trace data.
> 
> * Sinks: Collectors for storing trace data or acting as conduits
>   for off-chip trace data collection.
> 
> These components can be connected in various topologies to suite
> a particular SoCs tracing needs.
> 
> Framework is responsible for gathering and using the information
> about the registered CoreSight components and their connections
> to allow it to dynamically deduce the sequence of components
> representing a connection from a CoreSight source to the
> currently selected CoreSight sink. This helps the framework to
> program the correct set of components to satisfy user request.

>From a million miles up, this looks like a sensible sort of design but I
really think you need to talk to Jon Hunter (he's at least on CC) about
this, especially where bindings are concerned. If we can get something that
you both agree on, then we can include the CTI with the other coresight
components and do a more in-depth review at that point.

Finally, how do you plan on exposing this data to the user? I think the only
sane way is to have per-device file descriptors which act as pipes to the raw
data but this means we need some readily available, open-source tooling (or
at least public specifications of the trace formats).

Will
