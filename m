Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397D1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:55:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E5E20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nFyZpUbH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzCCAx3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E5E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AmapQKefO0jDICf6rlJweGmoddioZ9XBOoQgLomIERU=; b=nFyZpUbHJaOTCN
	iAOOGYCu86tnPzVM7PheELlyLxIPrX8l4xzdaiCPCyDRLGv6wA4pDyxrmXTTcg70pPu7KOVO30sFN
	KLxxfQr6bqmSAaAuybxHzlvUIAqb836ajp7VuEE9rLEBgM10lXxXQluW9UsWTtpkaqFEYXdhuvEkm
	S+PcqShmwyDVptygbaA+06I+ERvdry8kGDYZ00XxKPPwJJ/yajGkQjXrVHyO7aeQs6LsWhhe3lVQr
	K3C2ALfgLSKkpN4MBU5LqNE/VSJXVWo370AwBDUrswp92JB5UU8n3LTVMjDYKGt3XepCWLlZuu5xU
	hhMn7wfBSIUTd005KDvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1aB-0003Ie-5K; Thu, 17 Jan 2019 06:55:19 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1a8-0003II-8t
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:55:17 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so4272513plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4aXtZT6Ye8b+elrJxqIkiwN6z0WaU7g2S4YpAZ4q8Og=;
 b=VzCCAx3DfqHSBg0hq5xzdm2Frpa63SjJAJuK6gWpChapj9b7TeJKFk+so9WzVASNwO
 /iIIyplGr/Ltk+2LhKseG2LZjgKZWrNYcqLfTvP4CsclUsit1dVP6IYQYrmNAvLKfL7i
 89oI2o/ZWcKohm34ZAx8T3C44CyPY99lQu+/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4aXtZT6Ye8b+elrJxqIkiwN6z0WaU7g2S4YpAZ4q8Og=;
 b=O7V8GvT0Y2VCJl3aQUfEKenp8mRZBaQJmvv6yM9U0XEJOrvct48XfD5XjTDjpySEsA
 GkuAc3mEWjGQCrzg2/1OtNJpReZNqbZxctpgroWEuAXCqldz9FiCLlZubhm5nCBdFIYc
 zpXNMFTj+GVVSGO9EYcLsxo0/kd5U+I1aPIjRogtRC8GBvnG03OkcCckjBQypP+im7mD
 xdEKrivP/f5mQ9Xla4K3sFcTG2yImWII8KRSGas7P/F8VjLN04wCATLWch1H7FgNUUIS
 cXqJ/NPv1FexQjIBlXT/5ptD8SoDVk4xDapShZgyKXdPjiq1lL5nC1sBaiYqCd+i4q0n
 reFg==
X-Gm-Message-State: AJcUukdWWO9FYpEJskojRuhbJok4vrzp7tXiYTQmj90ywxicxB/s126H
 EM2iEarKA6U73LocHigtJRiU6g==
X-Google-Smtp-Source: ALg8bN4y267hnZ+7a0iGGnLcJfIWLnk+j3eAXUsOepG5lkFjqXUXXV8LD0W0yBAfVZgxvpe9rAH8JQ==
X-Received: by 2002:a17:902:a5c3:: with SMTP id
 t3mr13609005plq.117.1547708115340; 
 Wed, 16 Jan 2019 22:55:15 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id x19sm1656495pfk.14.2019.01.16.22.55.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:55:14 -0800 (PST)
Date: Wed, 16 Jan 2019 22:54:34 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <20190117065434.GL25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
 <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
 <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
 <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_225516_324831_9876F4C7 
X-CRM114-Status: UNSURE (   9.04  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, sibis@codeaurora.org, andy.gross@linaro.org,
 jagan@amarulasolutions.com, devicetree@vger.kernel.org, arnd@arndb.de,
 Niklas Cassel <niklas.cassel@linaro.org>, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 olof@lixom.net, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, vkoul@kernel.org, enric.balletbo@collabora.com,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 31 Dec 00:42 PST 2018, Jorge Ramirez wrote:

[..]
> I am not completely sure of what you mean. are you saying that the original
> patch is good and we should just provide another patch (not part of the
> current patch series) to remove the compatibility?
> 

You're expected to make sure that db410c continues to function on
existing DTBs, at least for a considerable amount of time.

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
