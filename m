Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E647C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:55:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A632073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhbSQv6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A632073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+6cYMyHsTgU+Z0+NkooqDZZQCJyM55aXmHGUFP8MvNc=; b=AhbSQv6tgdNUgp
	exV+x+IUT3y/EgVrV7NikPi9/vxrPAUDUBKx+LwsmYDJfbDLqu1Sz1ouN5z+g/ldE/wU5snAXY/xA
	Os1T00GXSbTzLpuh7iK07JQzX6If+Dhd/AmvEmK7R/491Ca2TlyL3QjziFnkLIM02uEHC5+sYwItt
	9MRWlLJ+xbdnuOLDNbEiQ3KiZSdK5EwAtPmyKK5J4Uj2Scvg2eKMpOiG+Inl4xlk1R6FqUY1Hpn5j
	4YNE2fGIlMMf9xBnn2fTI1mazszfVe41qpxsDeqfY609v8tsWgQr7iIdTySNig/hy1HbGXoI8fHLP
	9kr1MK5HGVqN24B+aJkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTy3S-0000MG-FG; Mon, 03 Dec 2018 23:55:10 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTy3O-0007Xg-VS
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 23:55:08 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so12643805oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 15:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Unql8PXcB1D1tGU8A8tLivJjgNceuo0m+OICzGdriVo=;
 b=p0B2tsI3TjZD7ecJW2e55OqrOrwW74qtntmRvDGt00KbG1fLJLFGE/+JQwjcpfFk2N
 uNaQa53kT3balctRiQbOb9KJklPljidP44uJlFSrXOuhZY94pEaOS6ihDyvbIvyv52D/
 09gAbWXEh9UMUzQyYNGbYfRBsXBfaH9XlWpqHm0uvxf47Rqe+aVvvvij+6ZyJkrNIiOt
 ip2nfk2d09C6CRWxveUM93u86yIAK/aZ79/S54oV3R+uX7LxtICNtXv2l7ZDrBRXCRKZ
 SHAI/bues///SJIl5RE3S1mwKTxm71BqhftqfvQcjwkyKnisWh4S37ssEC353DmrMxy9
 DujQ==
X-Gm-Message-State: AA+aEWbST9wJ5TsJXqpziNsXl5HLmOOehZy6+35T7V21Mdfntaj/J0kA
 y7zGN6Svhn48Tkm1kNFozg5qAlw=
X-Google-Smtp-Source: AFSGD/VrDhL4eGtLfi0ZmJ316aUzLgZFCFDL6RY2wmEerr4EoOUSBFOxnS/ldFFyeHSGEXU0hTjSbA==
X-Received: by 2002:aca:4ed8:: with SMTP id
 c207mr11611256oib.276.1543881296265; 
 Mon, 03 Dec 2018 15:54:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h24sm5983549otm.72.2018.12.03.15.54.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:54:55 -0800 (PST)
Date: Mon, 3 Dec 2018 17:54:55 -0600
From: Rob Herring <robh@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
Message-ID: <20181203235455.GA5851@bogus>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_155507_018858_710D8B51 
X-CRM114-Status: GOOD (  17.09  )
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
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 12:31:02PM +0000, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Needs a better subject and a commit msg.

> ---
>  Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> index bedcfd5a52cd..691f886cfc4a 100644
> --- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> @@ -19,7 +19,7 @@
>    "marvell,armada-370-neta" and 9800B for others.
>  - clock-names: List of names corresponding to clocks property; shall be
>    "core" for core clock and "bus" for the optional bus clock.
> -
> +- phys: comphy for the ethernet port, see ../phy/phy-bindings.txt
>  
>  Optional properties (valid only for Armada XP/38x):
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
