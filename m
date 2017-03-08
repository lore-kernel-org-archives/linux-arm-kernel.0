From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Wed, 8 Mar 2017 10:42:23 +0100
Subject: [PATCH V3 0/4] megachips-stdpxxxx-ge-b850v3-fw
In-Reply-To: <3583de63-eda5-5d9c-741e-040db1ccee69@codeaurora.org>
References: <cover.1488555615.git.peter.senna@collabora.com>
 <3583de63-eda5-5d9c-741e-040db1ccee69@codeaurora.org>
Message-ID: <20170308094223.GA25268@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 03:27:16PM +0530, Archit Taneja wrote:
Hi Archit,

> Hi,
> 
> On 3/3/2017 9:27 PM, Peter Senna Tschudin wrote:
> > The video processing pipeline on the second output on the GE B850v3:
> > 
> >   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> > 
> > Each bridge has a dedicated flash containing firmware for supporting the
> > custom design. The result is that in this design neither the STDP4028
> > nor the STDP2690 behave as the stock bridges would. The compatible
> > strings include the suffix "-ge-b850v3-fw" to make it clear that the
> > driver is for the bridges with the firmware which is specific for the GE
> > B850v3.
> > 
> > The driver is powerless to control the video processing pipeline, as the
> > two bridges behaves as a single one. The driver is only needed for
> > telling the host about EDID / HPD, and for giving the host powers to ack
> > interrupts.
> 
> queued Patches 1,2 and 3 to drm-misc-next. Made stdp2690_get_edid static
> in Patch #3 to fix a sparse warning.

What about 4/4, aka the dt change? Do I need an ack from Rob Herring?

Thanks a lot!

[...]
