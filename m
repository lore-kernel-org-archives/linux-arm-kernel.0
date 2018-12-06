Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C2320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E0Npm5Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C2320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CueUiSZwBOV696hgxF7LBok23P3dSYbbKb9K6OOhFdw=; b=E0Npm5DuzdOsWr
	SFq8u2Z952Rc5LPmRybTMgh0Tl5FdxGKOXF3DGlPkUGXHvyTqnsRWV8WAaOXp5BQpw0uyrNZqYHnZ
	gwxKn84ZKLvQEX4NS5oufsg5F/1w4VlVe7Nh/D9zAPqjgYyc5h5p0qIWIiqxd516ZU0bP5EIaAmyT
	4jXw6RubYZDP36PvyI9022TZtt/x/QZ7bCx8TfptcCuY+1/6Ok2K5cDSbv308NPX6SkkCW2vgC9lJ
	ayIA2+eEV1NtIGhM2L6iIzrDrZR3wXLFlZ1w12saELDm5BUCrEO0TcLe4ehW74Wrtw0mqCJNaTHGE
	pCyHiqNcKsKW5QS8lyFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3Kr-000473-Mq; Thu, 06 Dec 2018 23:45:37 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3Jv-0001oR-TN
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:44:45 +0000
Received: by mail-ot1-f68.google.com with SMTP id a11so2141332otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 15:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UJP2qD5rois//V7GQAZsC/vBxUdIIPON3mcv9TL9Xjs=;
 b=YCURiTzMl/lQ9ECErzzemzPMrmPI48/GO9ZCp7eubOoC43xsr9AnNXUj7HdcqKcrSN
 OO4lo6Ok5nFh2dyNBbbM1rp69gavXehwqQGo3nmMCOMd4cPyKOKFWBNEfnEEKFiOeHgV
 Bmzwl/MXtXM4SAWzc+NK1oTUYy2EOO1rwZy57AszolLdDsPNH8ZcOpF6Ut3qiog+Qq3p
 M0JXSFAXOCJbpH9P/Pm4eRpV4hBA/ewp0XkARkubk1vXXpKnMeS9fv1ZEv6o8mYugFWN
 a4VZo6HAh6JcvcAvtCZ6DoXEVlneC8kTcv6sErWa4LVVoSHP7+wBrwuHeyfPBqiTjZN9
 BIfQ==
X-Gm-Message-State: AA+aEWZjG74GWwrWTSlxFa5kqni9bK+640GdFV+s34BxBFs3DsLTqbPn
 3yA/2V3o0uclws5kfsOOog==
X-Google-Smtp-Source: AFSGD/UDU6WkClv6nwc9SYsaICQSPWjI3aJm+qlXcyRjnnsiCDjSpE0svntX5/5lm1OhUAQFM+ZE4w==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr18950090otl.12.1544139867984; 
 Thu, 06 Dec 2018 15:44:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l20sm680174otp.47.2018.12.06.15.44.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 15:44:27 -0800 (PST)
Date: Thu, 6 Dec 2018 17:44:26 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design  Associates, Inc.
Message-ID: <20181206234426.GA2687@bogus>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
 <1542789804-4584-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542789804-4584-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154440_578847_3CFE5103 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, thierry.reding@gmail.com, Cristian.Birsan@microchip.com,
 Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 21 Nov 2018 08:47:57 +0000, <Eugen.Hristev@microchip.com> wrote:
> Precision Design Associates, Inc. (PDA) manufactures standard and custom
> capacitive touch screens, LCD's embedded controllers and custom embedded
> software. They specialize in industrial, rugged and outdoor applications.
> Website: http://www.pdaatl.com/
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
