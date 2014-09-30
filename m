From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Sep 2014 12:13:05 -0700
Subject: [PATCH 1/4] ARM: DT: apq8064: add rpm support
In-Reply-To: <20140930190023.GS28481@sonymobile.com>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982092-7922-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5429DA95.80505@codeaurora.org> <20140930050203.GG28481@sonymobile.com>
 <542AF5FE.1000006@codeaurora.org> <20140930190023.GS28481@sonymobile.com>
Message-ID: <542B00C1.3010702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/14 12:00, Bjorn Andersson wrote:
>
> Hmm, seems I got that wrong, sorry about that.
>
> But do you mean "all wrong" as in that I use the wrong bit or to some greater
> extent? Currently all following requests should timeout, but maybe we should
> have a faster fail-path when we've hit this point?

Yes. We just ack the interrupt and go on happy to keep allowing clients
to request things. I'd rather see us blow up or start failing requests,
or maybe both.

>
> From a practical pov I guess that once the rpm starts returning errors on
> updates to regulators, root clocks and bus scaling then most of the system is
> becoming useless.

Right. Rebooting will be required fairly soon.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
