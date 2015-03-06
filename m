From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 08:25:17 -0800
Subject: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy
 mpurate command line param
In-Reply-To: <54F9D160.7010708@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
 <1425644939-3232-12-git-send-email-t-kristo@ti.com>
 <20150306153254.GK13520@atomide.com> <54F9D160.7010708@ti.com>
Message-ID: <20150306162516.GN13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150306 08:10]:
> On 03/06/2015 05:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [150306 04:29]:
> >>The legacy support is wrong and dangerous, as it doesn't take any
> >>OPPs into account and does not scale voltages. Switching mpurate should
> >>be handled through cpufreq.
> >
> >Hmm I wonder if some systems actually rely on the mpurate cmdline
> >parameter. If this cannot be fixed properly, you should at least
> >print an error here.
> 
> Yea, I was kind of worried about this comment. We have also an option of
> doing this through clock driver, but I was hesitant of doing this either.
> Isn't having a global kernel option like this frowned upon anyway? I believe
> this piece of init code gets executed on every board on multiarch kernel.

Well the option has been there probably for 10 years already so we
can't just drop it like that. Chances are it's unused though, so I
suggest you just print out a warning for it.

It's called from omap_arch_initcall which checks for soc_is_omap()
so that's not an issue. But when moving the code, you naturally
need to check the moved code initcall usage.

Regards,

Tony
