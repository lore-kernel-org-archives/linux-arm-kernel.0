From: eric@anholt.net (Eric Anholt)
Date: Fri, 01 Sep 2017 11:42:11 -0700
Subject: [PATCH] drm/tve200: Replace custom connector with panel bridge
In-Reply-To: <20170831213514.29267-1-linus.walleij@linaro.org>
References: <20170831213514.29267-1-linus.walleij@linaro.org>
Message-ID: <87bmmul0qk.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This replaces the custom connector in the TVE200 with the
> panel bridge helper. As long as we're just using panels
> and no other bridges, this works just fine.

Yeah, we definitely need a way to get the bus_flags/bus_formats from the
next link in the bridge chain in general, rather than needing to reach
into the panel's connector (or being just out of luck in a 2-bridge
chain).  That seems like it'll be straightforward to do later, and this
is a good start.

I don't think you need the new #includes in tve200_drm.h, but other than
maybe that change:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/428fc4cd/attachment.sig>
