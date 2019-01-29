Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313AAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1504214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BGgA4g7+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ms8BcO4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1504214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NGaOZiOX8BEGvF7JTNIa7gjaXduH5pfCN0CqKpBwufw=; b=BGgA4g7+6qypCpmE+z9S9wcRq
	7vlwy7nA1fU/+u151iV1tzUmThOAk4NkPEk/tXIXGRhSU7NszZcSV876URnl1Xwe99kPuSJmi2j0b
	WedVI6xjMndLy8yFwpPZ8YaRxxPPCTsyYed2a77U4CRs8hxRdesGRbyPZG7G87IurgTEbKvy038Wq
	Mr9vUwq+XH+aUp5c9Xzn5eJpiy6RQHt+XY7LUUz2/EKSwZbBzoUShy34FznVSUZ8spsmjgnVskNio
	lYoUQKsHNZDHVLCckLhXrtuThxExjJzGJx9U9SBeVpoW4+Pqk9lIzkAjNwdjntswVhoonQZPxvMbd
	+L7ZZSVXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXTW-00021U-O0; Tue, 29 Jan 2019 17:47:06 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXTT-000212-DU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:47:04 +0000
Received: by mail-wm1-x343.google.com with SMTP id p6so18730995wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1gWce5CbmYXKarsX6SeXGbpxwPIxG1SaXtuOaM+Oryw=;
 b=Ms8BcO4PWYLhIwApuVkTUibP4vFM3LQGLNZASRUJF+TnuVZpOk0yD8Ytu/9bKguuGI
 YLim6JMTWv8qVzdGinnCyuht6xiSC4/kJT8C9eSxn8BBuJpYfNFFcUlzoe5LO9kFy6Zc
 2eiPq0rnrOvCwLdiHQ9xat5AjiW6d7RiEJRvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1gWce5CbmYXKarsX6SeXGbpxwPIxG1SaXtuOaM+Oryw=;
 b=g3nc25YLSjRGhYIzyA0EzVUOhTKgYGDs8GHwLCmeiVATm/1mnkzXrj8Eu6eSUDVhnu
 hJY743/fG449ulcrmLWNNQ/dhqqalYt29yvpxjnBQmxCaKf5CoOX8JFnTqdrxhgjswsw
 9FSr74ZRKG6NgNzcQxhC30k+zJFVyg/IYDhKPXQEqGO3u092aEmsvWPZTWeApm7flw0C
 GfTcyoPzMRU2MGnzo96o0iHS0W6p2+fUP6Y8uF3ygo9e0625gRNBubBlVnOvuwMJj8vi
 c2jcmcEdC7o70griKHM70N/UFSkG10ef9qrdg5woE773+9gt4+OBd+JGHXBg3Yk6ZQX5
 pGeQ==
X-Gm-Message-State: AJcUukfmQXmsXmwFVGOYIHV+bqFWC4aQG+fkbSG0OK7EborPeScUGQBn
 jxMZhM/8pYhWU+aQ7xnejFKuW42oO+g=
X-Google-Smtp-Source: ALg8bN737/X0S2IRBrF1hIsVS7Yab7q/JmjiPlhttwwJ41lv39nhC8lG2hQpVoqi6P2c42qUN0fzcQ==
X-Received: by 2002:a1c:1f83:: with SMTP id f125mr21515379wmf.56.1548784020474; 
 Tue, 29 Jan 2019 09:47:00 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id p10sm7439148wmd.14.2019.01.29.09.46.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 09:46:59 -0800 (PST)
Subject: Re: [PATCH 4/6] arm64: dts: Add Adreno GPU and GPU smmu definitions
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
 <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
 <20190129160426.GA18874@jcrouse1-lnx.qualcomm.com>
 <20190129164332.GB18874@jcrouse1-lnx.qualcomm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d4954b0a-f8e8-b985-ca59-f93a8a44e2b2@linaro.org>
Date: Tue, 29 Jan 2019 17:46:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129164332.GB18874@jcrouse1-lnx.qualcomm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_094703_457361_B0F70D85 
X-CRM114-Status: GOOD (  10.80  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Jordan,

On 29/01/2019 16:43, Jordan Crouse wrote:
> Ugh, I just found them sitting unsent in a dusty git branch. I can either send
> them as incremental patches on top of yours to be squashed later or I can
> refactor this patch and send it out again, whatever is easiest for you.

If you can refactor this patch and send it out, that would be great!

thanks,
srini

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
