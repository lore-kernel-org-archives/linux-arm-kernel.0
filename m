From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 13 Nov 2012 20:04:37 +0530
Subject: [PATCH 02/14] ARM: SPEAr13xx: DT: Add spics gpio controller nodes
In-Reply-To: <CACRpkdZkgmLF8TxFCZSubP+g+6_ofZugArKtE9=dYTZfemstrw@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <58a7d91cab20b924784fb5a09e16ca08e6f13318.1352608333.git.viresh.kumar@linaro.org>
 <CACRpkdZkgmLF8TxFCZSubP+g+6_ofZugArKtE9=dYTZfemstrw@mail.gmail.com>
Message-ID: <CAKohpon=AVGZmR_cwUZ4=buw0kr3JVtXh51BtXteWkJ7E-f_bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 13, 2012 7:38 PM, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>
> On Sun, Nov 11, 2012 at 5:39 AM, Viresh Kumar <viresh.kumar@linaro.org>
wrote:
>
> > From: Shiraz Hashim <shiraz.hashim@st.com>
> >
> > SPEAr platform provides a provision to control chipselects of ARM PL022
Prime
> > Cell spi controller through its system registers, which otherwise
remains under
> > PL022 control which some protocols do not want.
>
> So I guess this platform us utilizing the cs_control field of the
> PL022 platform data to do the actual magic, right?

Correct.

> > This patch adds spics controller nodes in device tree for various
SPEAr13xx
> > SoCs.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> > Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> (...)
> >         ahb {
> > +               spics: spics at e0700000{
> > +                       compatible = "st,spear-spics-gpio";
> > +                       reg = <0xe0700000 0x1000>;
> > +                       st-spics,peripcfg-reg = <0x3b0>;
> > +                       st-spics,sw-enable-bit = <12>;
> > +                       st-spics,cs-value-bit = <11>;
> > +                       st-spics,cs-enable-mask = <3>;
> > +                       st-spics,cs-enable-shift = <8>;
> > +                       gpio-controller;
> > +                       #gpio-cells = <2>;
> > +               };
> > +
>
> Are these bindings documented?

The main patch waiting for ur comments is 1/14.

> Apart from that remark:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/ccfa29d1/attachment-0001.html>
