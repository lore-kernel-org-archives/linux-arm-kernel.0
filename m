From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Oct 2015 11:09:36 -0700
Subject: [PATCH] clk: qcom: Drop calls to qcom_cc_remove()
In-Reply-To: <56163F97.1060604@codeaurora.org>
References: <1444288678-24594-1-git-send-email-sboyd@codeaurora.org>
 <56163F97.1060604@codeaurora.org>
Message-ID: <20151008180936.GG26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08, Rajendra Nayak wrote:
> On 10/08/2015 12:47 PM, Stephen Boyd wrote:
> > Now that qcom_cc_remove() is a nop, drop calls to
> > qcom_cc_remove() and any empty driver remove functions.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > And here's the driver part. I left 8960_remove in place to make your patch
> > easier to apply. Time to sleep.
> 
> I was trying to test this out, but looks like none of our clock drivers
> support a clean remove and reprobe (with or without this patch)
> 
> The problem seems to be the fixed rate clocks that get registered at probe,
> never unregistered, causing the subsequent probe to fail.

Yeah the gcc drivers are not so good there. We should probably fix those too.

The mmcc drivers support a clean remove and reprobe though. So I
tested it on msm8960 with these patches and everything looks
good. Removing gcc is sort of annoying because it provides the
clock for the serial console.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
