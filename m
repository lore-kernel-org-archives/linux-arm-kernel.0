From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:26:00 +0000
Subject: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
In-Reply-To: <50953E26.40906@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
 <50953E26.40906@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 21:24:14, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > ---
> >   arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
> >   1 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index bb31bff..e2cbf24 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -210,5 +210,16 @@
> >   			interrupt-parent = <&intc>;
> >   			interrupts = <91>;
> >   		};
> > +
> > +		ocmcram: ocmcram at 40300000 {
> > +			compatible = "ti,ocmcram";
> > +			ti,hwmods = "ocmcram";
> > +			ti,no_idle_on_suspend;
> > +		};
> Whats the intention behind adding OCMRAM ?
> Sorry if I missed any comments from the cover letter ?
> 

We need a mechanism to ensure that the clock to OCMC is kept running
during boot and that it doesn't get disabled as part of the suspend
sequence. Since the hwmod data for OCMC is already present and we have
the no_idle_on_suspend flag for hwmod entries we get the desired behavior.

This could also have been done via the clock tree but looks like we
want to avoid adding leaf nodes in the clock data, hence the hwmod +
DT approach.

Regards,
Vaibhav
