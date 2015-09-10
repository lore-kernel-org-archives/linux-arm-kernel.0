From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Sep 2015 09:31:46 +0100
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150910010426.GM5266@linux>
References: <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux> <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux> <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux> <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
 <20150910010426.GM5266@linux>
Message-ID: <20150910083146.GG3260@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Sep 2015, Viresh Kumar wrote:

> On 09-09-15, 17:57, Stephen Boyd wrote:
> > I think it will work for qcom use cases.
> 
> Thanks for the Rant Rob, it finally got me moving :)
> 
> > We can collapse the
> > tables down to one node and have speed bin and version as the
> > opp-supported-hw property. The opp-microvolt-names property would
> 
> I am probably going to remove opp-microvolt-names property as well, if
> we are going to use separate entries for all voltage ranges in OPP
> node. i.e. two voltage ranges, slow and fast, like this:
> 
>                      regulator A       regulator B
> opp-microvolt-slow = <tarA minA maxA>, <tarB minB maxB>;
> opp-microvolt-fast = <tarA minA maxA>, <tarB minB maxB>;
> 
> > be where we put the different voltage bins. What about the other
> > properties like opp-microamp or opp-suspend? Will all of those
> 
> Lets keep them as is for now, unless we have a real user.
> 
> > also get *-names properties to index into them based on some
> > string? I don't actually need those for my devices, but I'm just
> > pointing it out in case someone else wants to compress tables but
> > they have different microamps or clock latencies, etc.
> > 
> > Finally, does this mean we will get rid of operating-points-names?
> 
> That's the next thing I wanted to ask from Rob. We are surely not
> going to use them and there are no users or kernel code to support
> them today. Can we get rid of them from the DT ?

I think you answered your own question.

No users == !ABI == Strip it out.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
