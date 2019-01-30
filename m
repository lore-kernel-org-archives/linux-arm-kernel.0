Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1307120844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBUZwWKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDwKOLyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1307120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lntd9Yx72ZR0Cvyb6vSNQ2j3XoIgKlRdg3Fi45/Nl1A=; b=IBUZwWKmaMomPv
	/xvSvcHdg6fJ1kcXNApXs1PRs2VIXyElAvlSmJE2eAkZ3XcDzovSkAWPuddjz24+cRSkJdyFRfY5E
	egFH6f3WI0G+TU7IDxJ7GxBF3K+XIP2VBXbjeoZNYe7GhsPDCYImCRf8GlvfasBz0jT9NnfsPfMaH
	hC+YVJRyT1wuzSVaqs9DINLEVn0yQJZZQCdlvW+tKNcR4bNWQIZzHBOSlJbqv+0v/nDEdWWUWTeHU
	yatniZFeMdPbNe2G0wgX73ZfFpgjGU6aA5q0uI+BkilueduDvBjtTRhND0CZaoZX2fQc/v6YocMvI
	m37C4AUsQawsOYGe43oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gooCJ-0000Fo-Ki; Wed, 30 Jan 2019 11:38:27 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gooCG-0000Ee-9X
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:38:26 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so21394986wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pws+GKp8yzQgeZUGmCTNNkAjBgitoirunLrvoyopzpM=;
 b=BDwKOLyGOAN8UF7lWBQZog94zQTb43MRJqfkAK4C1R7Wssy3/boI+Y4T8691aR1Fwu
 Yq2kCu9MPzNq9K+tqg0uw8uO2pltj1lI6fcyPHvS2FjhKdRyM7z+JZ5A0VhcqA9ylC8p
 NCvrunMUFv/w9Tc1LojR3yB7smTcKf6p5o/Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pws+GKp8yzQgeZUGmCTNNkAjBgitoirunLrvoyopzpM=;
 b=d3Xt+5SynY81hFQDl3ptqyetM6F7e+dGyD0LZnYuJg5ECwVSObfWpZ5a9i9gt28mzM
 oNYECgRyNFupR3QJ8F8y3oIJxsos/fadnS9Z+mo2wzSd0czGfoCY0rkK8f862ZBRhA+f
 JrFuQwAGRNXZ06QlFvVA1nux4SDr0+wun5OWKrykhz/mk+lE8rxgwrSskdd5ulxVYKSr
 5XO1y4SXSj9jJdRJbYdhEv4iUQ2Xxk4hckCwi63mEPS8tnz7APi9Y3Sf2Ru0nZx6dFdF
 oNrCOJXV0MFKi3kmiylEnMgEPzkQMxMYVel74MdlsQ9RYvXy65DvrCIWToDsk7eEXAVe
 P/pA==
X-Gm-Message-State: AJcUukdJbztRm4rI539qTh8vrUZQcL6yqRrSVGbLGChOT7u9FjpUQfEh
 LygWYsm3HLcQeLOLkkT6DGvYZw==
X-Google-Smtp-Source: ALg8bN4hXEAXeE1ZjOjDi69zhQEtsFcJvcuJdc21L/CLrsWUSckv/gAjPnplD1LpbI1kOyifRDg66A==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr24454264wme.1.1548848302712;
 Wed, 30 Jan 2019 03:38:22 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id y34sm3326299wrd.68.2019.01.30.03.38.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 03:38:21 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
 <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Message-ID: <8986d1ea-e009-6f15-e9ca-93cd64284ff7@linaro.org>
Date: Wed, 30 Jan 2019 12:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_033824_344934_75E2CB2F 
X-CRM114-Status: GOOD (  18.35  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 10:53, Jorge Ramirez wrote:
> On 1/29/19 21:27, Bjorn Andersson wrote:
>> On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>>> new file mode 100644
>>> index 0000000..e6ae96e
>>> --- /dev/null
>>> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>>> @@ -0,0 +1,347 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2018, Linaro Limited
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define PHY_CTRL0			0x6C
>>> +#define PHY_CTRL1			0x70
>>> +#define PHY_CTRL2			0x74
>>> +#define PHY_CTRL4			0x7C
>>> +
>>> +/* PHY_CTRL bits */
>>> +#define REF_PHY_EN			BIT(0)
>>> +#define LANE0_PWR_ON			BIT(2)
>>> +#define SWI_PCS_CLK_SEL			BIT(4)
>>> +#define TST_PWR_DOWN			BIT(4)
>>> +#define PHY_RESET			BIT(7)
>>> +
>>> +enum phy_vdd_ctrl { ENABLE, DISABLE, };
>>
>> Use bool to describe boolean values.
> 
> um, ok, but these are not booleans, they are actions (ie ctrl = action
> not true or false).
> 
> anyway will change it to something else
> 
>>
>>> +enum phy_regulator { VDD, VDDA1P8, };
>>
>> It doesn't look like you need either of these if you remove the
>> set_voltage calls.
> 
> we need to point to the regulator in the array so we need an index to it
> somehow.

you are right, we dont

> 
>>
>>> +
>>> +struct ssphy_priv {
>>> +	void __iomem *base;
>>> +	struct device *dev;
>>> +	struct reset_control *reset_com;
>>> +	struct reset_control *reset_phy;
>>> +	struct regulator *vbus;
>>> +	struct regulator_bulk_data *regs;
>>> +	int num_regs;
>>> +	struct clk_bulk_data *clks;
>>> +	int num_clks;
>>> +	enum phy_mode mode;
>>> +};
>>> +
>>> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
>>> +{
>>> +	writel((readl(addr) & ~mask) | val, addr);
>>> +}
>>> +
>>> +static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
>>> +{
>>> +	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;
>>
>> regulator_is_enabled() will check if the actual regulator is on, not if
>> you already voted for it.
>>
>> So if something else is enabling the vbus regulator you will skip your
>> enable and be in the mercy of them not releasing it. Presumably there's
>> only one consumer of this particular regulator, but it's a bad habit.
> 
> yep
> 
>>
>> Please keep track of this drivers requested state in this driver, if
>> qcom_ssphy_vbus_ctrl() is called not only for the state changes.
> 
> um, there is not such a function: the ctrl function is not for vbus but
> for vdd

argh, sorry, it is me who misread my own driver. ok I know what you
mean. will send the updated driver shortly.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
