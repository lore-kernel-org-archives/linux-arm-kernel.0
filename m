From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Mar 2015 10:48:33 +0800
Subject: [PATCH 04/10] ARM: zx: add initial L2CC initialization
In-Reply-To: <2075202.63nIomtdeh@wuerfel>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
 <2075202.63nIomtdeh@wuerfel>
Message-ID: <20150316024831.GI20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 10:22:39PM +0100, Arnd Bergmann wrote:
> On Saturday 14 March 2015 19:49:39 Jun Nie wrote:
> > Add an initial L2 Cache controller initialization.
> > 
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > 
> 
> This should not be needed at all, we expect all platforms
> to describe the l2 cache controller in DT to the degree
> that is required to have it probed automatically.
> 
> Is there any special requirement about this platform that
> makes this impossible?

The L2 device tree bindings do not cover PREFETCH_CTRL and POWER_CTRL
registers.  I do not remember, but there might be some reason that these
registers are not defined by DT bindings, e.g. POWER_CTRL is not
available on all pl310 revisions?

Shawn
