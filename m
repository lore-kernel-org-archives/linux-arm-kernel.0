From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 May 2013 12:02:41 +0100
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <1b69c011-cab5-4fde-a61d-7e2536208920@CH1EHSMHS003.ehs.local>
References: <7c5e7537-6ed5-4622-a7a9-bf46820ef695@VA3EHSMHS033.ehs.local>
 <519124D3.2040403@gmail.com>
 <af51c63e-7ff1-4e73-9305-08309217ab38@TX2EHSMHS037.ehs.local>
 <20130514164611.10068.46384@quantum>
 <51927DEB.7090001@balister.org>
 <20130515044604.GA24524@sirena.org.uk>
 <51946082.1000606@codeaurora.org> <5194F0C0.9020609@balister.org>
 <20130516172605.GB1627@sirena.org.uk>
 <1b69c011-cab5-4fde-a61d-7e2536208920@CH1EHSMHS003.ehs.local>
Message-ID: <20130517110241.GI1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 11:55:45AM -0700, S?ren Brinkmann wrote:
> On Thu, May 16, 2013 at 06:26:05PM +0100, Mark Brown wrote:

> > The binding should obviously be defined as a set of clocks rather than a
> > single clock - something like how we specify regulators on PMICs
> > probably makes sense.  Each clock can have its own properties.

> For a device driver as clock consumer, the bindings etc. are well
> defined. Just add the 'clocks' and 'clock-names' props and use the CCF.

That's not really intended to be used for enumeration by the child,
though - you'd at least need to define that the child looks through
the same binding to figure out what clocks to request.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/d8cd3682/attachment.sig>
