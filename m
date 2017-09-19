From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 19 Sep 2017 15:58:40 -0700
Subject: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
In-Reply-To: <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170919225840.GI30848@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-08-17, 00:10, Dong Aisheng wrote:
> This is useful to support platforms which only the clk setting is
> different from the generic OPP set rate but others like voltage
> setting are still the same.
> 
> Users can use this function to register a custom OPP set clk helper
> working in place of the default simple clk setting in the generic
> dev_pm_opp_set_rate(). Then user can still use dev_pm_opp_set_rate()
> with .set_clk() to save a lot duplicated work.

I am not inclined to add this support really. What prevents you to
register a clock for the device (which is CPU in your case) and the
generic clk_set_rate() will eventually call into the platform specific
routine. That's what everyone else is doing.

-- 
viresh
