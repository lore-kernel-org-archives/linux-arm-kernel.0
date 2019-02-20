Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3332C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:29:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838302147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lT/E3RHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838302147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ERYdamZoa+YVAVQR9P7xnC3Fw+7FqRieuUKz4o99wfw=; b=lT/E3RHzUdpkMlc+f/6NfjbNH
	dt0Hf92yyUgzMJEJYMW46sFLZs59YEI2SHOkro4VQbZAWy0sdiYp2IyyHtJnbqgym8b7aSk8sz4cc
	6LtSojBAJ8fwdTGca8jqsCv1il1IYX+YtWjN/A8TwA9U6L1wtVsTy/4wZjn7s54PbkBKgVQDF2/x2
	75a/imeS1ke2zhL8dO42y1i9zZ1GY2UKgcPEompKIJua007if8UbTlCrU6VQbZ+tCGeMyAnAzudQV
	Vh4J7Xlwc0tinEmYuq8Y/q8j26gcKmJKE+7LLayevF3O1SJXPhEjTdea9QCQ8M90r07jzsanGPe8N
	Uzh0+MPRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwKS8-0006pd-Dh; Wed, 20 Feb 2019 05:29:52 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwKS5-0006pK-VV
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 05:29:51 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 20 Feb 2019 14:29:48 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C2B70180097;
 Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Wed, 20 Feb 2019 14:29:48 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 5266C1A04E0;
 Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 3894F121B6C;
 Wed, 20 Feb 2019 14:29:48 +0900 (JST)
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To: Arnd Bergmann <arnd@arndb.de>
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com>
 <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
 <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <cdba2c36-59bc-fb50-a795-03f9b00b11c8@socionext.com>
Date: Wed, 20 Feb 2019 14:29:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_212950_121795_9B04E38C 
X-CRM114-Status: GOOD (  22.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/19 19:11, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 6:11 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>> Thank you for you comments.
>>
>> On 2019/02/18 21:09, Arnd Bergmann wrote:
>>> On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>>> +
>>>> +       aliases {
>>>> +               serial1 = &uart1;
>>>> +       };
>>>
>>> Maybe start with serial0 here? It seems unusual to start
>>> counting at 1.
>>>
>>
>> The M10V evaluation board(EVB) uses a console with uart ch1, so this
>> alias number is derived from the used channel one.
>> Therefore it is no problem to change the alias number to 0.
> 
> The alias should normally reflect whatever is printed on the board,
> if there are no labels, the convention is to start with zero, regardless
> of what internal uart is connected to it.
> 

I got it.
I use a "serial0" beacause there are no labels about uart ch on M10V EVB.

Thanks,
Sugaya Taichi

>       Arnd
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
