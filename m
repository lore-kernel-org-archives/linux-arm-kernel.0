From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 Mar 2017 14:51:10 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170317102410.18c966ae@vento.lan>
References: <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170317114203.GZ21222@n2100.armlinux.org.uk>
 <44161453-02f9-0019-3868-7501967a6a82@linux.intel.com>
 <20170317102410.18c966ae@vento.lan>
Message-ID: <1489758670.2905.52.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 10:24 -0300, Mauro Carvalho Chehab wrote:
[...]
> The big question, waiting for an answer on the last 8 years is
> who would do that? Such person would need to have several different
> hardware from different vendors, in order to ensure that it has
> a generic solution.
> 
> It is a way more feasible that the Kernel developers that already 
> have a certain hardware on their hands to add support inside the
> driver to forward the controls through the pipeline and to setup
> a "default" pipeline that would cover the common use cases at
> driver's probe.

Actually, would setting pipeline via libv4l2 plugin and letting drivers
provide a sane enabled default pipeline configuration be mutually
exclusive? Not sure about the control forwarding, but at least a simple
link setup and format forwarding would also be possible in the kernel
without hindering userspace from doing it themselves later.

regards
Philipp
