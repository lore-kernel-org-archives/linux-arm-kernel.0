Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:42:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1319218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqsEwRqi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr2bEjVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1319218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nnikFje/oEd1heGcgU6seE5Q8YXHX1gYtV1qwyE0z4g=; b=aqsEwRqiurQjVm
	9MHtfxTUXHeajja5zQmq4UJdXXXt4qTwBVWsZFfaOlo0hbz5YghttEX9xEmir85umbXRAdrrzhXKQ
	BZTFfeZ6zrCnxKeamRC8jsw5O7rw/GxthY0wzQB8W6DLzjjqvABQWwyJEam7wU3syKRuaosGiMBZp
	iakgpE3CGKdAeCW0GJZYFIKtYJZ8QjiP2jfK881fp7ZoKrIQHrwbDOQfOrCshRdqYWANweFI+PXDK
	8twlRLBgBnMI8OPJ+IypZEbzC+yF2XMgtrQyxyDYGYjO2tmvbDI7dO4XaoulkPa3VUaKAYMp5s80j
	avNTQQXeVXClNRnchT1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKJg-0004po-9D; Tue, 18 Dec 2018 18:42:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKJU-0004fA-6D
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:41:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9604218A4;
 Tue, 18 Dec 2018 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545158511;
 bh=YQ/s3ma261q9/0xAv+9faL1c/s4IV+pu72EQbJfoCIE=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=hr2bEjVIdtsNSuBL8VEHLSp4awXAULZnWQ6kgp3+jIhxUG4IDnI7xm1JnjiFYCZZc
 A+lIzHGMJ+u+bH8h1dWHfraVbPtrQf8TwX/V4b24ikN9cf+1CTdVH0aaBe6MKRCX3t
 wYXzpWigFdbtdeQCLRx/u8QRuuLpJeACv4LBojcc=
MIME-Version: 1.0
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-9-josephl@nvidia.com>
Message-ID: <154515851110.238328.11710971689713709806@swboyd.mtv.corp.google.com>
In-Reply-To: <20181218091232.23532-9-josephl@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V3 08/20] clk: tegra: dfll: round down voltages based on
 alignment
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 10:41:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_104152_242855_AEC8BB43 
X-CRM114-Status: UNSURE (   6.42  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2018-12-18 01:12:20)
> When generating the OPP table, the voltages are round down with the
> alignment from the regulator. The alignment should be applied for
> voltages look up as well.
> 
> Based on the work of Penny Chiu <pchiu@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
