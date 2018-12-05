Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E363C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:43:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC1420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XhqkADti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC1420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K6wrGKQH0/gzbd47CL6/fp7+/qWuMGXFw45/ICZAgkE=; b=XhqkADtiIv+r8V2A3jE8W885y
	w28ubDGwjxUdCzHk6DlfmcCOWuZd666T1M36/DLLpn0fKj8Cg2pcdUS8gC1onT55JxRkdXe5HOJdo
	clxbsNhYtiJvjbLvcIVC3EWjvkmp5onmiH0HUctCxiuS3/RqXBpOI4Si1lNUew4uZZL3p6zo7TU6V
	FHFlkzdHxh5T07L3DLpwEi122ZS//g9oVOkAZFFNSS13DUy/iL63TG8htfCtF2FtcMiqQ5A2HGbir
	R8WqJOIVLzahPurb/aUSM78Q536gXARSboFrxPXaQsLDrsfg5+PRskxXS8PpqGJn7iUylA1x2RNQe
	M1NGSzLCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUVZy-0007ij-Jv; Wed, 05 Dec 2018 11:42:58 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUVZu-0007hS-BR
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:42:56 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 05 Dec 2018 20:42:42 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8160F180B3E;
 Wed,  5 Dec 2018 20:42:42 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 5 Dec 2018 20:42:42 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 55CDA40377;
 Wed,  5 Dec 2018 20:42:42 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 38B13120455;
 Wed,  5 Dec 2018 20:42:42 +0900 (JST)
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
 <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c0b37449-1221-9849-8014-13b3eeb43382@socionext.com>
Date: Wed, 5 Dec 2018 20:42:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_034254_506866_D353DA24 
X-CRM114-Status: GOOD (  22.06  )
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

On 2018/12/05 3:15, Stephen Boyd wrote:
> Quoting Sugaya, Taichi (2018-12-04 00:26:16)
>> On 2018/11/30 17:31, Stephen Boyd wrote:
>>> Quoting Sugaya Taichi (2018-11-18 17:01:12)
>>>> +void __init m10v_clk_mux_setup(struct device_node *node)
>>>> +{
>>>> +       const char *clk_name = node->name;
>>>> +       struct clk_init_data init;
>>>> +       const char **parent_names;
>>>> +       struct m10v_mux *mcm;
>>>> +       struct clk *clk;
>>>> +       int i, parents;
>>>> +
>>>> +       if (!m10v_clk_iomap())
>>>> +               return;
>>>> +
>>>> +       of_property_read_string(node, "clock-output-names", &clk_name);
>>>> +
>>>> +       parents = of_clk_get_parent_count(node);
>>>> +       if (parents < 2) {
>>>> +               pr_err("%s: not a mux\n", clk_name);
>>>
>>> How is this possible?
>>
>> When the node has more than 1 clks...
>> Or I am misunderstanding your question?
> 
> This looks like code that's checking DT for correctness. We don't
> typically do that in the kernel because the kernel isn't a DT validator.
> That's all I'm saying. I think this comment is not useful if the driver
> design is done to specify parent linkages in C code instead of DT, so
> don't worry about this too much.

I understand.
Thank you for additional information.

Sugaya Taichi

> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
