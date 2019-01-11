Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1042B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nvr7/ySr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2ZLmm4MWYXirM5e5qnLbZmc1vjEXtJLy496VnXdozo=; b=Nvr7/ySrdWaJnp
	DnLNBb0zLXb65ZmQSxouVPbpe01yX5l59jSwDLuaorCalYT0W/maZNdAmRJXlYTHjW7q8O3aE8kMH
	H9SAXw/g0VX0+cajeyWeYbeyb8qotBecKkN4nBDy32yFWMJ//JMgHxAG39ersC+OWIUQMYMi0HVae
	SO0PY4J5J5w6VSoRlIKTC6emlXLikrg4ejbbnqCgnEtCSIpkGWnzdK4viiTJwoo45DdBhXYLBUFX0
	LXNYvF6J3hW0C8IXQBopwjV+oYVnlcCRyOKi/c1ioAcvUb5NRy12D4QeQ1IehOVEr7t+N2Q6JY4Hk
	QVtqMps6CQgIaM/EJbgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0EL-0002Cv-U0; Fri, 11 Jan 2019 17:04:25 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0EI-0002CL-CM
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:04:24 +0000
Received: by mail-ot1-f68.google.com with SMTP id i20so13753695otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eec5GYghdJ9rYhpPp737P8CJjJH63ZXJVzsaMQcHy08=;
 b=rHK4L22JjELhjYVR7AEvZhxqQNotph+TvDQyJCCXhW4eZHQZv+zjxIEaFwHHds1Rjp
 6FcySx5wunw+tZzbvAhF64afeVdx0hn+qtnNYLTx212qyXBDbxhgFjPj+d3IXDBMV5X6
 BqGYk34j7bU1HHjzzBVCeyyVhkZ+d64D2DaCJqxg3knPX6GGj9iB6PfsiaNnaIsVcJxN
 5Tx7Yxsc44zSq9xORaWBS8poUAfnRmXFpOSC0a9OhtQGY7gc7SAgyA8sqh4ByrLHs8n3
 ek5IPOlQ/TGqNligjiqvmHvGD03Uy9RP6t7JDXoqIXImdYr5d3Y5nvGagQFnY9FheMoy
 L2jw==
X-Gm-Message-State: AJcUukdZs32Cx0p4CVCn17L3MQZPwxXUldFfN/Wz8IcDBXM8w08t224O
 jHhMAziARLgF7vDAnZhBuQ==
X-Google-Smtp-Source: ALg8bN585bLnAJUC4ztZQg0zYlc6fPGMbgVv1v7JSOxgt94ceotl5JBjm9lE3nRYJpDAa1gFdabMrA==
X-Received: by 2002:a9d:2aa2:: with SMTP id e31mr9347919otb.246.1547226261350; 
 Fri, 11 Jan 2019 09:04:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f76sm50452177oih.58.2019.01.11.09.04.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 09:04:20 -0800 (PST)
Date: Fri, 11 Jan 2019 11:04:20 -0600
From: Rob Herring <robh@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 3/4] dt-bindings: Add vendor prefix for elgin
Message-ID: <20190111170420.GA8995@bogus>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
 <20190104014023.17973-3-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104014023.17973-3-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_090422_430464_D46EBBB6 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Otavio Salvador <otavio@ossystems.com.br>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu,  3 Jan 2019 23:40:22 -0200, Otavio Salvador wrote:
> Add elgin vendor definition as 'Elgin S/A.'
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
