From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Oct 2015 11:36:48 +0100
Subject: [PATCH RFC 1/2] dt-bindings: simplefb: Support a list of
 regulator supply properties
In-Reply-To: <561CADFE.2010609@redhat.com>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <1444669458-5588-2-git-send-email-wens@csie.org>
 <20151012171018.GB3659@leverpostej>
 <CAGb2v651=uaHEQK4wpEQywgr311NSbqEvYkpsC5zSHPSFq-HHg@mail.gmail.com>
 <561CADFE.2010609@redhat.com>
Message-ID: <20151014103648.GS14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 09:08:46AM +0200, Hans de Goede wrote:
> On 13-10-15 04:22, Chen-Yu Tsai wrote:
> >On Tue, Oct 13, 2015 at 1:10 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>On Tue, Oct 13, 2015 at 01:04:17AM +0800, Chen-Yu Tsai wrote:

> >>>+- num-supplies : The number of regulators used by the framebuffer.
> >>>+- vinN-supply : The N-th (from 0) regulator used by the framebuffer.

> >>I don't see why you need num-supplies. Why not just try probing
> >>vin${N}-supply until such a property isn't present in the DT?

> +1 for this.

Even better would be to just enumerate all the properties on the node
and request anything with a FOO-supply name.  That way we can keep
using standard regulator bindings that name the supplies after their
actual names on the device.

> > That's doable. Though I'd add a hard limit on it. Does 16 seem
> > reasonable?

> I would not add a hard limit to the binding, you can use a fixed array in
> the code to make the code simpler. I would say 8 should be sufficient, since
> the limit will only be in the code we can always bump it when we need
> to.

Or just dynamically allocate the array and resize as needed if it starts
to get to be a problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/5fd830c7/attachment.sig>
