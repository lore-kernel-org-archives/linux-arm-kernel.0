From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Aug 2013 09:40:33 +0800
Subject: [PATCH 1/3] ARM: imx6q: refactor some ldb related clocks
In-Reply-To: <20130820211827.4443.97943@quantum>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
 <1376987932-5540-2-git-send-email-Ying.Liu@freescale.com>
 <CAOMZO5Afjp-zPzUaNE63L7Y2LjZbSrLupAJ_jFnf1Gg1+hx0Nw@mail.gmail.com>
 <20130820211827.4443.97943@quantum>
Message-ID: <20130821014031.GC30533@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 02:18:27PM -0700, Mike Turquette wrote:
> Quoting Fabio Estevam (2013-08-20 08:40:52)
> > On Tue, Aug 20, 2013 at 5:38 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
> > 
> > > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > index 5a90a72..90e923e 100644
> > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > @@ -89,8 +89,6 @@ clocks and IDs.
> > >         gpu3d_shader            74
> > >         ipu1_podf               75
> > >         ipu2_podf               76
> > > -       ldb_di0_podf            77
> > > -       ldb_di1_podf            78
> > >         ipu1_di0_pre            79
> > >         ipu1_di1_pre            80
> > >         ipu2_di0_pre            81
> > 
> > This causes a 'hole' in the clock numbering scheme: 74, 75, 76, 79, 80, etc
> 
> How does this fit in with the idea of having a stable binding/ABI? Seems
> like changing this would be a bad idea for devices in the field that
> have older DTBs.

We should be safe since none of existing DTBs refers to the clocks (they
are not leaf clocks in the whole clock tree but some interconnection
ones).

Shawn
