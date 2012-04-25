From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 25 Apr 2012 10:35:53 +0200
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120425071418.GA2116@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
 <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
 <20120425052802.GF13489@lunn.ch>
 <20375.40225.227084.644318@ipc1.ka-ro>
 <20120425071418.GA2116@lunn.ch>
Message-ID: <20375.46953.269684.680915@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn writes:
> > AFAICT the PCI archs do not have HAVE_CLK enabled. Thus they will have
> > a dummy clk API in place that provides the driver with a non-error
> > clk_get() return value.
>  
> Hi Lothar
> 
> Please could you explain this a little bit more. What exactly is a PCI
> arch?
> 
> Most of the Orion SoC have PCIe busses. Does this make them an PCI
> arch? Because they also have HAVE_CLK. There are more SoCs with PCI.
> 
If an arch has HAVE_CLK enabled it must provide valid clocks (be it
dummy clocks) for all devices it supports.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
