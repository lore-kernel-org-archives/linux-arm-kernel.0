Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0B4208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a/AUC5PY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0B4208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZpkd3m+cVPMwoxh2gXActg/m3jTtAfVKxYuz6ALpWk=; b=a/AUC5PYrUXbUD
	01N7ZZFwogs2cfFItvLrDAy/cjS2LPTd8Xnx7kL4ltn1O298d85QBWuBZvDkn6OPvCwMrttTLnCGx
	6HldHQBXBBchxj2Jjeh6/O3YzBjJayS5qzoL6T9e/jY0XjCuL5Ph6Z6q3SNvQ/2LA9AgFaqQpBBpo
	44ZgVDYS4LHu0gcLvvWy2khJ+Y6ZW7P+6T89lFqu1SJB3XuCClqcgpBv1DgyQbslEf1R7tYYIAA1j
	j3qRY/0ZL6bcmESA2roG2LhJ4/3P85I2bC2desz6Ks6EtcwVEAeyj1drBl4Cqbz9/0E3NUHGq3RWj
	vGUjnFD1v9/cK7GUnEmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6zq-0001MS-8f; Thu, 03 Jan 2019 17:41:30 +0000
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6zl-0001M5-Rr
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:41:27 +0000
Received: by mail-it1-f195.google.com with SMTP id z7so46334885iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 09:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XgtY3ON4bBMzyuiNr7dfPpNVT+C5KIh9dO8CbrGw7tk=;
 b=haQqlgkqjjGr9OQ+vSqzp1w0yiHqB4NSdzqZ5GbvHqSsPBt64KGo4igOzSbNmO5vC6
 epF325ed09HsYNz3jSS2gKouWkKoEouRagLFJyO71EtyJlGZjLutv3WETXdvNKBrIZ5q
 xk7zqNlyXVC0H4rCAOfZt1FNKCcw53uM9beTi0MSUZYxxYWLFdH2/M6n4HT6r3s+JOJB
 59bGdwxdjIOxsSIUTMK9KIP23eE4rA2nxQy5Exkz1k1fqKdYexCXbUYJ9M+zzarhcs1K
 wTY0mXsqYh2fzr6RAUq3KxS1Q95dgrQwyfdjhPNqTcaI04q8jz/aJlwBkGxTP813UnKV
 t+QQ==
X-Gm-Message-State: AA+aEWZrrSS/GHmy/ssA/KqrZADb9s5wTN9t2cKPL0LzF0crXmjwLVKn
 Da8cy87KZC/G+M+oEnw7jQ==
X-Google-Smtp-Source: AFSGD/V9b5yqNsHDxHuE9KElWPtdLZDxaY7MyTLeweez3j5H2PftNm0IWXF0oxxaHSQNzRuuliNPtg==
X-Received: by 2002:a24:16cc:: with SMTP id a195mr31184772ita.38.1546537284031; 
 Thu, 03 Jan 2019 09:41:24 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id h13sm6088944ioq.72.2019.01.03.09.41.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 09:41:23 -0800 (PST)
Date: Thu, 3 Jan 2019 11:41:17 -0600
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190103174117.GA6613@bogus>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221013409.14324-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_094125_962353_081151DE 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, p.zabel@pengutronix.de,
 linux-kernel@vger.kernel.org,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> Add a binding document for the Broadcom STB reset controller, also known
> as SW_INIT-style reset controller.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> new file mode 100644
> index 000000000000..6e5341b4f891
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> @@ -0,0 +1,27 @@
> +Broadcom STB SW_INIT-style reset controller
> +===========================================
> +
> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> +reset lines.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: should be brcm,brcmstb-reset
> +- reg: register base and length
> +- #reset-cells: must be set to 1
> +
> +Example:
> +
> +	reset: reset-controller@8404318 {
> +		compatible = "brcm,brcmstb-reset";
> +		reg = <0x8404318 0x30>;

Based on this address, should this be a sub-node of something else? Or 
not even a sub-node and just make the parent be a reset provider?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
