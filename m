Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06803C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB60D21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMJMDiv/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/QCJ6a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB60D21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X0GbJo2JCnsF+kgoF1Cj9vM92F0orcu4xK69wvJ2CEg=; b=SMJMDiv/WkCw3u
	dcY6uv0cX2XY9eVdZcP3gslE2QvyKgk3EnOmvy5WQh3KD1e8nsSHbFO0gEj9VGxD21qDk3cswhpkF
	wYj6UtfsdL9k52S/cpnqfv0+zvCGXX94REny5Q7xajWP7NJ8qYMikU/Bt4jy2/aLNufboNVWuj+lz
	5NzjhiiU9bly3ljlwXb/XPOuDTXTrNEAZ9/JnBLTPEUtBq4G9Eo+CHenLKr5DnJZEQXZJkUwxOXLQ
	aNyViAIlxGvCG6xL4D/oL0+ka3Mq352VZGMDbP3tcZPaIWbM3oQmriAB1E/MNiMFBtXvs2mYvzArO
	ImXRZdxcQSkY+bNYAFGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJhB-0004cY-To; Tue, 18 Dec 2018 18:02:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJh7-0004bo-RW
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:02:16 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72E3E21871;
 Tue, 18 Dec 2018 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545156123;
 bh=pgqOwBC6wwWybxYwA7K/ObG+s7/HrsjRkVj2wZUBDSU=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=O/QCJ6a+nC/PPb8btixrlQJhtzGt9FBi/l+tgZlA5sumoE54E5dM6Y9eNt3TS7h4H
 sseQUntAcuF0oILmMTSnbvaOWIkaq3TuDJGOpNl0McfqBHi9O3I2mT+TtKTg/2Fe56
 fT3l7pAMfrXvnEQEMGNg8efqwEY+0TECN0HzYEy4=
MIME-Version: 1.0
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-3-josephl@nvidia.com>
Message-ID: <154515612274.238328.18319743517874337135@swboyd.mtv.corp.google.com>
In-Reply-To: <20181218091232.23532-3-josephl@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V3 02/20] dt-bindings: clock: tegra124-dfll: add Tegra210
 support
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 10:02:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_100213_962487_8EE41FF0 
X-CRM114-Status: UNSURE (   5.58  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2018-12-18 01:12:14)
> Add Tegra210 support for DFLL clock.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
