From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Feb 2017 09:12:05 +0530
Subject: Recommended notation for OPP to avoid DTC warnings
In-Reply-To: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
Message-ID: <20170227034205.GG7147@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-02-17, 14:18, Masahiro Yamada wrote:
> Hi.
> 
> 
> Decumentation/devicetree/bindings/opp/opp.txt
> takes examples like this:
> 
>         opp at 1000000000 {
>                 opp-hz = /bits/ 64 <1000000000>;
>                 opp-microvolt = <970000 975000 985000>;
>                 opp-microamp = <70000>;
>                 clock-latency-ns = <300000>;
>                 opp-suspend;
>         };
>         opp at 1100000000 {
>                 opp-hz = /bits/ 64 <1100000000>;
>                 opp-microvolt = <980000 1000000 1010000>;
>                 opp-microamp = <80000>;
>                 clock-latency-ns = <310000>;
>         };
>         opp at 1200000000 {
>                 opp-hz = /bits/ 64 <1200000000>;
>                 opp-microvolt = <1025000>;
>                 clock-latency-ns = <290000>;
>                 turbo-mode;
>         };
> 
> 
> If we follow this notation and the device-tree is built with W=1,
> DTC warns like follows:
> 
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> 
> Is there a recommended notation to avoid it?
> 
> Maybe, simply omit the "@" ?

I would let Rob suggest something here.

-- 
viresh
