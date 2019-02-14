Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15332C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:43:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C4B21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CI0LBAvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4B21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W0n/gKhNMHvHuyDvum0IoLZUmD2/HuiFFKqFD/DHCIo=; b=CI0LBAvGeG0tTch4VUmPi1IDY
	JhtLirpRLWEyUBj9NgZG+3UICmN94HylgpCNaZvAAeIYOOjcf++TnhH0yqVsgNEH4LGaqV8HkaLS9
	nblsOSmVU5DJcvOkkZE4y/OX+BmGHz0nxM6B1dEqisA2wMWdAPX4T126JT6epYJkQ9kyR2f9UPCjv
	BcjKcaid+nGoU0qRGLB05xeaKqU/L5Xy4w+nzWZzNgP/0+9O5Z8kUsUsUOveac97x5tyIGNrogJTF
	Fz/Jhgj52gVqXJmeKa9Y7ZxzENyI73a3mNX5yLcDdRoyVWWVzkUjnQjSC8hqQO0iB7Xi+bCSZG7z1
	InYnW78vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu57P-0007tq-5z; Thu, 14 Feb 2019 00:43:11 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu57K-0007tC-Pb
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:43:08 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 14 Feb 2019 09:43:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3E117180101;
 Thu, 14 Feb 2019 09:43:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Thu, 14 Feb 2019 09:43:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id A38BE1A04E0;
 Thu, 14 Feb 2019 09:43:04 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 81FD3121B6C;
 Thu, 14 Feb 2019 09:43:04 +0900 (JST)
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock
 description
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
 <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
 <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <38afb1e0-2af9-0eb1-9d1b-4ff7273e25ab@socionext.com>
Date: Thu, 14 Feb 2019 09:43:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_164307_093705_03AE34FD 
X-CRM114-Status: GOOD (  17.66  )
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
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/14 3:07, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-02-13 09:55:34)
>> The subject seems to have been cut off? "ndings"?
>>
>> Quoting Sugaya Taichi (2019-02-08 04:27:03)
>>> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>>> new file mode 100644
>>> index 0000000..bcfc5df
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>>> @@ -0,0 +1,49 @@
>>> +Milbeaut SoCs Clock Controller Binding
>>> +----------------------------------------
>>> +Milbeaut SoCs Clock controller is an integrated clock controller, which
>>> +generates and supplies to all modules.
>>> +
>>> +This binding uses common clock bindings
>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +
>>> +Required properties:
>>> +- compatible: should be one of the following:
>>> +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
>>> +- reg: shall contain base address and length of clock registers
>>> +- #clock-cells: shall be 1
>>> +- clocks: shall be an external clock
>>> +
>>> +Example: Clock controller node:
>>> +
>>> +       clk: m10v-clk-ctrl@1d021000 {
>>> +               compatible = "socionext,milbeaut-m10v-clk-ccu";
>>
>> I thought there was some length limit on compatible string names. 32
>> bytes? Just barely under!
>>
> 
> Ah I'm wrong. Compatible is 128. Good.
> 
> Seems I was thinking of DT property names.
> 

Sorry confusing you.
I accidently deleted "dt-bi" from subject when committing.
I repair the string in the next version.

Thanks,
Sugaya Taichi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
