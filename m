From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 09:18:27 +0800
Subject: [PATCH 10/21] usb: chipidea: msm: Rely on core to override
 AHBBURST
In-Reply-To: <146722676163.16253.15476996138920236894@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-11-stephen.boyd@linaro.org>
 <20160629063211.GE25236@shlinux2>
 <146722676163.16253.15476996138920236894@sboyd-linaro>
Message-ID: <20160630011827.GA19743@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 11:59:21AM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-28 23:32:11)
> > On Sun, Jun 26, 2016 at 12:28:27AM -0700, Stephen Boyd wrote:
> > > The core framework already handles setting this parameter with a
> > > platform quirk. Add the appropriate flag so that we always set
> > > AHBBURST to 0. Technically DT should be doing this, but we always
> > > do it for msm chipidea devices so setting the flag in the driver
> > > works just as well.
> > 
> > You still need to set AHB burst value at dts, this flag is just for
> > override, see below:
> > 
> > ahb-burst-config = <0x0>;
> 
> Right, I have added that to dts now, but the CI_HDRC_OVERRIDE_AHB_BURST
> flag allows us to specify it from the platdata structure in the
> ci_hdrc_msm.c file. As the value is zero for msm type controllers, I
> left it out of the static definition of platdata because all the
> non-initialized members of that structure are going to be zero anyway. I
> can explicitly set it to zero to make it more clear if you like.

I suggest setting it explicitly at dts, at current code, it is set
as zero explicitly too:)

-- 

Best Regards,
Peter Chen
