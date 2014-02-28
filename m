From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 18:48:35 +0200
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <20140228162752.GU21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <20140228162752.GU21483@n2100.arm.linux.org.uk>
Message-ID: <5310BDE3.60603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:27, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 02:20:07PM +0200, Tomi Valkeinen wrote:
>> Shortly about the display components in the series, in the order of probable
>> public interest:
>>
>> * Analog TV, DVI and HDMI Connectors represent a respective connector on the
>>   board. They don't do much, but they do mark the end of the video pipeline (from
>>   the board's pov), and they should also in the future offer ways to handle
>>   things like the +5V pin on DVI and HDMI connector and HPD pin.
> 
> The big thing which concerns me is that we're using very generic
> compatible strings here - has anyone done any searches to see whether
> there are any existing standards for this kind of stuff already?

I did look for any display related DT bindings when I started the work
on OMAP DSS DT bindings. I didn't really find any. If I recall right,
the only thing I found was an example of basically:

fb at 1234567 {
	compatible="asd";
	reg=<1234567>;
};

So just a node for "framebuffer", with the register addresses. And maybe
video timings in some form.

Maybe I didn't know where to look.

> Even if none can be found, if we're going to create something like
> this, it should probably become a public standard not just for Linux.

This is totally unclear to me. How does it become a public standard?
What's the forum for this?

> If we're not willing to do that, I'd suggest prefixing the compatible
> strings with "linux," as a "company" identifier so that there's no
> chance that we may hit some major problem caused by a conflicting
> implementation in the future.

I don't have an issue with "linux," either. We could always later remove
the prefix (but keep drivers compatible with it). So it sounds quite a
safe approach to me, if we're not quite clear if these bindings are
acceptable, or how to get "public approval" for them.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/4738c8ed/attachment-0001.sig>
