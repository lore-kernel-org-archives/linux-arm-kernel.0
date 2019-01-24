Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:19:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422EE218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TlbXJCBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422EE218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gzBDVVKzAD+Oc8ef8OGD3KdxqgiYA/qGecH2CtCOrBg=; b=TlbXJCBqiAJ1L5
	dfemYeSLGlKEeTun5jEZuk7pT9iipOhi/ZyELTH07n+d+lTH3vIjuVe5Uy5yHHhyzh1WB2qxOp8Wr
	PconYhqYZ1cAYKBRhBJUvu75+bA2IJUNf2hNBhxP22Z6BaXN4ASWejsaZHlU0AElwOCQLnJ0T4TmL
	6y3nUkuDTqFi9UCSjqyNHMJ5CQEaeyufQ7hGAngUgBYNyQLQT79jgtmS9dqhdiSOdyJh2/7ksR1d5
	pjZJE3JoZRFUHDSTDBlfHNYTo65Y05zCxthXR5hgaSonYCGUipD5mR9tUqKEVIvYRCPDk6SDgVCMW
	sgclIooHnoiVhLpLslyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhjH-0006eZ-5h; Thu, 24 Jan 2019 16:19:47 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhjC-0006e2-Vk
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:19:44 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id A564680C3;
 Thu, 24 Jan 2019 16:19:50 +0000 (UTC)
Date: Thu, 24 Jan 2019 08:19:39 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH -next] ARM: dts: am437x: replace linux,wakeup with
 wakeup-source property
Message-ID: <20190124161939.GP5720@atomide.com>
References: <20181221181220.6877-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221181220.6877-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_081943_064339_4A9915B3 
X-CRM114-Status: UNSURE (   6.98  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Sudeep Holla <sudeep.holla@arm.com> [181221 10:12]:
> Most of the legacy "linux,wakeup" boolean property is already replaced
> with "wakeup-source". However few occurrences of old property has popped
> up again, probably from the remnants in downstream trees.
> 
> Replace the legacy properties with the unified "wakeup-source" property
> introduced in the commit aeda5003d0b9 ("Input: matrix_keypad - change
> name of wakeup property to "wakeup-source"")

Sorry for the delays, applying into omap-for-v5.1/dt finally.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
