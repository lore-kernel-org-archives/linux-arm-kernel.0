From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Feb 2012 14:03:56 +0000
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <4F4B8A85.7060603@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
Message-ID: <20120227140356.GF3191@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 02:52:05PM +0100, Cousson, Benoit wrote:
> On 2/27/2012 2:41 PM, Mark Brown wrote:
> >On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:

> >Please can you guys come up with a single unified series for this stuff
> >- I'll hold off on applying anything to allow you to do this.

> The issue is that the initial TWL regulator series from Rajendra
> will depend on the twl core DT support I have that depends on the
> irq_domain series from Grant...

Really?  That's the first I've heard of any such dependency here.  Is it
a build time dependency or is it just something that's required to make
the code actually spring into life?  It looks like it's the latter but
you're saying there's an actual dependency.

There's also more than that, there's also at least Tero submitting some
other stuff separately (and his stuff won't play with DT...) and I think
Peter also.  It really fees like there's a bunch of people working on
different things without talking to each other here.

> So I guess, it will be easy for us to split the regulator patches
> from the DTS ones to have at least the driver changes merged by you.
> Then Tony might be able to pull all the DTS in one series and thus
> avoid the various merge conflict that will happen since most OMAP
> drivers are hacking the same DTS files.

> Does that make sense? Or do you think it will be even worst
> separating the patches?

Unless there's a compile time dependency I don't think we need to
refactor anything here, what I'm seeing at the minute looks OK from a
merge point of view except that there appears to be a lack of
coordination between the various serieses.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/edc21336/attachment.sig>
