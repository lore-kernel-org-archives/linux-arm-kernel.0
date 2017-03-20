From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 20 Mar 2017 09:32:15 -0600
Subject: [PATCH v4 1/7] coresight: bindings for CPU debug module
In-Reply-To: <20170320114953.GA19581@leoy-linaro>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-2-git-send-email-leo.yan@linaro.org>
 <20170317161335.GB20435@linaro.org>
 <20170320114953.GA19581@leoy-linaro>
Message-ID: <20170320153215.GA15068@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 07:49:53PM +0800, Leo Yan wrote:
> Hi Mathieu,
> 
> On Fri, Mar 17, 2017 at 10:13:35AM -0600, Mathieu Poirier wrote:
> 
> [...]
> 
> > > +- compatible : should be
> > > +	     * "arm,coresight-cpu-debug"; supplemented with "arm,primecell"
> > > +	       since this driver is using the AMBA bus interface.
> > 
> > This description needs to be refactored - see my comment from an earlier post
> > for more details.
> 
> I have refined this description according to your suggestion:
> http://archive.armlinux.org.uk/lurker/message/20170301.154550.f55a09d5.en.html

My apologies here, I did not express myself properly.  You got the wording right
but the format is a little bizarre.  The line break after "should be" and the
sentence that starts with a '*' on the next line feel unatural.  Simply

compatible : should be "arm,coresight-cpu-debug"; supplemented with
             "arm,primecell" since this driver is using the AMBA bus interface.

will be fine.

> 
> Am I missing anthing for this?
> 
> > > +- reg : physical base address and length of the register set.
> > > +
> > > +- clocks : the clock associated to this component.
> > > +
> > > +- clock-names : the name of the clock referenced by the code. Since we are
> > > +                using the AMBA framework, the name of the clock providing
> > > +		the interconnect should be "apb_pclk" and the clock is
> > > +		mandatory. The interface between the debug logic and the
> > > +		processor core is clocked by the internal CPU clock, so it
> > > +		is enabled with CPU clock by default.
> > > +
> > > +- cpu : the cpu phandle the debug module is affined to. When omitted
> > > +	the module is considered to belong to CPU0.
> > > +
> > > +Optional properties:
> > 
> > s/properties/property
> > 
> > > +
> > > +- power-domains: a phandle to power domain node for debug module. We can
> > > +		 use "nohlt" to ensure CPU power domain is enabled.
> > 
> > The "power-domains" property is to take care of the debug power domain.  The
> > "nohlt" is to make sure registers in the CPU power domain are accessible - both
> > are independent from one another.  As such the description for this binding
> > shoudl be:
> > 
> > "a phandle to the debug power domain".
> 
> Will fix for upper two comments.
> 
> Thanks,
> Leo Yan
