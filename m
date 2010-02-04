From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 3 Feb 2010 16:54:41 -0800
Subject: [PATCHv2 01/11] arm: mxc: TrustZone interrupt controller (TZIC)
	for i.MX5 family
In-Reply-To: <f17812d71002030709i6ecbc374g30e2b1343455b650@mail.gmail.com>
References: <cover.1265173480.git.amit.kucheria@canonical.com>
	<cover.1265173246.git.amit.kucheria@verdurent.com>
	<0511204199ab83aed2340e70a4639500c0528dab.1265173480.git.amit.kucheria@canonical.com>
	<f17812d71002022223jdc0ac5cp5b94928fb45695d6@mail.gmail.com>
	<20100203132404.GC5252@k2>
	<f17812d71002030709i6ecbc374g30e2b1343455b650@mail.gmail.com>
Message-ID: <f17812d71002031654t53d4d7b1wd9933633636f9d63@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > +config MXC_TZIC
> >> > + ? ? ? bool "Enable TrustZone Interrupt Controller"
> >> > + ? ? ? depends on ARCH_MX51
> >>
> >> This is the first patch of the base port, yet I cannot find any reference to
> >> this ARCH_MX51, did you miss something?
> >
> > ARCH_MX51 is only introduced in the later patches that add the core i.MX5
> > code. Since TZIC is not inherently dependent on i.MX5 (it's merely the first
> > processor to use it), I thought of splitting it out as a separate patch.
> >
> > Does this break the sanctity of one self-contained change?
> >
>
> This breaks git-bisect, we may want a buildable kernel every commit if possible.
>

Hmm... you may safely ignore this, it's not going to break the build
since it won't be selected without ARCH_MX51 being defined.
