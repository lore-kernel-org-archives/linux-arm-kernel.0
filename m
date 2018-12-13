Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E83FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B15C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dj2N3zxA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUc7lTCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HKNWH8XySOib8io652SojTB0VqUKUpQEoX+5lVZjKaE=; b=Dj2N3zxAxcXAah
	OxNzTvHhwtmAnQC0XDDdIyVD1W3+gUDdBOqCLsK0zjcgQ30j2DUYC2TMncfgibA7DDs/KxF7unuG4
	vLrwdVc15UJstsst7kMtyK/YEAu9tzPsIEFL3YonwwVmXaimgxKxAegaG93OXgsu4Nnony6XrGBLo
	k+g6PkWEbfn+XF7g0kSdsXxXqgPz0iaIBAPmWq8u7mc47Up7Y2uYeGPMBwNd1gq3NVXQZrbrLwYse
	aft/5rOCFHH2FwwSVF9vDQQYeX3BExjcX0g1cFjmWMNWsS65Z/w9vMtgYCT5OpSc2uVcOKokVMpZk
	fbGaHri2lR7WqZgawNvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOSP-0007CC-8c; Thu, 13 Dec 2018 10:43:05 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOSL-0007Aq-Mg
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:43:03 +0000
Received: by mail-pf1-x441.google.com with SMTP id u6so910421pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qa0Qjrm5LRvT7JMQPccKOwXY+mphMRaaLgV5iYnYGOk=;
 b=eUc7lTCrvRz4j6QHumB8SgmYyIPb1ROiRZ0JfMvoFTpRuznXp/ECQCbvn4PypAJG20
 cN1zK9gEvj55sH8QICH6QAm5pgufXxVQvc+KkDDhou5CBRMSGB8hCYYwjkIJLo2xyXmX
 vmGonnFCxip5mbZs+sRUYoy1XWVNscsNldA1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qa0Qjrm5LRvT7JMQPccKOwXY+mphMRaaLgV5iYnYGOk=;
 b=UE9Oab2TctbukFJ9DHbHHiIVaZW37GBxn82FWLv3QJC/cs67ZrBiwMnqtarebv0wWs
 iU3JRGXIz1qzaHxttJwd8tivtZXinJ5ga8o9q8YKq/6sjcve/ZLn8W64ifTWsKbAqRiQ
 JOP8MuSJ+igVSoZivRVFC6p9ymWcVmcr55UML0raZ0L1YIN1VmNKBGyaRq/Qry9AXjeD
 VbSpckrUyhD0oa2ZXvuTYDpvsvYCEUG0/HKoI2ylKbMCP0AwEsMZv6dk6suCfj50BEZu
 LHPU3MY1hjhdlkrB8qF5sfQJF5LKygRflr0BK3J0S3QIwJm88xrdsDJB7SM4bhE+rGVS
 y3+Q==
X-Gm-Message-State: AA+aEWYyDofKjG57Url0OsNfKBb45wnrl4e5FEKVN94as5ZqX4AyK70a
 1jOPzUUrQWyCS2SBr8VsIyjhWQ==
X-Google-Smtp-Source: AFSGD/XfmN1+4I2XvAOUmv5fUZh3KEujjguaALXU25J5juJy9rYPFfvjTX5VbDQNBJ6D6dHnTqQRrQ==
X-Received: by 2002:a63:d208:: with SMTP id a8mr21069119pgg.77.1544697770477; 
 Thu, 13 Dec 2018 02:42:50 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id n66sm2581150pfk.19.2018.12.13.02.42.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 02:42:49 -0800 (PST)
Date: Thu, 13 Dec 2018 16:12:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nick Fan <nick.fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181213104247.kosguuoukoi645pf@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
 <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
 <1544697412.6417.13.camel@mtksdaap41>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544697412.6417.13.camel@mtksdaap41>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_024301_737612_44532E99 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Nishanth Menon <nm@ti.com>, Chiawen.Lee@mediatek.com,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 erin.lo@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13-12-18, 18:36, Nick Fan wrote:
> This new API is suitable for the users that required to access for
> multiple regulators. And I am one of users who uses this API, but I am
> not able to upstream the GPU kernel driver which uses the new API.

Look at it from mainline's perspective..

- We don't (can't) care about non-mainline stuff. Actually we do care,
  but we can't add code to mainline which is not going to be used by
  any mainline user.

- I am fine with introducing the new API, but that will happen only if
  there is going to be a mainline user as well.

- As you are going to maintain your GPU driver offline, you can
  maintain this patch too.

Sorry Nick.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
