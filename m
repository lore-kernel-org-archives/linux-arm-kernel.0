Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:54:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740F820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PGxCQmEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740F820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CEstoEhjSDTdWnhN9H5V7yP1msYmHjg4lvciLUfQaPk=; b=PGxCQmEtsxTtIw
	I0w6aEv+HLh1m9TvawIGUh90PK9on3gc0KuumHtlfQEiPToiNiRriCYhrvRlEWzyVRId58Itcfm4z
	24YHRUj2WKl+Nf7BEn0YgKIGNiY677Lvrj/xJOlec6ci3Cyx04PSYFD3GW7xAmL4VdqaXXVxyEwPs
	SCBjP3gm9+vN+UQ/b5u67OWW13xgO5CzZcMorwpkePboati6+LlYfZPIfrrOGuM/Re+HGxiCIlurN
	C8EHpCGomxxRquG+om245xzSoL/TAJG9dFPMl+bNL4YMKaaMC4fsUSVoqzPfaW/z1qMJOQ6dE1H7q
	7WzbIf3EAKioQQcsEb8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gov0K-00008W-KS; Wed, 30 Jan 2019 18:54:32 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gov0H-00007r-8S
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:54:30 +0000
Received: by mail-ot1-f66.google.com with SMTP id v23so520040otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xuKXrCgT9wbthsuvNcIkt4qy3ZCHqH/u1/9j1Q7XZ+E=;
 b=ojO1BGGkziJ6Fg5Ri5Vd5vrN3goZlqUxU6Fe+yQMZxO0dBWK1Z2kM9XSfG9B7/t+5G
 lB6sheZXR+M42YyCak3cLKfFK14ys6TIysT7zWTIs4KNuqaN7FqmZJoxIz1NpixjXKi7
 UXWVlT3AKo3PHBDBF9BV0mnX0RZiAMZcNLjf6jAcFV1PFXl9bSMyvlYApI0hO3b5PWBD
 v44F3bbqK+QmVPhsZMXqBdmIU0A8LMSaFScyXtAvBSU/UCAQTU2dvUfjemnxRo08/iFK
 GrN3MFBo6MYksOhNqcmj3fUClaubk70XSgBhJ1BPYG8/j7KkysahVMIC17my/RW5AeGm
 etaw==
X-Gm-Message-State: AJcUukdS1kO8OTzpH3a9xbTn58sHkG6G6877w3LXyA9wicZFgRJYh0Qp
 oQA8CkXAPuJTJbr1I4ZBXw==
X-Google-Smtp-Source: ALg8bN4Vr2khkH/aDr6Q6ngT6zRiIUhIDjX2rHxfIyavhJi0xcLz6qVG3ce0QHDnR4Hn2Cs+syjRkg==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr24085794otm.170.1548874466394; 
 Wed, 30 Jan 2019 10:54:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o128sm972900oif.14.2019.01.30.10.54.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 10:54:25 -0800 (PST)
Date: Wed, 30 Jan 2019 12:54:25 -0600
From: Rob Herring <robh@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: spi: Document imx8mq binding
Message-ID: <20190130185425.GA20402@bogus>
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-4-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130120511.11555-4-ccaione@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105429_299318_606414F3 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Carlo Caione <ccaione@baylibre.com>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 12:05:11 +0000, Carlo Caione wrote:
> Add the "fsl,imx8mq-qspi" binding to the spi-fsl-qspi documentation.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
