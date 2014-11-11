From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 16:03:06 -0800
Subject: [PATCH] ARM: OMAP4+: PM: Program CPU logic power state
In-Reply-To: <7h61f98hvw.fsf@deeprootsystems.com>
References: <1413923076-26063-1-git-send-email-nm@ti.com>
 <7h61f98hvw.fsf@deeprootsystems.com>
Message-ID: <20141111000305.GJ31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@kernel.org> [141024 11:04]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > CPU logic power state is never programmed in either the initialization
> > or the suspend/resume logic, instead, we depend on mpuss to program this
> > properly. However, this leaves CPU logic power state indeterminate and
> > most probably in reset configuration (If bootloader or other similar
> > software have'nt monkeyed with the register). This can make powerstate=
> > RET be either programmed for CSWR (logic=ret) or OSWR(logic = OFF) and
> > in OSWR, there can be context loss when the code does not expect it.
> >
> > To prevent all these confusions, just support clearly ON, INA, CSWR,
> > OFF which is the intent of the existing code by explicitly programming
> > logic state.
> >
> > NOTE: since this is a hot path (using in cpuidle), the exit path just
> > programs powerstate (logic state is immaterial when powerstate is ON).
> >
> > Without doing this, we end up with lockups when CPUs enter OSWR and
> > multiple blocks loose context, when we expect them to hit CSWR.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Applying into omap-for-v3.19/soc thanks.

Tony
