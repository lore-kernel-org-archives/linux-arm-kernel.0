Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:29:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF5D21B25
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sqp905pO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF5D21B25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aMbEzjgxWxZiVtkIwPCt2Xn71+2THWirNft8eb+rE0E=; b=sqp905pO739f7+MUMaJQtBRpx
	ynZ2rlUYdbwCADpZGtB204UyBuL9/LPAqPOlfMBVi2SJNvFMhC6Xq/fy83d4ibA7C2wp57FniWxGN
	mItMVGk66HS5/ksMMtSo5nf+mxLQzQs63hbsgaryVCXATA6fcMmMpEfWsVkLMYBWTlH1S7P7Z5eZS
	5eo5YH28TJwDoezRpSTt6GB0TqNLtXK3pPolYrERSoo4MncXbCe+uybSUNaPApTUwxJlBJw3hF0zm
	4td+wdfLa6lFiV9D5lrUMnhrPgX/Ib4/o439rjU8HkdIMJMduWDNrWr1YHLnr8EcFwjnqVsFM/63a
	bL9NILQWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtGKo-0008MG-Pi; Mon, 11 Feb 2019 18:29:38 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtGKl-0008Ls-H5
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:29:36 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2019 10:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; d="scan'208";a="274205804"
Received: from unknown (HELO [10.7.153.148]) ([10.7.153.148])
 by orsmga004.jf.intel.com with ESMTP; 11 Feb 2019 10:29:33 -0800
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To: Wolfram Sang <wsa@the-dreams.de>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
 <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
 <20190211181658.u55ggc2xi4nsxxvy@katana>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <f444a8eb-06cf-4119-da9d-aab1029830e6@linux.intel.com>
Date: Mon, 11 Feb 2019 10:29:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190211181658.u55ggc2xi4nsxxvy@katana>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_102935_617032_BC7591C6 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/11/2019 10:16 AM, Wolfram Sang wrote:
> 
>> Can you please apply above changes on top of this patch? Or I can submit
>> v2 with it.
> 
> Please send v2.
> 

Okay, I'll send v2.

Thanks,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
