From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Nov 2015 17:40:34 +0530
Subject: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
In-Reply-To: <1446461181.10039.28.camel@mtksdaap41>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
 <1446461181.10039.28.camel@mtksdaap41>
Message-ID: <20151102121034.GA3639@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-11-15, 18:46, dawei chien wrote:
> On Wed, 2015-10-28 at 21:14 +0530, Viresh Kumar wrote:
> > Sorry for being extremely late in reviewing this stuff. You are
> > already on v3 and I haven't reviewed it once. Mostly due to bad timing
> > of my holidays and other work pressure.
> 
> You're welcome, truly thank you for your kindly reviewing

Thanks for understanding.

> > Now, there are few things that I feel are not properly addressed here,
> > and I may be wrong:
> > - Where are the bindings for static-power-points and
> >   dynamic-power-coefficient. Sorry I failed to see them in this or
> >   other series you mentioned.
> 
> Please refer to following document (2-1,2-2) for dynamic-power &
> static-power in detail. Besides, do I need to add another document for
> our own MT8173 IC.
> http://lxr.free-electrons.com/source/Documentation/thermal/cpu-cooling-api.txt

That's about the power-API, but I am talking about the Device Tree
bindings here. So, when you add any new DT bindings (Or a new property
in device tree blobs), you need to add its documentation in
Documentation/devicetree/bindings/... and get it approved by DT
maintainers as well. You perhaps missed that completely, otherwise you
would have been told really early that the new bindings aren't going
to help.

> > - Even then, why should we be adding another table into DT for
> >   voltage/power ? And not reuse and extend the opp-v2 stuff which is
> >   already mainlined now.
> 
> We could reuse opp-v2 for static power points after OPPV2 back port to
> our currently branch.

Your current branch doesn't matter to us. All that matters here is
mainline, that's where you are adding code to. And you must test your
stuff on the latest upstream branch only, not on some old kernel
release. You can include other dependency patches though, that are
required to make it work and mention them in cover-letter.

> However, as far as I know, there is no "power" in opp.c (suck like

s/suck/such ?

> opp-hz) as far, so I need to add something in opp.c for my purpose, suck
> like add power in _opp_add_static_v2, and add something for return
> "power", right? I may be wrong, please kindly give me your suggestion,
> thank you.

You first need to propose a change in DT bindings for OPPs:
Documentation/devicetree/bindings/opp/opp.txt

And then we can change the code properly.

> Actually, I am considering to remove the part of static power point
> since it is optional for Power Model. Could you agree with this?

If its not important for your platform, then I don't have any issues
with that..

-- 
viresh
