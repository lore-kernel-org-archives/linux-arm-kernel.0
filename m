Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C8C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:41:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153312086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g4x5jsQb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cn0cGZcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153312086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AW00xXkExbvyUw6UVNlqzqS2kS8cGbaaJbIUI8pkhRg=; b=g4x5jsQbtsPSiC
	W6PQSzT5WMgxZiRMLuwymyFgsgbd9EGq8sJCXUZluJicSd9miG+6DWiE0GazgwUsKsX4A9su431+/
	TvvmLKQxipDhPzzPj+uC/HjyJukHANRKV+I8dvBV0ZslEfKc07cgZtZlEZK38z3v780Vp2DNeBS8y
	GuMXe+9DcgwLflnADr5vEJwvRTKWpL4CkcAjvcPUMYAgaB3/AcSdq2QMUO46M4uxGqWCz5GfkaRsf
	7PWrn/IJsB1vXiX9dNwJPMMmkVEAuCI8+l7ADuiabx5g4KQGcgrhronkJ00Tb28fbDihXonNeke1F
	4Kz8oeOOEwMGNLEYPRVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXfHm-0002Ux-7n; Fri, 14 Dec 2018 04:41:14 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXfHj-0002Jn-0s
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 04:41:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so2127422pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 20:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=I1UT7I+joPHVgaCiRLt/7F8E50Y/ypnOs9qeek96gHk=;
 b=Cn0cGZcC11EueAhHB44AehIjdjuEvQ2iUPdv5b9hfZ9sszf8u1gQUZiPW7BwRPUt1T
 jFWZFVY2oU/zUa4DCitkvmocQ/Hh4fa7/5jQpsaCLhe9oEPiRCSu5lU+bSdJX49Z+5q0
 k+n+oR+4unqV8VQnJmIvYKEitWR1CgO4vXFFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=I1UT7I+joPHVgaCiRLt/7F8E50Y/ypnOs9qeek96gHk=;
 b=o727oYDj9jffdIgb3bzVNxVNNB/pWHvZo+038ujU6gAapb95Ddjor1h5HtR5Xk12iu
 XlLL6ESvzSu+jKjyMUNf738egiiGJM/B0+T4Ue+4HyG+2MwaZJXRMPZFOlWoQqeQOni9
 0yyk96f4S7Bt1C+ewt6HRtF9vkdTthzHNa/aWE1bgKkU4vfqmDJdDlm4DhoT855O7NzQ
 KDcqQbPS7ai57CASPBMwcnRPebi0raRSjdd5U08gZcAR9qw/o5k2LcAyudQ9cRHOFuDh
 h8j+ncM8ZemjpM5pSprevZ2d+65KP28bPnAMxuHoutxki8SZWtsv0RFPyfr/QWRH5q6o
 Znlw==
X-Gm-Message-State: AA+aEWZUMk3icGNJAV/O9Ot/mes0yGqsSs+0qXAusdu/kiUYvJh4VOAF
 klAqi6HGZ5fR12IXrzSwL2Q29A==
X-Google-Smtp-Source: AFSGD/Wo1tZ0H4mCbCSlfil3iV4oU4v8/jxTUKfCzOa52didwfus7lhB12cVkSveRowRb4gQgroQ7A==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr1537181pls.5.1544762460346; 
 Thu, 13 Dec 2018 20:41:00 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id g15sm14141893pfj.131.2018.12.13.20.40.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 20:40:59 -0800 (PST)
Date: Fri, 14 Dec 2018 10:10:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
Message-ID: <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212211848.26768-3-jcrouse@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_204111_068608_481013F8 
X-CRM114-Status: UNSURE (   8.29  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, vireshk@kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12-12-18, 14:18, Jordan Crouse wrote:
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2-qcom-level";

I think you need to mention "operating-points-v2" as well here.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
