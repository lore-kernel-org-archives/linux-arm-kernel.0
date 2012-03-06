From: nm@ti.com (Nishanth Menon)
Date: Tue, 6 Mar 2012 00:12:35 -0600
Subject: [PATCH] ARM: OMAP2+: voltage: ensure voltage used is exact
 voltage from OPP table
In-Reply-To: <877gyyor28.fsf@ti.com>
References: <1330728121-26664-1-git-send-email-khilman@ti.com>
 <1330940487.2116.119.camel@sokoban> <877gyyor28.fsf@ti.com>
Message-ID: <20120306061233.GC5670@kobold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:12-20120305, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Fri, 2012-03-02 at 14:42 -0800, Kevin Hilman wrote:
> >> When using the SMPS regulators to scale voltages, the regulator
> >> framework may pass a minimum voltage that is not an exact OPP voltage.
> >> For the VC/VP controlled voltage domains, we must ensure that the
> >> voltage requested is the exact voltage from the OPP table.  This is
> >> especially critical when using SR.
> >> 
> >> To fix, voltdm_scale() uses the target voltage passed to walk through
> >> the OPP voltages until it finds a voltage that is >= one of the OPP
> >> voltages.
> >
> > I have just one question to this, how about smartreflex class1p5? Do we
> > have any plans for that one? The old implementation at least was using
> > voltdm_scale, so if we modify this function, smartreflex class1p5
> > doesn't work anymore.
> 
> Since it's not in mainline, that is not my concern at the moment.  We
> can worry about SR1.5 when I someone is motivated to push it upstream.
> 
> > Otherwise this patch looks good to me.

Other than the minor misgiving of having to re-verify the voltage on
every scale, I am OK with it as well.

That said, I don't see why this should break class 1.5/3.5 support.

-- 
Regards,
Nishanth Menon
