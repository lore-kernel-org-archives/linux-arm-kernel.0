Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6031C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843A221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a/KjxMDV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZoE2FPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843A221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nClYJ0HdRQW3e1NM1ikyLjqMMqPS52F7GHJVp86TEDc=; b=a/KjxMDVJpWWP+
	CujLLmYW1Mjy8Z+MCKR6YUpTQusU1xQjr8fPc+2VJdjKv5GCU5oAlGFEAX/kihmp6KreAl04IF65a
	DSj282lbBcv1E7X02y4BSfNGQAg2+qoxqgGTcrjVfUs7hk3j7rGAHu/cEdZ+BEUNQOXio3/J+a8T3
	3ogOh5+WKjm3lLUfgh45dube3CYAzTJYoR717AQ8KYpZBhH9Vta2zGU+cBrkboENKsGeKnQF+t+Zd
	veMk4Gd5Q6zJ09xW6JWsE5Q61zF54igStzRoXjdpXVEmky0TQiOjejhccKdr8ImIKiLpDS9mddKsG
	jOsfR4ELHvKYKSKmIKug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTYo-0001am-CR; Tue, 29 Jan 2019 13:36:18 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTYk-0001aL-7h
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:36:15 +0000
Received: by mail-pl1-x643.google.com with SMTP id u6so9356266plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qxi6QSw+j9dxu434FQ4Eohm/D/kYWlWKSoDoWJIFfSQ=;
 b=LZoE2FPmISmtfs+I7I9xm3NRRErollRnEo43E64ov7MSBLi2iBTAWKPHtpeDS4dOuQ
 noiK5ttdgOdd6OJFOBoPQDx5w8PLEQyhTCBLodiAPNRIxyd4achKz9PBUtrLQoH9amKm
 Vq60w2C0qg0T0LERlwpjLBbpOv7sOvs96dYkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qxi6QSw+j9dxu434FQ4Eohm/D/kYWlWKSoDoWJIFfSQ=;
 b=q4IXOj8lmpVdYL1xe4bF9jK87YpgL6mUFI7eg1daDVi4zvnHXn1yHrX/6fZ05kReZv
 tHaPRt2lVswYPU2HH/uQGkEB4zx4Q7akfyvjB1fJwURuqPXm3YYJ1Y3MQ5lPWQqzlaE1
 A1ii7Ntv+2LoN0HzfhbRRcyZ1gAecib2D6IwsqoWpGU8iJBGyDvCvGRE/lAxqqIG5yi/
 wT9/S3+gZ1L7V9KtjrHuQQ4Qcfgqq1kkDa7Haxpz1PJPCZ1V42upEtNvoKwMnCQlpTrs
 DD+iD2PRcS61uVLU2LlzNM2IYiMczI7FSC+LGZIjnZCIz994F04kYx5ACN4jbq08k3a/
 By/g==
X-Gm-Message-State: AJcUukf1VUdfBFgMD8FAHqU3u72JZmEPJK7GJiS2bZ26BBhyHLc157v9
 y7kFgLdd7GD/rHUbHGIMIjXsIQ==
X-Google-Smtp-Source: ALg8bN6gSIamczhNwlqEy6ToE+aC3NqQ2fPU2pzlYAV8lmJdPBhb3vhtAlKujyVckazpUeMoMejsqw==
X-Received: by 2002:a17:902:b40d:: with SMTP id
 x13mr26412540plr.237.1548768973317; 
 Tue, 29 Jan 2019 05:36:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id b7sm48660638pfa.52.2019.01.29.05.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 05:36:12 -0800 (PST)
Date: Tue, 29 Jan 2019 21:36:05 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
Message-ID: <20190129133605.GB16669@leoy-ThinkPad-X240s>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129132528.GA16669@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_053614_281124_AC58A8E8 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 09:25:28PM +0800, Leo Yan wrote:
> On Tue, Jan 29, 2019 at 12:44:03AM +0530, Sai Prakash Ranjan wrote:
> > Add UCI table and a helper macro for coresight CPU debug
> > module. This patch adds the UCI entries for Krypo CPUs
> > found on MSM8996 which shares the same PIDs as ETMs.
> > 
> > Without this, below error is observed on MSM8996:
> > 
> > [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> > [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> > [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> > [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> > [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> > [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> > [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> > [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> > [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> > [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> > [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> > [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> > 
> > Also add a helper macro to make adding CPU PIDs easier
> > similar to ETM4X driver.
> > 
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Looks good to me and tested on my Hikey board (though I cannot test
> for a device with UCI ID):
> 
> Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

I just now found if apply this patch onto coresight next branch [1],
it will conflict with patch 'coresight: cpu-debug: Support for CA73
CPUs' [2].  Sorry if introduce regression by this.

Hi Mathieu, could you confirm should apply this patch onto to coresight
next branch?

[...]

Thanks,
Leo Yan

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next
[2] https://git.linaro.org/kernel/coresight.git/commit/?h=next&id=14420b405d03cd160b5ace283693ce5b1cf273fa

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
