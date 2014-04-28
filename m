From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Apr 2014 18:50:51 +0100
Subject: [PATCH 1/3] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <1398706660.20390.5.camel@hornet>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
 <CAL_JsqJQy7ob87=wPOLxn3X0fTrt2QhAEJ2nPTAmCMZqNZp+sw@mail.gmail.com>
 <1398706660.20390.5.camel@hornet>
Message-ID: <1398707451.20390.14.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-28 at 18:37 +0100, Pawel Moll wrote:
> On Thu, 2014-02-13 at 13:15 -0600, Rob Herring wrote:
> > On Tue, Feb 11, 2014 at 10:53 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > > In "Device Tree powered" systems, platform devices are usually
> > > massively populated with of_platform_populate() call, executed
> > > at some level of initcalls, either by generic architecture
> > > or by platform-specific code.
> >
> > Go read Grant's and my comments from your last posting.
> 
> Right, I can't explain why I missed those. Will do right now.

Actually I can't seem to find it in my mail archive, but I remember you
were saying that it shouldn't spoil into the driver base code. You're
probably right, so the updated patch will be limited to of_platform_*
API.

Grant was suggesting that I shouldn't be using the device model if I
have to initialize some early stuff. The thing is that my stuff is not
that early at all. The device model works for me perfectly, as long as I
can initialize 3 crucial devices in a correct order (and *then* do mass
population). And the init levels are perfect for this job. The only
thing I need is a small refinement in the way DT-based devices are
populated and this is exactly what I propose. Hope it makes more sense
now.

Cheers!

Pawel
