From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 08:49:38 +0100
Subject: [PATCH 03/74] ST SPEAr: Formalized timer support
In-Reply-To: <4C8D9909.4040705@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<eed779f7085ed5686aceb61b48a2c2a7d6af5953.1283161023.git.viresh.kumar@st.com>
	<20100906225536.GD8153@game.jcrosoft.org> <4C8D9909.4040705@st.com>
Message-ID: <20100913074938.GA30581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 08:52:49AM +0530, Shiraz Hashim wrote:
> Dear Jean,
> 
> On 9/7/2010 4:25 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>  
> >> -#endif
> >> +static void __init spear3xx_timer_init(void)
> >> +{
> >> +	spear_setup_timer();
> > why not call it directly?
> 
> A single level of abstraction was provided so that if archs (spear3xx/6xx/13xx)
> required to do something extra.

Please don't build abstraction layers on top of abstraction layers.  Use
what's already provided instead.
