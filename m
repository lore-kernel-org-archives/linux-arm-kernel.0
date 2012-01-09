From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 9 Jan 2012 13:58:52 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
 <20120109005603.GA1835@S2101-09.ap.freescale.net>
 <4F0A613F.80509@gmail.com>
 <CAMPhdO9gaZQ0oQpfmvvL6MWP_6L9XCOdXYNSgjqDWLQ73XpRpw@mail.gmail.com>
Message-ID: <20120109055850.GW2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 01:05:39PM +0800, Eric Miao wrote:
> >> ?/* Default string compare functions, Allow arch asm/prom.h to override */
> >> ?#if !defined(of_compat_cmp)
> >> ?#define of_compat_cmp(s1, s2, l) ? ? ? strcasecmp((s1), (s2))
> >> -#define of_prop_cmp(s1, s2) ? ? ? ? ? ?strcmp((s1), (s2))
> >> +#define of_prop_cmp(s1, s2) ? ? ? ? ? ?strcasecmp((s1), (s2))
> >> ?#define of_node_cmp(s1, s2) ? ? ? ? ? ?strcasecmp((s1), (s2))
> >> ?#endif
> >
> > Device-trees are case sensitive, so I don't think we want to go globally
> > changing that behavior.
> >
> > If you want lower case names, then change the sgtl5000 code to lower
> > case names.
> 
> +1, I'd vote for consistent lower case names.
sgtl5000 is used by many other platforms too. I doubt why we do the
big change just because it's convention or looks nice.
As I said in other mails, I don't feel good about the lower case
convention:
 - hw spec or sch may use upper case, lower case don't reflect exact.
 - the lower case rule might have to extend to other subsystems, for
   example, regulator. I bet it's not the only case when we get more
   and more DT bindings.

Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
