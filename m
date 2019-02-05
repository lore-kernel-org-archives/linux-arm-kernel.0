Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E8C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788DE2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZYw6vGPY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7trYXo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788DE2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=quq8DdQJjBWFlHV4X5T1ptlScM7f6xr/bWUE4bV0SSk=; b=ZYw6vGPYsBKU9J
	vZL7oErAuG55bmlTRGuLFHjhL4flC1p1QRtV7My6F0Jlc8mg6Wm++OGG+1duYa6AaOy3rk55HqDFW
	8UErMZ22IPb7UUpfXu/cCmWSd482W/EPVfqcA5G6IChCDgW5GyF5hywpG/F/utLMd9sA3A5XGqpmS
	rKV2z9nwEOg7lX/JLFUMvSI8iGUxwxNRGzW0twbdnHr7Hr69shapRTAr9iNrngTH7sl48tzDTat4r
	b5LZRJMB1JeIexu01oaL5+xp34cpItjhgYMe0kM7c4oczwSsdDyW/BEKv5PQjwpWm8vVomDAtU0Nl
	SJi8SLuE2/8X0ReCKuYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9Bl-0007vM-Fe; Tue, 05 Feb 2019 22:27:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9Bh-0007v0-TS
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:27:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F3872077B;
 Tue,  5 Feb 2019 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549405649;
 bh=8pTPD9Y7PLE2SKcD8m2OIZ9TL0E1jh9uzSx89Fr8NPg=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=C7trYXo8SqOksyIbOo4OCWWXok26yn64qaZ7Bv25w6DzjNIAI9RKbbYQ7TVDHjZt/
 0PJnUqaejLnrrGQXxopU8x7h3AnyXK1mP6mPC+Dp/CmSD0kXPlurlqo7q73poNszHa
 SCNbh5MD/KA8dL5bBs2uCfZQp7FS6wpTj1jf1MOk=
MIME-Version: 1.0
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940564864.169292.12172524763781613917@swboyd.mtv.corp.google.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
 <20190128075442.GA18124@ulmo>
 <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
User-Agent: alot/0.8
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joseph Lo <josephl@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
Date: Tue, 05 Feb 2019 14:27:28 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_142729_972275_FD2D0EDD 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2019-01-31 18:49:38)
> On 1/28/19 3:54 PM, Thierry Reding wrote:
> > 
> > the same applies for clk patches. Stephen's acked all of them and I
> > think all of the series is good to go. How about if I pick up these
> > up in the Tegra tree and let this all cook in linux-next for a week
> > or so and then send you a pull request with these? Stephen already
> > picked up a couple of fixes for clk/tegra, but I don't think any of
> > those would conflict with this series.
> > 
> > All of that said, Joseph confirmed that there are no dependencies
> > between these subsystem subseries, so if you'd prefer to pick up the
> > patches into your respective trees, I have no objections to that.
> > 
> > Thierry
> > 
> 
> Hi Rafael, Stephen,
> 
> Gental ping. Please let Thierry know if the cpufreq and DFLL clock 
> related changes can go through Tegra tree.
> 
> I know Rafael did say [1] it's okay to go through Tegra tree in earlier 
> comment.
> 

I am happy with the plan. Thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
