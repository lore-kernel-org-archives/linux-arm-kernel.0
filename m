From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Feb 2017 16:25:33 +0530
Subject: Recommended notation for OPP to avoid DTC warnings
In-Reply-To: <20170227104445.GE6795@leverpostej>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
 <20170227104445.GE6795@leverpostej>
Message-ID: <20170227105533.GA19417@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-02-17, 10:44, Mark Rutland wrote:
> On Sun, Feb 26, 2017 at 02:18:03PM +0900, Masahiro Yamada wrote:
> > Hi.
> > 
> > 
> > Decumentation/devicetree/bindings/opp/opp.txt
> > takes examples like this:
> > 
> >         opp at 1000000000 {
> >                 opp-hz = /bits/ 64 <1000000000>;
> >                 opp-microvolt = <970000 975000 985000>;
> >                 opp-microamp = <70000>;
> >                 clock-latency-ns = <300000>;
> >                 opp-suspend;
> >         };
> 
> > If we follow this notation and the device-tree is built with W=1,
> > DTC warns like follows:
> > 
> > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> > unit name, but no reg property
> > 
> > Is there a recommended notation to avoid it?
> > 
> > Maybe, simply omit the "@" ?
> 
> I think just s/@/-/ should be fine, e.g. call the above opp-1000000000.

That's fine with me. I can send a patch to fix all existing users if we all
agree for it.

-- 
viresh
