From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 2 Aug 2016 11:32:15 +0800
Subject: [v3,2/6] power: add power sequence library
In-Reply-To: <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
References: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
 <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
Message-ID: <20160802033215.GB26831@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 01:06:48PM -0700, Matthias Kaehlcke wrote:
> >...
> >
> >+static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	enum of_gpio_flags flags;
> >+	int reset_gpio, ret = 0;
> >+
> >+	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
> This only gets the first of potentially multiple clocks, is that intended?

Matthias, I have added multiple input clocks support at v4 patch set,
and you are at cc list.

-- 

Best Regards,
Peter Chen
