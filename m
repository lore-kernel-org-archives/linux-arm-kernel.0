Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C438C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252BE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWKgW9wy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jhF1nFmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252BE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xvwJDevLru/jM90gYGmNpTl+WNd37g/yg7L+Kw6eOA0=; b=dWKgW9wy9ppymd
	2+HTDAV6zFJO5wFXVQMDXZd+fhwp2cXkFKB2xRDxqROuD1dQZXPm7rmt+jEpdrAWyZCaT9WijMafY
	JP2M9AmFsMo1Gz8fcWCUHSU2nflyBqCVj2A0QEG7+ToyPYTAcFETh8p15rjp+RuksbzTeRONqLXsq
	H2HmRNZ0BtBhr4sTSK+V6MAgEyHpa+iaj8ZBpYFF7O4sUBk0Ul7q6hTEwF3WPcD584xiNklk7nkEi
	SBi9oMNVUHfMbKRceXTIQqCmeua4Ca18/9KEC0qMtYmgHnay17WdnuZIrMSsuQftt+dyZvDGZnrf9
	nr5CPfCMalyQm2sx7lnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCuQ-0005Uu-5D; Wed, 12 Dec 2018 22:23:14 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCop-0007a2-Mu
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:32 +0000
Received: by mail-lf1-x144.google.com with SMTP id p86so7765lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EYQ08MWaP97vRS+fqUiJaoWRvFcGi0WOwtLUMXy/GaY=;
 b=jhF1nFmbEGoFE/vxmHMTqjPajzFXsAdoDU2ra5lHYWgD79lArgZdqfhQbTr//dJB0t
 yenrYK4iMx9l5YmfHWMtvGBXHimevGKuWenPiViS1KsZZjCeWcWLkgImQcjJyL9+IDBw
 p++XqODBecxRkv3gYELTu4bWAoXF9RUxTlxrD1XDx8nMkF3I13CrzYy3qJLnV5fJ+D2b
 SR+XXEA7CKtD7XGTaIpFi/313xtw0mjIfuPbJ0zEBEHYKvMIZQdyz0TY9jI+Xq/oS0br
 N9JXp7e2AedCyGBrjp2lsRxWTn15EJypNNoSUqauGKR0ABAVjW7XOzI1r/QUD5cfSGcp
 Si7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EYQ08MWaP97vRS+fqUiJaoWRvFcGi0WOwtLUMXy/GaY=;
 b=Im9HZwMb8BP6+UnPDJ8TtJNLKadyISdk55QX3Oi1emDvS64TY/LmcbpAN4s/kb5p1k
 7Oypip8m+xAZ1+cRhIvaHB5Tc9FQ+V4G2bBOuY7tkDXvo/n+N/QfgzdhCaiyGJ6L2eYQ
 YJ95Xyotq9RMGywXVLbrtWgCOceJ661+PwMFNs8NWI8JTY4DqmG/1Ll/gO8dABDhZSzI
 YnLuQmjD39Zy9QNJTlV9kwDszneBpd+tNfUdPd6drTxCqZp8or/tEURN1je2BamVQQ3T
 HOo8Anf28Th4ldxL/JuZgFyGVL1wNPaIFX4ILYv3DkCyaU8RMB8kPxEs9xTmNH5RLtkv
 9RSg==
X-Gm-Message-State: AA+aEWYzFL8OB5Ggs/FzpJaAEgFHMnv/OHsHRaAt46KGi/QNwgxultD2
 ktPpZxzsMtqT7WJCVEAp+BHdpg==
X-Google-Smtp-Source: AFSGD/UZadLf4Xvc6/dD4vQIlaY890MmeXlXFQQQQbHkaoHq9Fg3KJsXaCGlpVEJxAZDTcFvpANysA==
X-Received: by 2002:a19:d145:: with SMTP id i66mr13373181lfg.97.1544653035282; 
 Wed, 12 Dec 2018 14:17:15 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e97-v6sm1877lji.51.2018.12.12.14.17.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:14 -0800 (PST)
Date: Wed, 12 Dec 2018 14:07:21 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PATCH 3/3] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
Message-ID: <20181212220721.o5gde2yvjiyhovy5@localhost>
References: <7153021.iXIDTOc0j0@phil> <20181212085011.14282-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212085011.14282-1-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141728_168933_1A575DE9 
X-CRM114-Status: GOOD (  10.49  )
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
 Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 09:50:11AM +0100, Heiko Stuebner wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Convert Rockchip SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> [move to per-board entries after confirming with Rob
>  and added recently added boards]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
