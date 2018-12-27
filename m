Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD835C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:43:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADA32148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sf5L71Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADA32148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IdqYUqlMTnSLOCbfKTo5aFlzJ5ozPrRcD9Qc3Xdli9s=; b=Sf5L71Qe96WIsX
	V2CyeqQSiiTSKzzzjwoDkLGHSHK6bp53yehCOcxdc0+Lz+18vI+CBZ9bbvkhtUgTYU6Y70Y8w/h2Q
	1w1bRCZLepegp9Ym8KDrksyIKdEoyeR1ywoEFSs99ZxQXzux+ansIqWTkeAsF6RlxXVn7ji/u8NKl
	SWIWg89uLjgpg5DC6onMb2rouIBO3bg6RpS+vmGYqMykEcS7PrUw1jYn50j46c2FeVsOFVmT1Yktm
	mdP//lIAJocLMVnfb8ORP0KFQawkP8/ck9AxZsTWlg270kWS3/+nxmhbn7XijIfcRRp+i7p6zSYgx
	gn3wGuRAAv8ZQnUDmpFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdQu-0007Py-3z; Thu, 27 Dec 2018 21:43:12 +0000
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcdQd-0007P3-65
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 21:42:57 +0000
Received: by mail-it1-f195.google.com with SMTP id p197so25213672itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 13:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YDRlM9iTAR6SXAB2Mi5oMWRbavZlWKteJrKfbkVf7wo=;
 b=WeEzPUIwaT1pbpBpDKsUiD/4xTI2a+M8Gti3C9wVl50YbjNJNzWt4SyGelgsIHzk4S
 p4Q1RcJQ59oyhLl8AsvzjqkMUlKqYnI3uCYHhuQj/mhSu++j6gc5xcEZTcSCzUprsYQd
 U3ioErHIxPpxCV2YBoQKAJKmi2AJ7fCasq7EUCheykfCxB3kQ7GAkrmYlp7ETDDc266G
 wz6+mH2JSnlKJ4N4M6BmdfnA1TspoOS9K0+ddcDqHCQvnZrBbT69HrNOXA2gAxCus1Yk
 P3TEqsXrPJdGGVaASViT6nkBtwL3eJbXS40lsy5nRXT8n3PZBnYw8ZvFCJICUHeFuRQd
 ZqjA==
X-Gm-Message-State: AA+aEWY4xhbh90LvWWFOfJJ/BR7i7SsB8SHl9FLAvomKJ7cDcWSfk2qp
 H+A8OZeet+Wz8Dzkoim41A==
X-Google-Smtp-Source: AFSGD/X/qzipHgYiQWM4fEA9sA4fF3E030kIh8jdbhjOKJl8OEtanbb6dvJvaB0fEbXK2SH/6N8bbw==
X-Received: by 2002:a24:1e06:: with SMTP id 6mr16523420itt.46.1545946962511;
 Thu, 27 Dec 2018 13:42:42 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id b25sm14659130itd.37.2018.12.27.13.42.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 13:42:41 -0800 (PST)
Date: Thu, 27 Dec 2018 15:42:41 -0600
From: Rob Herring <robh@kernel.org>
To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 2/6] Documentation: dt: socfpga: Add S10 System Manager
 binding
Message-ID: <20181227214241.GA25008@bogus>
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
 <1545351802-4354-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545351802-4354-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_134255_225968_C956674F 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: mark.rutland@arm.com, joabreu@synopsys.com,
 Thor Thayer <thor.thayer@linux.intel.com>, alexandre.torgue@st.com,
 arnd@arndb.de, devicetree@vger.kernel.org, catalin.marinas@arm.com,
 olof@lixom.net, will.deacon@arm.com, linux@armlinux.org.uk,
 bjorn.andersson@linaro.org, dinguyen@kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, mchehab+samsung@kernel.org, peppe.cavallaro@st.com,
 lee.jones@linaro.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 20 Dec 2018 18:23:18 -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the device tree bindings for the Stratix10 System Manager.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  New compatible string and usage for Stratix10
> ---
>  .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
