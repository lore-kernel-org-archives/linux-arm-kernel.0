From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 14:55:05 +0100
Subject: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
In-Reply-To: <CAGb2v65QHkuM2GmT4MC+tp+HqN2ecqeZt8bB5OvZm2br1AJJ-w@mail.gmail.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
 <6329fbb6-13a1-41fe-f6cf-f2f0d4b2e5f9@arm.com>
 <20180318200715.363f3135@dell-desktop.home>
 <CAGb2v65QHkuM2GmT4MC+tp+HqN2ecqeZt8bB5OvZm2br1AJJ-w@mail.gmail.com>
Message-ID: <20180319135505.py4evmbexm2asvlo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:14:19AM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 19, 2018 at 3:07 AM, Myl?ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Hello Mark,
> >
> > Please, excuse me for this late answer and thank you for the review!
> >
> > On Wed, 7 Mar 2018 12:18:33 +0000
> > Marc Zyngier <marc.zyngier@arm.com> wrote:
> >
> >> On 23/02/18 13:37, Myl?ne Josserand wrote:
> >> > On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
> >>
> >> Only on A7? Is that specific to your platform?
> >
> > I do not really know other Allwinner's platforms about this subject. At
> > least, the sun9i-a80 which is a Cortex-a15/a7 does not need that but it
> > is necessary for sun8i-a83t which is a cortex-a7. Maybe, Chen-Yu or
> > Maxime could help us on it.
> 
> AFAIK all Allwinner CPUs need it if there isn't a firmware (PSCI) layer
> beneath the kernel that will do the setup. We just have
> "arm,cpu-registers-not-fw-configured" set for all the other SoCs that
> have in-kernel SMP support, which includes the A31, A23, A33 and A80.

Most of these ones are here for historical reasons though. Now that we
have U-Boot properly setting it up, we could probably remove it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
