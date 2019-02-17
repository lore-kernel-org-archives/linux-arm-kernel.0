Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:25:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF942192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nX674hrH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Im2qsK9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF942192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n3Kqir4iGCRhh0OQ9wYSLuMrlfilgOtnKZO5VMHjNyE=; b=nX674hrHYkk+O25UF7YOheoj1
	V4jHyN0fBB6i2G+yG4IMR76O5Sqf0GS2an0efjfkU6xae1lVIRnQ3GD3lG74/H4PE8irF9zVs3z0p
	JiK3XLBdTWplFWs6DyJAvTeXrFIQfSsPu6tn4J+jT9DNloKBsAVUNb34wPImpWb2HQuMu0wIL0QrE
	Fm3UNM/wdQkLwvlfApP8OjlqW3cfU9H9DmY4RK7traSm1bYNQMinERjN/ZONMJjv+bMhEALmgxz69
	ElssMwrEER7Bxy+EqAxmi6iv0xvN6+tfNCpNbH8c2XVdLvhkLez6VmEJcRScQw41HBQVmL9MzmCIk
	XMBnK0XPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIhp-0007Fz-FA; Sun, 17 Feb 2019 09:25:49 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIhk-0005tN-Tg
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 09:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9D0vDs8zpCOFsGv0bn/E+pWXy79DwmOoD1oDq9oBe94=; b=Im2qsK9NAXr+fvkgTc1dcCJCvj
 soHdfpKs7XYP+4lqY0ZkEhqTVYytSsbvGhvgFaeY/DvQeHTKlIbbgWCx4brM7JhysKdX5+fb63NPq
 FPe3L/FxuWAu7PZNCyKSI2NkVye7D4m3wQogFBMd7KDLgAVslUgoTPky8b9KXFH09iL/U9NmbOKq2
 uy5e/JCu2aL9qp8Qpepbb4Iew6wq+/3ncuhHKDD9BiTarxOx+WUUMACReESya9RntTCn6bvOjFIYh
 eKikRb4sg3gXs+aMi4gFYdRJAFefCpzgSuqy8wl3gQhF6aHVUU7VHfwNhAaEmxIxCNr7LERJu7hEz
 61bibqUw==;
Received: from [185.122.190.68] (port=56265 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvIgr-0003lE-F4; Sun, 17 Feb 2019 04:24:49 -0500
Subject: Re: [PATCH v4 03/37] ARM: davinci: aintc: use irq domain
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-4-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <1146c248-5143-ae59-1b2a-4f8f4179745b@lechnology.com>
Date: Sun, 17 Feb 2019 10:24:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-4-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190217_012545_057262_6857058B 
X-CRM114-Status: UNSURE (   7.70  )
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



On 2/14/19 8:51 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to create an irq domain if we want to select SPARSE_IRQ. The
> cp-intc driver already supports it, but aintc doesn't. Use the helpers
> provided by the generic irq chip abstraction.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
