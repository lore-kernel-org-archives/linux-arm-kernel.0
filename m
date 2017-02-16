From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 16 Feb 2017 21:55:36 +0800
Subject: [PATCH RFC 1/3] coresight: binding for coresight debug driver
In-Reply-To: <20170215200858.GA29730@linaro.org>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
 <1486966298-16767-2-git-send-email-leo.yan@linaro.org>
 <20170215200858.GA29730@linaro.org>
Message-ID: <20170216135536.GB544@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 01:08:58PM -0700, Mathieu Poirier wrote:
> On Mon, Feb 13, 2017 at 02:11:36PM +0800, Leo Yan wrote:
> > Adding compatible string for new coresight debug driver.
> > 
> 
> Hi Leo,
> 
> I agree with Mark, this will need a better description.
> 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/coresight.txt | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > index fcbae6a..3ff15fd 100644
> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > @@ -40,6 +40,9 @@ its hardware characteristcs.
> >  		- System Trace Macrocell:
> >  			"arm,coresight-stm", "arm,primecell"; [1]
> >  
> > +		- Debug Unit:
> > +			"arm,coresight-debug", "arm,primecell";
> > +
> 
> Humm...  The current CoreSight bindings are meant to describe IPs included in
> the HW assisted trace architecture.  This new driver, althought considered to be
> part of the CoreSight umbrella, falls under the debugging domain.
> 
> Adding the bindings in this file may lead people to beleive this driver fits
> into the CoreSight framework currently supported, which isn't the case.
> 
> As such it is probably a good idea to spin off a new file, "coresight-debug.txt"
> to handle this driver. 

I think this is good suggestion; if Mark has no objection, I will
follow up it.

> Mark, what's your take on this?
> 
> >  	* reg: physical base address and length of the register
> >  	  set(s) of the component.
> >  
> > @@ -78,8 +81,10 @@ its hardware characteristcs.
> >  	* arm,cp14: must be present if the system accesses ETM/PTM management
> >  	  registers via co-processor 14.
> >  
> > -	* cpu: the cpu phandle this ETM/PTM is affined to. When omitted the
> > -	  source is considered to belong to CPU0.
> > +* Optional properties for ETM/PTM/Debugs:
> > +
> > +	* cpu: the cpu phandle this ETM/PTM/Debug is affined to. When omitted
> > +	  the source is considered to belong to CPU0.
> >  
> >  * Optional property for TMC:
> >  
> > -- 
> > 2.7.4
> > 
