From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 23 Mar 2018 11:25:31 -0500
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <1521804964.23017.96.camel@linux.intel.com>
 <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
Message-ID: <9edb00e7-51e3-68f7-c606-333b7d57d602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2018 11:21 AM, Stephen Boyd wrote:
> I'll send the updated patches now.

Thanks.

BTW, I just discovered that the static globals in pinctrl-msm are 
breaking the ability to support more than one TLMM:

static struct pinctrl_desc msm_pinctrl_desc = {

static struct irq_chip msm_gpio_irq_chip = {

static struct msm_pinctrl *poweroff_pctrl;

I'm going to have to fix all of these.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
