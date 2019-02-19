Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E954721848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VETZ3r63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E954721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DF0QN0w+bwSTMVIfvj4yr+m9RB+HRDa5TMYwha2JoJo=; b=VETZ3r63ZfFW9rcGDBrRhWOV9
	RfAlXk9XpvHV8kriVOFdAbMyIDay6hrCX34aqr/wVqju8bRBkfdegOdj8oUJOAxGimXDHrb5XmWto
	1YmpOlCqNALyy9qYROpcwYpmDUOpj0M0d7HeolWKOSnY1Rc0PPJ73dYHnN0ETLr6b4bXKnrxnV69y
	3dXc0nu+FNvonT8m1nNPQCnpaY0qCZVPmv9g4oSLnFuwhqMSsrA1JJNER/p6Z+jcUBorznHiI3gMU
	CSBtfmQIiXLS7tubxkUk4wKU+xWTouJ3s/1fwLk1ZMwgZPr3svVOZJVjz1HVrfptR8705q3R9KXzA
	QSGswCtPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw02T-0003JN-Gs; Tue, 19 Feb 2019 07:42:01 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw02O-0003Ix-WA
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:41:59 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 19 Feb 2019 16:41:56 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4F3AE180C10;
 Tue, 19 Feb 2019 16:41:56 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Tue, 19 Feb 2019 16:41:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id CBC4C40340;
 Tue, 19 Feb 2019 16:41:55 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id B78F2121B6C;
 Tue, 19 Feb 2019 16:41:55 +0900 (JST)
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To: Rob Herring <robh@kernel.org>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
 <20190218195247.GA9690@bogus>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c111792a-397e-4018-fa94-ff03f06fa23a@socionext.com>
Date: Tue, 19 Feb 2019 16:41:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218195247.GA9690@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_234158_572822_3AD08CC2 
X-CRM114-Status: GOOD (  22.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/19 4:52, Rob Herring wrote:
> On Fri, Feb 08, 2019 at 09:26:04PM +0900, Sugaya Taichi wrote:
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
> 
> Most boards/soc bindings are using DT schema (yaml) now. We're not
> requiring that just yet, but I'd like to not add more. So can you
> convert this to schema.
> 

Probably yes. I try to convert with looking at references.

Thanks,
Sugaya Taichi

> Rob
> 
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
>> new file mode 100644
>> index 0000000..9fd053a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
>> @@ -0,0 +1,6 @@
>> +Milbeaut platforms device tree bindings
>> +---------------------------------------
>> +
>> +- Milbeaut M10V Evaluation Board
>> +    Required root node properties:
>> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
>> -- 
>> 1.9.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
