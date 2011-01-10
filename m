From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 10 Jan 2011 12:06:13 -0700 (MST)
Subject: [PATCH 2/3] perf: add OMAP support for the new power events
In-Reply-To: <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
	<1294138484-24729-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1101041146160.19319@utopia.booyaka.com>
	<AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1101101205130.5731@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean,

On Wed, 5 Jan 2011, Jean Pihet wrote:

> On Tue, Jan 4, 2011 at 7:48 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> > If the latter, then it might make sense to put these
> > trace points into the functions that actually change the hardware
> > registers, e.g., omap2_dflt_clk_{enable,disable}(), etc., since a
> > clk_enable() on a leaf clock may result in many internal system clocks
> > being enabled up the clock tree.
> I agree with you it is better to track the actual clock changes instead.
> I propose to move the tracepoints to omap2_clk_{enable...} which
> enables all the clocks irrespectively of the installed handler.

Yes, that is a better place.

> Note about the clock handlers: omap2_dflt_clk_enable happens to be the
> handler for all controllable clocks but could that change in the
> future?

Yes, it certainly could.


- Paul
