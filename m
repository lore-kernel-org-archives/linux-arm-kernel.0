From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 30 Dec 2011 18:38:31 +0800
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <20111230103026.GA2766@opensource.wolfsonmicro.com>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
Message-ID: <20111230103830.GD2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 10:30:27AM +0000, Mark Brown wrote:
> On Fri, Dec 30, 2011 at 02:06:53PM +0800, Richard Zhao wrote:
> > From: Richard Zhao <richard.zhao@freescale.com>
> > 
> > Fix fixed regulator failed to call regulator_register.
> > 
> > Fixed regulator does not support set voltage operation, so we
> > don't need apply_uV.
> 
> No, the regulator drivers shouldn't be fiddling around with their
> constraints.  Generally the answer is that users shouldn't set
> constraints that won't work, or perhaps the API needs to be more
> forgiving.
So what's your suggestion of the issue? Below fixed regulator failed
to register.

reg_2P5V: regulator-2P5V {
        compatible = "regulator-fixed";
        regulator-name = "2P5V";
        regulator-min-microvolt = <2500000>;
        regulator-max-microvolt = <2500000>;
        regulator-always-on;
}

Richard
