Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9E32146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jn/rxnQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9E32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ww+krtzldBYymEtAh8fripS+wBwluXoy7+MH6Rv4fVk=; b=jn/rxnQwYrwu6p3NN7mx/iY98
	ceItAHF3VmPzZsim5toxbOTv9nBd6/Mxhs8qIhTLoYvnz9BaENDOf0V199u/BRKWng0yrc7BdP1V7
	De3qhLQCZuGZvueBKezOdiQWuz/jcgVUZ41nMZuyHnLaVh9mSE7vUKlkMOLtK1pKo2ipg2Z0OjhUe
	c0mLOX/fk62X8stnHpbQp0JRDDfD4zqoItxx965pM64Or3d5VZW4bkrnoEL38hBKfYfaJZ5eJYFL+
	xZqAcGXtjwAjuk/rb/jmt7eCmiKc9LtXuglX+ZiFDZ/VBIcsgZoS1pk5QWsfEnT+8L1AZTsSJvgcY
	oYNii6qIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwcNE-0002Iv-At; Thu, 21 Feb 2019 00:38:00 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwcNA-0002I2-EB
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 00:37:58 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 21 Feb 2019 09:37:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B94296117D;
 Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Thu, 21 Feb 2019 09:37:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 7605C1A04E1;
 Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 5E8D2121B6C;
 Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Subject: Re: [PATCH v3 3/9] dt-bindings: Add documentation for Milbeaut SoCs
To: Rob Herring <robh+dt@kernel.org>
References: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
 <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <f31aa3e4-9f86-124f-6636-d2c2b4763cca@socionext.com>
Date: Thu, 21 Feb 2019 09:37:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_163756_588651_C5DE3A4B 
X-CRM114-Status: GOOD (  17.22  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/20 22:33, Rob Herring wrote:
> On Wed, Feb 20, 2019 at 1:43 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>> new file mode 100644
>> index 0000000..522396f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>> @@ -0,0 +1,22 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
>> +$schema: http://devicetree.org/meta-schemas/milbeaut.yaml#
> 
> This line is wrong. All DT schema should be:
> http://devicetree.org/meta-schemas/core.yaml#
> 

Ah, OK. Fix it soon.

Thanks,
Sugaya Taichi

>> +
>> +title: Milbeaut platforms device tree bindings
>> +
>> +maintainers:
>> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
>> +  - Takao Orito <orito.takao@socionext.com>
>> +
>> +properties:
>> +  $nodename:
>> +    const: '/'
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - socionext,milbeaut-m10v-evb
>> +          - const: socionext,sc2000a
>> +...
>> --
>> 1.9.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
