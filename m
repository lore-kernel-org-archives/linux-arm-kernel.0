Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7CF208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K2JNOIH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7CF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JAzS1B0j5zsrzjaJkCp/NoHaBDgK3sEdRAEAksbyVCU=; b=K2JNOIH9zj4/c6zOGQDljcke+
	K37zXd+KkJaaMkTJXEfSnur/r9pvGglN/6Jnn9HSjXtRC3gyHBgyQnpUp1Gd9tR53Mxykq03cnomC
	EMJDKan6UaXY7/0he3FcQQalDZL0UYxPN9d7Qa8bb7wh9kEkEbLj4DRcpLoEMS+w9sZQkZW9G7ROF
	O0a7ns/NTpTmS5E9y6xC9hYZfUFhi2Brm7K//YKTwDAdj3I0BIuoadzLtVq2Ogghghw2wGg4ZjBtP
	vkNulyP/xd/UmpoV/zYPXh6j0NuFhMrXZ8uUCEp467CY9Ie3QBq1lR5KIWBbkz+VgN/8KrtNiFvGo
	g5lzlnOSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcloC-0004Wk-RN; Fri, 28 Dec 2018 06:39:48 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gclne-0003tG-P3
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 06:39:21 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 28 Dec 2018 15:38:59 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0D8C21800F6;
 Fri, 28 Dec 2018 15:39:00 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Fri, 28 Dec 2018 15:38:59 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id B1C6C40221;
 Fri, 28 Dec 2018 15:38:59 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 95260121BF2;
 Fri, 28 Dec 2018 15:38:59 +0900 (JST)
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
 <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <0c8db56a-6738-e003-5088-0c13588f695a@socionext.com>
Date: Fri, 28 Dec 2018 15:38:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_223915_697533_F06F1BC4 
X-CRM114-Status: GOOD (  26.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi

On 2018/12/28 9:39, Stephen Boyd wrote:
> Quoting Sugaya, Taichi (2018-12-25 17:35:27)
>> Hi
>>
>> On 2018/11/30 17:31, Stephen Boyd wrote:
>>>> +       init.num_parents = parents;
>>>> +       init.parent_names = parent_names;
>>>> +
>>>> +       mcm->cname = clk_name;
>>>> +       mcm->parent = 0;
>>>> +       mcm->hw.init = &init;
>>>> +
>>>> +       clk = clk_register(NULL, &mcm->hw);
>>>> +       if (IS_ERR(clk))
>>>> +               goto err_clk;
>>>> +
>>>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>>> +       return;
>>>> +
>>>> +err_clk:
>>>> +       kfree(mcm);
>>>> +err_mcm:
>>>> +       kfree(parent_names);
>>>> +}
>>>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>>>> +                       m10v_clk_mux_setup);
>>>
>>> Any chance you can use a platform driver?
>>>
>>
>> Excuse me to re-ask you.
>> Why do you recommend to use a platform driver? Is that current fad?
> 
> Not exactly a fad. We've been doing it for some time now. From an older
> email on the list:
> 
> Reasons (in no particular order):
> 
>    1. We get a dev pointer to use with clk_hw_register()
> 
>    2. We can handle probe defer if some resource is not available
> 
>    3. Using device model gets us a hook into power management frameworks
>       like runtime PM and system PM for things like suspend and hibernate
> 
>    4. It encourages a single DT node clk controller style binding
>       instead of a single node per clk style binding
> 
>    5. We can use non-DT specific functions like devm_ioremap_resource() to map
>       registers and acquire other resources, leading to more portable and
>       generic code
> 
>    6. We may be able to make the device driver a module, which will
>       make distros happy if we don't have to compile in all
>       these clk drivers to the resulting vmlinux
> 

Great thanks for answering. I strongly understand.
#It takes a bit of time to send v2.

Best Regards,
Sugaya Taichi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
