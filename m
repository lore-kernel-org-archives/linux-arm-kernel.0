From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 10:17:59 -0700
Subject: [PATCH 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <5769058D.9020008@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466452907-23290-2-git-send-email-srinivas.kandagatla@linaro.org>
 <57687B08.9060900@codeaurora.org> <5769058D.9020008@linaro.org>
Message-ID: <20160628171759.GZ1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21, Srinivas Kandagatla wrote:
> I agree, this should match up with the dtbTool. I have been manually
> patching up dtb to include the board-id, pmic id stuff.

Uh oh :/

> 
> I will fix it in next version,
> 
> Did not look at full details but, For some reason dtbTool does not
> support multiple compatible strings, do you think it makes sense to
> add this support in dtb tool to cope up with compatible strings
> like:
> 
> compatible = "qcom,apq8096-db820c", "qcom,apq8096-sbc";
> 

Hmm I suppose we can add support to look for the first compatible
that matches something that we can generate an id for? That would
allow us to have the LK compatible and then whatever is more
specific than that which the bootloader doesn't care about.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
