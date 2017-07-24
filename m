From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 10:29:38 +0200
Subject: [PATCH v3 3/5] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20170723141354.42646-4-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-4-icenowy@aosc.io>
Message-ID: <20170724082938.vsq3zd22vb6lqvu3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 10:13:52PM +0800, Icenowy Zheng wrote:
> This adds support for the Allwinner H3 thermal sensor.
> 
> Allwinner H3 has a thermal sensor like the one in A33, but have its
> registers nearly all re-arranged, sample clock moved to CCU and a pair
> of bus clock and reset added. It's also the base of newer SoCs' thermal
> sensors.
> 
> Some new options is added to gpadc_data struct, to mark the difference
> between the old GPADCs and THS's and the new THS's.
> 
> Thermal sampling via interrupts are still not supported, and polling
> is used instead.
> 
> The thermal sensors on A64 and H5 is like the one on H3, but with of
> course different formula factors.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Could you split it in half? One patch that would rework the existing
code, the other one adding the H3 support?

That's going to be much easier to review, bisect and revert if need be
that way.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/8d45bb9e/attachment.sig>
