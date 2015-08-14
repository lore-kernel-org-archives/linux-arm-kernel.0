From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 13 Aug 2015 17:46:02 -0700
Subject: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
In-Reply-To: <20150813041402.GI13472@usrtlx11787.corpusers.net>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
 <20150811224902.GO2839@codeaurora.org>
 <20150812201855.GF13472@usrtlx11787.corpusers.net>
 <55CBC14B.8000509@codeaurora.org>
 <20150813041402.GI13472@usrtlx11787.corpusers.net>
Message-ID: <20150814004602.GV26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12, Bjorn Andersson wrote:
> On Wed 12 Aug 14:57 PDT 2015, Stephen Boyd wrote:
> 
> > Here's the patch I'm suggesting. The device name is probably wrong, but 
> > you get the idea.
> 
> Looks very much like my take on it as well, I do however have concerns
> that suddenly the node called "clock-controller" will have to come with
> tsens related properties.
> 
> Are all the tsens-in-gcc blocks the same?

Yes they're all the same, except some of them have more sensors
than others. It depends on what SoC the hardware is instantiated
in. They also messed up the software interface and had to add
discontinuous registers for the sensors because it was never
designed to have more than 4 sensors or something like that. But
even that sort of change can be handled by figuring out the
format of the sensor data in the qfprom.

> Or do you intend to of_match
> on the gcc compatible in the tsens driver?
> 

I hope we don't have to of_match in the tsens driver on gcc
compatible strings.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
