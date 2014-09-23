From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 23 Sep 2014 12:42:49 -0500
Subject: [PATCH v1] soc: qcom: do not disable the iface clock in probe
In-Reply-To: <1408081268-5748-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1408081268-5748-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <A61C4CA5-7558-4B3D-BF05-BBDD1C3F550F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2014, at 12:41 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> The use case here is when we have a bootconsole which is printing the
> characters on serial console and gsbi driver comes up after some time.
> As gsbi driver disables the clock in probe the bootconsole locks up.
> 
> This patch fixes the problem by disabling the clock in platform remove
> rather than in probe.
> 
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since RFC:
> 	- none, just a subject line change.

Srini,

We need some changes to the commit message for this to get into v3.17.

Probably some references to:

http://www.spinics.net/lists/linux-arm-msm/msg10589.html

Adding Kevin to provide details on what else should be in commit message w/regards to the regression we introduced.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
