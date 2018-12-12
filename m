Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B859BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8369120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqksuHDI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="09ynGEqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8369120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RxYnlGVi7VjTybWdQXZn15l4UAb0GWwK5hVzpRch0dQ=; b=lqksuHDICYt2ED
	jvstPOhDWZBrvufSBWHadjXOW/ds4fkSVV2EJk0YftDlSt3UyG9xiEUxszg5PHNoeraivtE4o3F3Z
	Bm6mq0UloltcKy5ddV+YRsS1GmpQQHbeAD5UQRumqCcA9OwKWZqxUGVpIl0xFkNQ0WevlB8d7Qr21
	N9HzJ1gr1iSCxeArptquXYVC1OZbUkWfVtPErXRPTYzjumO8KuoEN8S2TEQgqaLjVlDi5wjMavUwL
	CoXL8MRF9HXD+oDaImGSUhhcYa8D/Ab3s1x/FenKWdEQeMsANWu7N0Ce4lmV/wsmEMUNDtot98kgp
	6XSfdabRxtYAE9mcraQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBr0-0006qK-Dh; Wed, 12 Dec 2018 21:15:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqP-00050X-9Z
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so17583836ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uBU0ZtbX+J8Oz0EhyXuCXoVaGe3O8alSybyV+RtW7io=;
 b=09ynGEqh4NrTAb9cyVM/T2cdq0VTebI0os3rid0agB21XHaYJvpe//1xdeNWy0ELPP
 Any+ioZYGOt4ymLHhAgFjB9GgRZI24inS+WyZC9s8oH9PHHFHeEdAEZNuWNE0ELa/3XR
 AtKZ9cHzdfXsuRjjEv7kVFkQqR7/vkAQMwbqlxoPaqNBSkA53W9wkt4QPtzLRqKbSxHK
 22n2zTD6CUbGAmxth0KujHZPEggUPy+hrFApKK8eaQMATq3f0xmnEWr4BgZS/DR8DF9x
 sU6U27y6xHLNeFctlVi43QFpLEuNG3QM66NmXj/Jx70JuGKed/GjU8erI6cXku0EV1Ni
 9Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uBU0ZtbX+J8Oz0EhyXuCXoVaGe3O8alSybyV+RtW7io=;
 b=uAU4R1OUjLW3V0tjGhhcSIwP6haXrGzGGoTDvEG4gdsmsa6Y6LyLT0II4s1gYNCdtD
 4KsUFO+G33tM0WZ57Z6Ad9gnWZDYG/Owl/T6DkRBdFomn3PJaaNnovsVid71Zsuh9wsL
 yJXAiQoYZC/iJ0jGJu27oSNh5C+5ZTXRxfD8zXdCM8DfaEuC9U8iOwSlamp6mxlQ6GRg
 D0E2XmdMA4Y3+yV8mkrmtJ+XhjWwnBcoc0X57srO5PrWDTFuS2MZAGVl6HTJwFgVcpL/
 ROtxKviZ+UBDoNyjqJTiy8kaxz2TbjEXFyuOumwYkpe2Axqp/frg7ZF3nmK0KcDb+GFF
 rslQ==
X-Gm-Message-State: AA+aEWaQf0pd0LULsDLZ0LmidLMI4NNWfVcm6IkSBwCF5vgjxYLMJ5GH
 tugKpcvmGdSameCaNyHpNCag/A==
X-Google-Smtp-Source: AFSGD/VCn8YCZjXpoP+vYeusq/p/5yr9z3Y9848D3XWqLk6f43NaKS4YbpwfnomiH1WIF9k8zWogfA==
X-Received: by 2002:a05:651c:14e:: with SMTP id
 c14mr6742766ljd.20.1544649289290; 
 Wed, 12 Dec 2018 13:14:49 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b69sm3474519lfl.28.2018.12.12.13.14.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:48 -0800 (PST)
Date: Wed, 12 Dec 2018 12:51:06 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.21 - Part 2
Message-ID: <20181212205106.op7elifexbn4llpt@localhost>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131501_436823_F608E1DD 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm@kernel.org, Kevin Hilman <khilman@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 11:13:13PM -0600, Andy Gross wrote:
> The following changes since commit 70827d9f6bc4f481fafe790dd6654ba568526768:
> 
>   arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21-2
> 
> for you to fetch changes up to 1504b91c819359b574b55c269c850352260b8d19:
> 
>   arm64: dts: msm8996: Use dwc3-qcom glue driver for USB (2018-12-07 14:10:56 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.21 Part 2
> 
> * Switch to use dwc3-qcom glue driver on MSM8996
> * Fix issue with xo clk name on MSM8998
> * Add cooling maps on MSM8916
> * Add UART nodes on SDM845
> * Add camera subsystem support on MSM8996 and MSM8916

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
