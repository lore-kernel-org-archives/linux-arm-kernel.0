Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:19:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC59620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KGah3Fj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC59620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tQsMa04HyYMGf3ze6+RBohW6H139jDpwlb6JFTVfMv4=; b=KGah3Fj4rPOwEX45LAw2sps05
	k4tNdhnvKnNiCGwe0FdEuyodkCMYplBLOHWWcHDp04MgRDVDH9HSrgDUTTL2NNWG3qwTmO636qnz1
	ohayYCt1TvDuQ2LpFiwTvxyAUvKqtfE+BIeUon+x2gxHmSxl5CmAWIfozqmaaDamclYE4POxBD4yl
	/oj4/PdtgtqBxnH4OwpmfjYHoe4GJ/RWvsdIg6I+6ttLoBPrW4pJSNOQZJr14cFFzdW31gliPxO3W
	URUtbgD+54YCUmGmadwUOcuGQbMomLqilLD2JpscAKDvAsXmhYssaVcKVgiPclbS3oiT07YrNtUUA
	D5OnADziA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0cF-00074o-QP; Tue, 19 Feb 2019 08:18:59 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0cD-00074O-7a
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 08:18:58 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 19 Feb 2019 17:18:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 511526117D;
 Tue, 19 Feb 2019 17:18:56 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Tue, 19 Feb 2019 17:18:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 030CA404DC;
 Tue, 19 Feb 2019 17:18:56 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id E2159121B6C;
 Tue, 19 Feb 2019 17:18:55 +0900 (JST)
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To: Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <e28fd693-8ec9-3e89-7f98-62661c80e42b@socionext.com>
Date: Tue, 19 Feb 2019 17:18:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_001857_385592_AE800EFA 
X-CRM114-Status: GOOD (  22.67  )
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/19 10:25, Masahiro Yamada wrote:
> On Fri, Feb 8, 2019 at 9:26 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
> 
> 
> 
> I added uniphier SoC/board binding into
> 
> Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> 
> 
> You can milbeaut.txt to the socionext directory as well.
> 

Thank you for informing. I found the directory there.
I will add the "milbeaut.txt(yaml)" there.

Thanks,
Sugaya Taichi

> 
> 
> 
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
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
