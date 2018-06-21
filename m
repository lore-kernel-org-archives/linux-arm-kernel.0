From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 21 Jun 2018 05:58:25 -0700
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <20180618074556.6944-1-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
Message-ID: <7c4a9116-1d46-efa8-e476-839f81f5519d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/18 00:45, Linus Walleij wrote:
> This is a proposal for how to handle the non-discoverable
> 96boards plug-in expansion boards called "mezzanines" in the
> Linux kernel. It is a working RFC series meant for discussion
> at the moment.

< snip >

> So for that reason, or other predictable statements such
> as "you're reinventing board files", I'd like to have an
> open discussion on how to actually support these boards
> with the mainline kernel and work on device drivers common
> with other systems now, and not in 2020 when they are already
> obsolete.
> 
> Yeah it is a bit controversial, but what we are doing right
> now for non-discoverable expansion boards isn't working
> in my opinion, so I have to throw something out there,
> and this is it.

< snip >

why  can't a devicetree description of the devices on the
mezzanine board be used?

I do understand the desire to describe interchangeable mezzanine
boards separately from the base devicetree, such as in an
overlay.  Overlays can be applied today by U-boot before the
Linux kernel is booted, so lack of being able to apply an
overlay after Linux boot completes is not a blocker.

-Frank
