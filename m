Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296B820873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pXcWAUL1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx7GtVQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296B820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8pFwxFqHbTyD4CFiunCFpV2HXXVO9bEoUQT3KVgNENI=; b=pXcWAUL1Oghkd9
	0Xzqju/4LVgALosXT8MGdiWCajcY866xJ8U3H31xJYY7PrfBUrQUA+29McvdYqkf7Yx8rRas7IHKV
	HPmxexn5l31c95/mqcISqRdcQfhmpbNyO15Juaq1MwZgvWSpNFav5JznyOZdO88WRCXlKjfKr9HUm
	xXZuy4zxK4bCJxx2G1MAnI78P5S1f/hL3dUAmnBByB0PcI5KbVb0fWMdTiiuBNwH9YQ5eZxCkh2PW
	x1mC/vxv3sMMz/gkV75v95nkBlmkrSs9BXQ+qbp/v0F4pInZdHENpDXoFjDBwLXg8LmSAPZ4naWpg
	eur8qqjeYJpLHGJPFr2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4Gj-0007fx-3p; Mon, 14 Jan 2019 15:35:17 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4Gg-0007fX-D8
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:35:15 +0000
Received: by mail-pl1-x643.google.com with SMTP id w4so10302819plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zv//+Tp0QCDUNk5kZM/nH1I5nH8DrgiobvosD6lRqE0=;
 b=Jx7GtVQgEtZ+9z59B6ny0qeLFx4O2vSlGJwzrpZvxfjdk4JW2BacKzOWdLVvljFnGz
 PkhMBguHPazdl+IBe8I/Wa+4KG47mKE5h11hrYuY1s4dtl0MrwkZJaJwiZLT7YgZV6PP
 HXOv4IZyX7siAHJb5MbVh9tmNDtVuHgWYhY48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zv//+Tp0QCDUNk5kZM/nH1I5nH8DrgiobvosD6lRqE0=;
 b=YFIB8vjlx6GMEWPkQtz/tNvpMJsXwOy2ZqwsHk9yEW2mY/0k6ftHz97OxP2/m80MLM
 M0lwlagwWq2hV09gK2si5fmowEh1c+9gB5TxfD/jOEsK2WYLiJk1kfCOWgos5sjM/fG8
 AUQh0zO1JueGdkguVSTJ6bcxcIE/+c6r0JtchAhzYMtbnaZlSougPD527R1sL6sHWmch
 SbWjLBOaYum7iqLyW69gbhf+H1Q0HlcCH4ZWikyFT+2qsfEsgLRA86PYUgz0JeN6SB1M
 VNXRw69FuDlb3A9HuJgeCDoNSXA/+Fxn4stTc+k37bUPQwCTlqJU6rzplVOho42Hn94e
 2AZg==
X-Gm-Message-State: AJcUukfigk+5af3i7X23MqdBpkf2P6lWoC+J/MMAaBvXKENtHDbraXmL
 l+tk6IIHnyoYMj11MYJ2/v1dO+hY1AgWTg==
X-Google-Smtp-Source: ALg8bN6p1W/cKb94//sk7nCpmvlfkO65K9GW0nmiT0qOw473oCKUNGk3rBn9Z1ky5F0CplZvGqyJDQ==
X-Received: by 2002:a17:902:24e7:: with SMTP id
 l36mr26069590plg.61.1547480113152; 
 Mon, 14 Jan 2019 07:35:13 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id k186sm958664pge.13.2019.01.14.07.35.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 07:35:12 -0800 (PST)
Date: Mon, 14 Jan 2019 08:35:09 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190114153509.GA29374@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
 <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_073514_440583_06B84482 
X-CRM114-Status: GOOD (  15.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 06:21:00PM +0530, saiprakash.ranjan@codeaurora.org wrote:
> Hi Mathieu,
> 
> > > +
> > > +	etm@7040000 {
> > > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > > +		arm,primecell-periphid = <0x000bb95d>;
> > 
> > I'm a little curious as to why you need to bypass the normal AMBA bus
> > discovery
> > method by forcing the peripheral ID.  Tracers don't show up the way
> > other
> > coresight devices do at boot time?
> > 
> 
> Yes on some Qcom SoC's like SDM845 and also on some previous ones, for
> ETM(only) amba bus discovery method fails because of wrong pid read from the
> registers. So we have to force this primecell peripheral ids to probe etm.

Ok, if that is the case please add a comment to explain the situation.
Otherwise someone will assuredly ask again in the future.

Mathieu


> 
> - Sai
> 
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
