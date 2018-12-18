Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A866C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:45:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2510021852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qp6lVQgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2510021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eUAXgIYpo3DZHajA2nn1eUaocznZ51yzWgUIWTHX3Fo=; b=Qp6lVQgwRiNkoQ
	TUWwKaAJXJeEl8pjrAbsoyptqJ4xfkAqtL1j5wdRF2ZSccW7XqmHhEce4tDoC455RVHoEHVr0UUcA
	twZAQAY4YRAOumkmpZao4Eu/zue0q+lwiVfWgvDM5eG7gv85PY75DYnAhUixNU6ZgE9dZ6A14W4+r
	MOrAMMwMJH29fEFM8jEcBhPKWBPtdW34r0mQBoa5qkyQpyonmB8+IvZsC8WMXq+viiAIVWmX1lurA
	e9GyONJMbIg0zXZTDPFm0TcEU4kAA1LiA5UEs+L0tuY2c4k6lycq2UcEtWIc7nsDGnu6XZHeAZ5d9
	EtpXjuxB4I/g2oU10bpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHZ0-0006jO-GF; Tue, 18 Dec 2018 15:45:42 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHYx-0006hq-5e
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:45:40 +0000
Received: by mail-oi1-f195.google.com with SMTP id x23so2309424oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P1c3HYx5ykitYj5HFQVqTnZeodY+IhYr/IHNwbcVvAs=;
 b=VhzttV+uSsc8E0BBdL/iVZ1LeTEZl7p9HrWxKTnLmZR/BSj3GDWCZPcp77hJUXJ4BL
 gZU3LOB11EaABn/uI9lW5JpQP/6hwfFrnWiDAoGHzYyZY26KFRaOVvMSHzYJRhcXIuME
 +W3SBnbyZvXTjHFOigMTL0JaUlpYogJgufCj+R+fyYRXVAi0p/S8ra8mpL2WHeEqUSJD
 /ROq15To74U6Sj++Yji58S0Ia7iS5pgqs/m9W3lN8Wre78bxd/nCxsoLAA+6P2YI/Pv0
 Gz+IKH04sbzZI7kPdOJ9iujnIk9dFGVqeybfuiAM4sH/0hHzvSgvw4NytmTgvCuAfbJa
 WAjg==
X-Gm-Message-State: AA+aEWY4MsH2Kl7zPGGpxGfkWsAFnLgHGiioieRno3dosWu9DecyESg5
 /DuttWeNTYK1pz6qQ67jKQ==
X-Google-Smtp-Source: AFSGD/XfEiAQoMQ2RY62jQwDtM3eZMPZhjjQAqQG+Z8O5AqwN7e36ZN8FYy3bHw+E8QCcG1Hz3+aZw==
X-Received: by 2002:aca:4155:: with SMTP id o82mr8441157oia.172.1545147928415; 
 Tue, 18 Dec 2018 07:45:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q25sm9070525otg.70.2018.12.18.07.45.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:45:27 -0800 (PST)
Date: Tue, 18 Dec 2018 09:45:27 -0600
From: Rob Herring <robh@kernel.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V3 03/20] dt-bindings: cpufreq: tegra124: remove
 vdd-cpu-supply from required properties
Message-ID: <20181218154527.GA24811@bogus>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-4-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218091232.23532-4-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_074539_207423_B959F0D0 
X-CRM114-Status: GOOD (  13.56  )
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

On Tue, 18 Dec 2018 17:12:15 +0800, Joseph Lo wrote:
> The Tegra124 cpufreq driver works only with DFLL clock, which is a
> hardware-based frequency/voltage controller. The driver doesn't need to
> control the regulator itself. Hence remove that.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> *V3:
>  - no change
> *V2:
>  - add ack tag
> ---
>  .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt     | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
