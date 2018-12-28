Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86001C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562B520874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oL047B4m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fztLfO0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562B520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nl0Kkw2GIHOvo0Jnt8xZMLOmj8ZhkYVy8CTtTirFYU=; b=oL047B4m/+bNAf
	pdEcN91HiQcZhzCE2OTrJ5nFgUIkECoMBXrTSPhkDINmPYQchgjiS414/O0iXyTrS3OFdVIlR4qdR
	TiVRHvgICxOiZZ0a8dWexMTar8HaVkr1b5dlfi1XRWQdsXtH81efkZwdMXLa0bCMmIsCWIvMOBHTI
	tbQaRCT5v1XvaVTVt9I+yMy6Ji54JWCuN9xJ733nA0TJBx5eQqn5P58kAOjgKiWqxbu2mFfJgmQap
	Jfn65dl+hc8iXvth96tByJmEYKzJTh7v4vE6Dts5ViCvgL89BfvohA+jqxRPneOdx0CbRXKgJmE8x
	E0wP6iL30wNm4Y0PydBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcueJ-0000uC-JA; Fri, 28 Dec 2018 16:06:11 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcueA-0000hl-Ej
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:06:06 +0000
Received: by mail-ot1-x344.google.com with SMTP id 32so18936114ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ezGYfVxiwhlDU503aVqkNVICSduystT0QEAYy84RgY4=;
 b=fztLfO0DXWBYQ35Nz5OkG1AxRjZhZABkT878ZN8nmYN5+7yD/I3qbE1Pvukiqb4Ouo
 ATCsUH5/2VLHV5RwcVW7gX+OFDDORrWMtsfA/IFKVWTMOAZCnSRvHRLzOMXVC6ysavux
 lrdou3MbozxK716J+y6cye7q8fjM3mkpjsrRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ezGYfVxiwhlDU503aVqkNVICSduystT0QEAYy84RgY4=;
 b=Pbgvq5i4pIZrZifRxl7/B3NHEUTAJ6JPJ5MxR3EwcEdywCjUo7KRDTy3S6LXof/MXc
 +Mtrs0TS2PgiBXk7R5kCJdlbUDsv7/RReWhOKgwGRK82fZQV/9+caX3DR4qG5ySQ2YDJ
 m7+sfCUEekOx89f5ezMlZDFdYRUUoR/6S2Xi+oRBZuLrMrm+P6eR6ogftoKCUjBUO9DT
 +x7AnOfKwCrmUn1qnB2WB9ldZCvXKVt4M4W7RqlPjmLzy2inz1C5U5qlKjwxfUBit9cv
 Lq2iW8KrJbIGXrvlL+QtcNVlI0yLEiwaGxaIeij9AVYXAqUEsLnOLncMQobebC5YsY5j
 xgZQ==
X-Gm-Message-State: AJcUukdNrFGnzyzJGXo/Gue9TuUW4eiUrvnMbf0jUcxHiYvZylSf4yIh
 4Qo0w2o4dPgIP3/wz/DYKCenpw==
X-Google-Smtp-Source: ALg8bN7r1HuYdAqB7iSYNL/3a4xAII9XX5thrOd0eQZVkZNOPfV+ymfot699NE25EOSTCek7SiO2SA==
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr18438655otf.169.1546013150937; 
 Fri, 28 Dec 2018 08:05:50 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id a1sm18537313oto.71.2018.12.28.08.05.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:05:50 -0800 (PST)
Date: Fri, 28 Dec 2018 10:05:46 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <20181228160546.GC25288@hector.attlocal.net>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_080602_963240_0BC010C7 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham <kishon@ti.com>, David Brown <david.brown@linaro.org>,
 Matt Wagantall <mattw@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 11:13:18AM +0100, Marc Gonzalez wrote:
> The private copy of readl_poll_timeout is no longer needed.
> Use the implementation in iopoll.h instead.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Andy Gross <andy.gross@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
