From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 29 Oct 2012 16:10:24 +0000
Subject: [PATCH 1/2] spi: spidev: Add device tree bindings
In-Reply-To: <508EA013.7050907@free-electrons.com>
References: <1351238873-25230-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
 <20121027221955.GO4564@opensource.wolfsonmicro.com>
 <508EA013.7050907@free-electrons.com>
Message-ID: <20121029161023.GC4511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 04:26:11PM +0100, Maxime Ripard wrote:

> Ok, so I guess that leaves us with 2 choices here:

>   * Declare the device in the dt as you would have with any other
>     driver, with its own compatible string, and we add this compatible
>     string to the spidev dt ids array. It allows to use the existing
>     code and thus doesn't require any effort at all, but it will
>     generate a lot of noise for the spidev driver, since all of us will
>     need to add its compatible string to spidev.

>   * Rework the spidev code so that it behaves mostly like i2c-dev, that
>     is you have an instance of it for every device enumerated in the dt,
>     regardless of wether it has a driver loaded or not. If the
>     userspace opens the device file corresponding to a device already
>     attached to a driver, you return EBUSY, and that's it. I guess it
>     would be the cleaner solution, since you only select spidev in
>     configuration, but it definitely requires way more development than
>     the first one.

> What's your views on this?
> Did you have in mind another solution?

I think either solution is good, obviously Grant's more the expert here.
Adding the IDs is obviously simpler and doesn't preclude later doing the
i2c-dev style thing so short term I'd probably add the IDs to get things
going and punt on the difficult stuff for the time being but YMMV.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/d95241f4/attachment.sig>
