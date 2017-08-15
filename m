From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 15 Aug 2017 15:36:59 -0500
Subject: [PATCH v4 0/4] OF phandle nexus support + GPIO nexus
In-Reply-To: <20170811154236.12891-1-stephen.boyd@linaro.org>
References: <20170811154236.12891-1-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqLTzL1AkyfQxuTzz06ywXkCE6JZaFzV60ENDuL7TzY0BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 10:42 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> This is a continutation of my phandle remapping/nexus node series
> from a while ago. I finally got around to writing the documentation
> in the spec for this, but it's really rough around the edges and
> could use some review/suggestions to get it into shape. Please
> review!
>
> This is one small chunk of work related to DT overlays for expansion
> boards. It would be good to have a way to expose #<list>-cells types of
> providers through a connector in a standard way. So we introduce a way
> to make "nexus" nodes for these types of properties to remap the consumer
> number space to the other side of the connector's number space. It's
> basically a copy of the interrupt nexus implementation, but without
> the address space matching design and interrupt-parent walking.

This generally looks good to me. I'm inclined to merge the kernel
parts now and sort the spec addition out afterwards. With no users
yet, we can still tweak things if needed.

I would like to see more comments on this though. Perhaps "OF phandle
nexus" is too obscure. Maybe "Add DT overlay connector bindings" would
trick some people in looking at it...

Rob
