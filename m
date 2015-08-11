From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Aug 2015 10:30:39 +0100
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150811080023.GB5509@linux>
References: <20150728022936.GB1229@linux>
 <20150728225510.GB3159@codeaurora.org> <20150729081403.GH2284@x1>
 <20150729221526.GE3159@codeaurora.org> <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org> <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1> <20150811080023.GB5509@linux>
Message-ID: <20150811093039.GA18282@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, Viresh Kumar wrote:

> On 10-08-15, 14:22, Lee Jones wrote:
> > >  Optional properties:
> > > +- opp-cuts: One or more strings, describing the versions of hardware the OPPs
> > > +  can support.
> > 
> > This isn't very generic.
> > 
> > I'm guessing some vendors my have quite a few ways to differentiate
> > between board versions/revisions/cuts etc.
> > 
> > How about another array where a vendor can choose to identify a piece
> > of hardware however they see fit.
> > 
> > Example 1 (simple version):
> > 
> > /* Version 1 */
> > opp-version = <1>;
> > 
> > Example 2 (using the kernel's versioning):
> > 
> > /* 2.6.32-rc1 */
> > opp-version = <2 6 32 1>;
> > 
> > Example 3 (using ST's versioning):
> > 
> > /* Major 2, Minor 0, Cut 2, All substrates */
> > opp-version = <2 0 2 0xff>;
> 
> But how will we parse this with generic code ?

Why would you want to?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
