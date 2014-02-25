From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Feb 2014 17:03:47 -0800
Subject: [PATCH v2] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <530B8627.4020705@free-electrons.com>
References: <1392054179-28830-1-git-send-email-gregory.clement@free-electrons.com>
 <530A420B.5050207@gmail.com> <530B8627.4020705@free-electrons.com>
Message-ID: <20140225010347.22529.41519@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2014-02-24 09:49:27)
> On 23/02/2014 19:46, Tomasz Figa wrote:
> > On 10.02.2014 18:42, Gregory CLEMENT wrote:
> >> +
> >> +    for (i = 0; i < num_parents; i++) {
> >> +            if (of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> >> +                                           &clkspec))
> >> +                    return 1;
> >> +
> >> +            /* Check if we have such a provider in our array */
> >> +            found = false;
> >> +            list_for_each_entry(provider, &of_clk_providers, link) {
> >> +                    if (provider->node == clkspec.np) {
> >> +                            found = true;
> >> +                            break;
> >> +                    }
> >> +            }
> >> +
> >> +            if (!found)
> >> +                    return 0;
> >> +    }
> > 
> > ...or even better, __of_clk_get_from_provider() could modified to return
> > -EPROBE_DEFER if requested provider is not registered and you could 
> 
> There is already a patch sent for this "clk: return probe defer when DT clock
> not yet ready": http://article.gmane.org/gmane.linux.kernel/1643466
> 
> Mike will you take it?
> 
> Then I can use it to implement the suggestion made by Tomasz.

I have just merged it to clk-next. I'll push out an updated clk-next
branch later tonight.

Regards,
Mike
