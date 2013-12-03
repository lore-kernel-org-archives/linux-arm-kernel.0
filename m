From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Dec 2013 14:43:09 +0000
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <CACRpkdZWELp1u=O=gSGZhaxQ2oTMu_jXuJb43snrr-tdYW9XAA@mail.gmail.com>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
 <529DE21E.4080707@linaro.org>
 <CACRpkdZWELp1u=O=gSGZhaxQ2oTMu_jXuJb43snrr-tdYW9XAA@mail.gmail.com>
Message-ID: <20131203144309.GC7552@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 02:13:49PM +0000, Linus Walleij wrote:
> On Tue, Dec 3, 2013 at 2:52 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> 
> > I will introduce has_arch_timer_node() as you said and use
> > it as follows:
> >
> > if (has_arch_timer_node())
> > clocksource_of_init();
> > esle
> > arch_timer_acpi_init(); /* try ACPI way */
> >
> > Is this make sense to you?

What does arch_timer_acpi_init() do? Is it just detecting the presence
of the timer, or grabbing the rate from a property in an ACPI table?

Mark.
