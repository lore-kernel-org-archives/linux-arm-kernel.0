From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Aug 2013 14:18:27 -0700
Subject: [PATCH 1/3] ARM: imx6q: refactor some ldb related clocks
In-Reply-To: <CAOMZO5Afjp-zPzUaNE63L7Y2LjZbSrLupAJ_jFnf1Gg1+hx0Nw@mail.gmail.com>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
 <1376987932-5540-2-git-send-email-Ying.Liu@freescale.com>
 <CAOMZO5Afjp-zPzUaNE63L7Y2LjZbSrLupAJ_jFnf1Gg1+hx0Nw@mail.gmail.com>
Message-ID: <20130820211827.4443.97943@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2013-08-20 08:40:52)
> On Tue, Aug 20, 2013 at 5:38 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > index 5a90a72..90e923e 100644
> > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > @@ -89,8 +89,6 @@ clocks and IDs.
> >         gpu3d_shader            74
> >         ipu1_podf               75
> >         ipu2_podf               76
> > -       ldb_di0_podf            77
> > -       ldb_di1_podf            78
> >         ipu1_di0_pre            79
> >         ipu1_di1_pre            80
> >         ipu2_di0_pre            81
> 
> This causes a 'hole' in the clock numbering scheme: 74, 75, 76, 79, 80, etc

How does this fit in with the idea of having a stable binding/ABI? Seems
like changing this would be a bad idea for devices in the field that
have older DTBs.

Regards,
Mike

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
