Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01266C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29AD2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tYxTUSCX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nrCYgCd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29AD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XHkabUtOaG1p8XmS5CcQ6DSuoZt5BDdzfnywB+NTpIk=; b=tYxTUSCXTBkPi4PZ5A4o16lRW
	lssdrB+Ok3ITiylF/Uv+WFPA/dIxawcq0V1FzKb7Gf8xDmXGL8hcZjDtRGQqSaH9azMh1kihEG/5W
	BeAH+PXCpa1IydfueFjHxDXYhWoMEfEZqOju1AzZnlAgcLK3MYGZoIRrH9IQK2WUAFhOVfVVDxOSJ
	Ff+SX6g3n8Ote3cxumpXz0izSaHUatm1lSBNw8xucFahl8N+tThy95oLN18LeOhZ4ncHlEcVR3nN/
	zczg6DxFGoSP9GOAw35nh3ZG9y6qYERgSEpFqNfBlHLK85NtuM4SmvT4EsMfqQpEIi/HQ2lVGj1Ip
	WzQQQvekA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqo0j-0004LG-C3; Mon, 04 Feb 2019 23:50:45 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqo0g-0004Kf-I7
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ycN9mG9m+DfDkUYyUzb31AWN0GDCtVKDc4vLDqPLUog=; b=nrCYgCd1SVQ1n+iHDBRF2zlWr7
 v0W/PEnBd47WazlzoJ1UHnvwido3vCnhdetRLCp3WJfmDLFlj4w4WHh12rEpqXZtCZNn+19RLuSEU
 xargY0Zv9v4eTo9hw0axP78WonMxlsy9zVKOU6vzuYlMmQZHl6lpNaXrEXAI5fPN14rjnnfH7KcAk
 4lzbX0OnM9h9MB+jeycbZY82qENsO4vzYiKFRcDlP8AEzp+d8nzdxt57Cfr+Ya4qiAqZN31HC/OL0
 f5icxoPmOHNRuIbqQeofQ7j8xAh1KpLq2RItEKAMBKtsoHEntJlYWmE9cCHeD4cVNtA1lkfIU2Cnn
 vGCMnW7w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:59730 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqnxB-0007cZ-LB; Mon, 04 Feb 2019 18:47:05 -0500
Subject: Re: [PATCH 20/35] ARM: davinci: cp-intc: add a wrapper around
 cp_intc_init()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-21-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <95b87881-bed5-83e9-ce67-a312e4acd4cd@lechnology.com>
Date: Mon, 4 Feb 2019 17:50:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-21-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_155042_679148_6E15183F 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're going to extend the cp_intc_init() function with a config
> structure so we can drop the intc-related fields from davinci_soc_info.
> 
> Once we do it, we won't be able to use this routine directly as the
> init_irq callback. Wrap the calls in additional helpers that don't
> take parameters and can be assigned to init_irq.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


Also, same bikeshed comment about xxx_init_irq vs. xxx_init_irqs.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
