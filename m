Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED992081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FlJVAi9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED992081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b8ZuuatMoLK+oPncVaV/+8BN7d7wVxipC0vlInm1KmQ=; b=FlJVAi9f2Oxjao/QXlaMmTe7K
	gfzcBgjC5/juZMpnAs4/FkGEoXGlBXXIbKQThwVibGWYk+n+r/Nf+cpT+o3sVMB0hBK/RkunPatkw
	giYlEdtN0WJ7nU1cv/UXLFEvNpRG9MGrlemjOf0UbVeY41MexHsyNcxavPHt+l1wOXpmBEumHJwaA
	WQc1+rwcFXpMcG3IjQNAkvfD8WFixh2fffC1en4M9rPRWpqEJ73TC/V3canO53D4eJXz//TW+s3NI
	BrUZFtZMubehVfmK8Mk3P0tixEFRq4XRZf9OmLKDeC36SlqPptUrbF5qdTxAA6UiHezfkJDtMgjZu
	fJch1MG6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWCfk-0004M9-Kv; Mon, 10 Dec 2018 03:55:56 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWCfg-0004KI-57
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 03:55:54 +0000
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBA3tIgf031017;
 Mon, 10 Dec 2018 12:55:18 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 10 Dec 2018 12:55:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.2] (199.247.151.153.ap.dti.ne.jp [153.151.247.199])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBA3t9QS030987
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Mon, 10 Dec 2018 12:55:17 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2 0/7] add UniPhier DVB Frontend system support
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
References: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
 <000301d43ffe$9e6e9f80$db4bde80$@socionext.com>
 <20181207121716.17521ac2@coco.lan>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <75775717-e5b3-e08a-ff4d-760b81031717@katsuster.net>
Date: Mon, 10 Dec 2018 12:55:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181207121716.17521ac2@coco.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_195552_549138_2216AC27 
X-CRM114-Status: GOOD (  24.76  )
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
Cc: Sean Young <sean@mess.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Brad Love <brad@nextdimension.cc>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michael Ira Krufky <mkrufky@linuxtv.org>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Mauro,

Thank you for reviewing. Actually, I leaved Socionext at October
this year. I tried to find next person that maintain these patches
before leaving Socionext but I could not find.

And unfortunately, I cannot test and refine these DVB patches
because Socionext evaluation boards that can receive ISDB are not
sell and SoC specification is not public.

So it's better to drop my UniPhier DVB patches, I think...

Best Regards,
---
Katsuhiro Suzuki

On 2018/12/07 23:17, Mauro Carvalho Chehab wrote:
> Hi Katsuhiro-san,
> 
> Em Thu, 30 Aug 2018 10:13:11 +0900
> "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com> escreveu:
> 
>> Hello Mauro,
>>
>> This is ping...
> 
> Sorry for taking a long time to look into it.
> 
> Reviewing new drivers take some time, and need to be done right.
> 
> I usually let the sub-maintainers to do a first look, but they
> probably missed this one. So, let me copy them. Hopefully they
> can do review on it soon.
> 
> I'll try to do a review myself, but I won't be able to do it
> until mid next week.
> 
> Regards,
> Mauro
> 
>>
>>> -----Original Message-----
>>> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>>> Sent: Wednesday, August 8, 2018 2:25 PM
>>> To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>;
>>> linux-media@vger.kernel.org
>>> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
>>> <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
>>> linux-kernel@vger.kernel.org; Suzuki, Katsuhiro
>>> <suzuki.katsuhiro@socionext.com>
>>> Subject: [PATCH v2 0/7] add UniPhier DVB Frontend system support
>>>
>>> This series adds support for DVB Frontend system named HSC support
>>> for UniPhier LD11/LD20 SoCs. This driver supports MPEG2-TS serial
>>> signal input from external demodulator and DMA MPEG2-TS stream data
>>> onto memory.
>>>
>>> UniPhier HSC driver provides many ports of TS input. Since the HSC
>>> has mixed register map for those ports. It hard to split each register
>>> areas.
>>>
>>> ---
>>>
>>> Changes from v1:
>>>    DT bindings
>>>      - Fix mistakes of spelling
>>>      - Rename uniphier,hsc.txt -> socionext,uniphier-hsc.txt
>>>    Kconfig, Makefile
>>>      - Add COMPILE_TEST, REGMAP_MMIO
>>>      - Add $(srctree) to include path option
>>>    Headers
>>>      - Split large patch
>>>      - Remove more unused definitions
>>>      - Remove unneeded const
>>>      - Replace enum that has special value into #define
>>>      - Remove weird macro from register definitions
>>>      - Remove field_get/prop inline functions
>>>    Modules
>>>      - Split register definitions, function prototypes
>>>      - Fix include lines
>>>      - Fix depended config
>>>      - Remove redundant conditions
>>>      - Drop adapter patches, and need no patches to build
>>>      - Merge uniphier-adapter.o into each adapter drivers
>>>      - Split 3 modules (core, ld11, ld20) to build adapter drivers as
>>>        module
>>>      - Fix compile error if build as module
>>>      - Use hardware spec table to remove weird macro from register
>>>        definitions
>>>      - Use usleep_range instead of msleep
>>>      - Use shift and mask instead of field_get/prop inline functions
>>>
>>> Katsuhiro Suzuki (7):
>>>    media: uniphier: add DT bindings documentation for UniPhier HSC
>>>    media: uniphier: add DMA common file of HSC
>>>    media: uniphier: add CSS common file of HSC
>>>    media: uniphier: add TS common file of HSC
>>>    media: uniphier: add ucode load common file of HSC
>>>    media: uniphier: add platform driver module of HSC
>>>    media: uniphier: add LD11/LD20 HSC support
>>>
>>>   .../bindings/media/socionext,uniphier-hsc.txt |  38 ++
>>>   drivers/media/platform/Kconfig                |   1 +
>>>   drivers/media/platform/Makefile               |   2 +
>>>   drivers/media/platform/uniphier/Kconfig       |  19 +
>>>   drivers/media/platform/uniphier/Makefile      |   5 +
>>>   drivers/media/platform/uniphier/hsc-core.c    | 515 ++++++++++++++++++
>>>   drivers/media/platform/uniphier/hsc-css.c     | 250 +++++++++
>>>   drivers/media/platform/uniphier/hsc-dma.c     | 212 +++++++
>>>   drivers/media/platform/uniphier/hsc-ld11.c    | 273 ++++++++++
>>>   drivers/media/platform/uniphier/hsc-reg.h     | 272 +++++++++
>>>   drivers/media/platform/uniphier/hsc-ts.c      | 127 +++++
>>>   drivers/media/platform/uniphier/hsc-ucode.c   | 416 ++++++++++++++
>>>   drivers/media/platform/uniphier/hsc.h         | 389 +++++++++++++
>>>   13 files changed, 2519 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt
>>>   create mode 100644 drivers/media/platform/uniphier/Kconfig
>>>   create mode 100644 drivers/media/platform/uniphier/Makefile
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-core.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-css.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-dma.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-ld11.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-reg.h
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-ts.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc-ucode.c
>>>   create mode 100644 drivers/media/platform/uniphier/hsc.h
>>>
>>> --
>>> 2.18.0
>>
>>
>>
> 
> 
> 
> Thanks,
> Mauro
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
