From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Dec 2012 10:49:38 +0000
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <20121213074626.GB31717@pratikp-linux.qualcomm.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
 <20121211213916.GB7214@pratikp-linux.qualcomm.com>
 <CACRpkdYYhAyLXJL6ns5mfFQOethihabfPpPuqz9Unq_SCJqLig@mail.gmail.com>
 <50C8FC34.3010505@ti.com>
 <20121213074626.GB31717@pratikp-linux.qualcomm.com>
Message-ID: <20121213104938.GA26540@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 07:46:26AM +0000, Pratik Patel wrote:
> On Wed, Dec 12, 2012 at 03:50:44PM -0600, Jon Hunter wrote:
> > I have also been working to migrate the coresight cross-trigger
> > interface (CTI) helpers from Ming Lei to a driver [1]. In the current
> > implementation I have opted to make the CTI driver an AMBA device (like
> > the existing ETM and ETB drivers). Therefore, I am curious if the plan
> > is to migrate these other coresight devices to AMBA versus adding this
> > new coresight bus?
> > 
> > It would be good to align on a plan here for coresight devices in general.

Having glanced at your patch series (I'll find some time to review it
properly) I think it looks like the right sort of thing to be doing. The
contentious part is likely to be exposing trace data from coresight devices
to userspace in a self-hosted environment. What we absolutely do *not* want
is a collection of disparate stream decoders in the kernel with a
corresponding set of magic ioctls/filehandles to expose proprietary binary data.
 
> AMBA bus is for PrimeCell devices (class 0xF) as opposed to
> CoreSight devices (class 0x9).

Yes, but if we can re-use all of that infrastructure on the software side of
things then there's really no reason not to.

Will
