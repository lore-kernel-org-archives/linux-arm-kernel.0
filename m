Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC3C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD2F222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p+zoiyMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD2F222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B8z8/cUeFuADtIrUw+of0CqZ4rYhylkZJuqBzkdBYzM=; b=p+zoiyMpX4onjwXdj+j+s6imd
	0sDX49STjrtdr2YZDCQ+ds45pGB/yOKik107lt/e0dv5/MZS2zdYLynGj83eI1rLEAQYbSU1uDxBf
	lzgRQTt95v6EomzWKqu/4nBs4PCje5l26kxtnnispuA8jIuHvHqGegCL0f7IEJtd1HUOa/XCuUK8D
	Ca18oD7G3lUR7ZsZoRs4MHsvs9ubZhLfwmF2mfHPBrQu9VAiwd1hZBPx58xqkzaSABi9VmGyg9B2F
	jBqDbvseZIfcx+0OVLSmjnDRGklmL5JPlwXWbfA+JCalgvM0DDAID8WqLFc3RvDCxQyUUBuBigJ3A
	TKfHDr5nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtmoy-0005S4-Hc; Wed, 13 Feb 2019 05:10:56 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtmov-0005Rg-3e
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 05:10:54 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 13 Feb 2019 14:10:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 544B8180081;
 Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 13 Feb 2019 14:10:52 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 2C8A940389;
 Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 14789120459;
 Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut
 M10V pinctrl description
To: Linus Walleij <linus.walleij@linaro.org>
References: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
 <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <00b70c95-362c-e286-a7cf-1b38d6de7993@socionext.com>
Date: Wed, 13 Feb 2019 14:10:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_211053_273119_E6EC9C94 
X-CRM114-Status: GOOD (  23.85  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Takao Orito <orito.takao@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2019/02/08 22:32, Linus Walleij wrote:
> Hi Sugaya,
> 
> thanks for your patch!
> 
> On Fri, Feb 8, 2019 at 1:32 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> Add DT bindings document for Milbeaut M10V pinctrl.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> (...)
>> +- interrupts: three interrupts specifer.
>> +- interrupt-names: corresponds "interrupts" factor.
> (...)
>> +               interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
>> +                               <0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
>> +                               <0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
>> +                               <0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
>> +               interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
>> +                               "pin-52", "pin-53", "pin-54", "pin-55",
>> +                               "pin-56", "pin-57", "pin-58", "pin-59",
>> +                               "pin-60", "pin-61", "pin-62", "pin-63";
> 
> As mentioned in the review of the driver, don't do this.
> 
> This is a hierarchical interrupt controller, so these
> GIC-offset-to-GPIO-interrupt-offests should be hardcoded in
> the driver.
> 
> If these interrupt offsets differ between difference instances of
> this pin controller, they should have different compatible strings.
> 
> Yours,
> Linus Walleij
> 

I understand.
I am sure the content of bindings will change as a whole as driver changes.
Try it.

Thanks,
Sugaya Taichi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
