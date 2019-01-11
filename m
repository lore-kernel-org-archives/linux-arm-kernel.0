Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF286218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OT2gS2Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF286218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HM/tRHvtoRGeoNHPq6O3m8Ce9rrdX5cl2/ijoo07tFg=; b=OT2gS2Qi8XCU/e
	mO6hp5Tk79Ptusua6RTZpKGj6d2OS42hD8JbpCXRRr429NhWUsYOwx+YII7BUCkm8dRPKAT9BNpDg
	VQV3UJPGN/3GqakTihsZwgnjJnJtq5eD1eXQD36kDk5xfsckRcn6J+dofgP/Infb647P8FmJCPe8j
	+1AkE/PvV+i2JZExmIGZniNokwYJ3csn+0OHAcmj8QyMTj/hh74pt5E27wfkPCNu82wcUV4b9Bv6m
	0vgzBQFJJjP622N1S6bo08+PTbLiQ68NuRI3WbKZEqz9BM2zM67DnT8XagHEeC1dS0xyVspOxw7wm
	swwh6vecmUSlg0wZ3NHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2XJ-0007HS-8X; Fri, 11 Jan 2019 19:32:09 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2XG-0007Gr-BD
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:32:07 +0000
Received: by mail-ot1-f66.google.com with SMTP id v23so14100811otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=V0W2PjXbgYdTSjRjbwVyVPKyXHLoEjG/vLmUxXHD6X4=;
 b=OcWq1X3m7JJCZmSVNo6d/xj/KETMem8N0hKhYUqR1gMyKDnmx6lnJmMQ3s5OdpZPFQ
 HkJgCc8KgjtM9hB4TvANHupCTIW0ZM+q5apQBjbBPK+wrjK3Jnjl8bO1LZaWW6QIsdo3
 0A4yIpy7DP4jt55opVop5VtghR9xZDeKsIS09FilkUSb1k/M1MsL8SJXMZrNoVUATbIz
 KwTDByTajjfTkc1a9BnN4ZYc+VbAf5qGUCz1gSSRW/wAJADRBDkLup2JN6OY2ily9OmW
 JQfwT4s5WPqT1LDlBopRzDMK9aJnUVF57jotk6ftLc5zm7Vw3Bd/mKl7W5G9F/GylxwA
 qW5Q==
X-Gm-Message-State: AJcUukcfIcVn78qPdeT+EpgVGx/7t8Qpx+S05aHoUl2YR7ZLhxI2by+F
 evS/elS0pDnd38EwvUHeJNxyn4Welw==
X-Google-Smtp-Source: ALg8bN6WQImHQo+GfG9Jdk6TNTqLFZfvBf6+Bd+tZ3jor0crk9hCgNeWppVXg29Xj929wujzz/v9iQ==
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr10586942otb.18.1547235123480; 
 Fri, 11 Jan 2019 11:32:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m131sm34930866oia.6.2019.01.11.11.32.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:32:02 -0800 (PST)
Date: Fri, 11 Jan 2019 13:32:02 -0600
From: Rob Herring <robh@kernel.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Message-ID: <20190111193202.GA23016@bogus>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190104030702.8684-2-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104030702.8684-2-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_113206_420775_226ABE38 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 11:06:43 +0800, Joseph Lo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Add new properties to configure the DFLL PWM regulator support.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> *V4:
>  - s/nvidia,pwm-period/nvidia,pwm-period-nanoseconds/
> *V3:
>  - no change
> *V2:
>  - update the binding strings and descriptions for
>  nvidia,pwm-tristate-microvolts
>  nvidia,pwm-min-microvolts
>  nvidia,pwm-voltage-step-microvolts
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt   | 79 ++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
