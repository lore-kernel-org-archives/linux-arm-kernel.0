Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9D921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UU8KmCsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9D921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pkS6F7qRM2VRqrXeneTt8Y4KGr1158BwCyzGz0sakn8=; b=UU8KmCsPxxWqJBymNW8uperfX
	KU9ikg9R1pWdkCUAFir+0hYtqRa6NNE3ZTT3ttCBB9jt78BeFjtzjwt30JZYzPk2ONZ9zGsQglFKd
	l4sPfiELzEA1LNc79B/jMiILiFq8cLwqvwKyO3/5K4k0K4aUcACjw7fttwCs0gmlOmPrqUZUKHUJm
	SuEfq6tDtwp6izmBsR78aF2IdAvKKxIVpwatnlv4vi1Z5qFe99Yfoyt+Yhi4AOJDDfkwTee3ZUi9i
	5A8PTB7lx3JUstFv3wIcph0Gfvs1o1AqHm4QhjUmZpgbjoZxULIv/LYITHpoasvewNdm+llHoJ7i8
	oEMYzLrUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gby6t-0004Nw-Ox; Wed, 26 Dec 2018 01:35:47 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gby6q-0004N7-Kq
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 01:35:46 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 26 Dec 2018 10:35:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 71B3C1800F6;
 Wed, 26 Dec 2018 10:35:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 26 Dec 2018 10:35:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id C5FE740370;
 Wed, 26 Dec 2018 10:35:28 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id A3C9A1205A0;
 Wed, 26 Dec 2018 10:35:28 +0900 (JST)
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Date: Wed, 26 Dec 2018 10:35:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_173544_806193_B789FD61 
X-CRM114-Status: GOOD (  18.31  )
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

On 2018/11/30 17:31, Stephen Boyd wrote:
>> +       init.num_parents = parents;
>> +       init.parent_names = parent_names;
>> +
>> +       mcm->cname = clk_name;
>> +       mcm->parent = 0;
>> +       mcm->hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &mcm->hw);
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +
>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       return;
>> +
>> +err_clk:
>> +       kfree(mcm);
>> +err_mcm:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>> +                       m10v_clk_mux_setup);
> 
> Any chance you can use a platform driver?
> 

Excuse me to re-ask you.
Why do you recommend to use a platform driver? Is that current fad?

Thanks
Sugaya Taichi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
