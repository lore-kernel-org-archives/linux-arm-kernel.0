Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2563EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:45:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99D1218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VTDPtjWr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruMcwx3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99D1218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bHVEWs3Ft3dHBEP6RXePUyQTIbZ6eFydZ1brQsIJD8U=; b=VTDPtjWrX0d6NO
	5LqjP7CctPOWOq0aVMo4dYzVMi7CCt5bNm5hfftIYtwvSsuSM589spUepzr6A00ErVB9DGyfK9w/C
	eWajg3686QRWK6Vo9vrX5Iok2+pOWqGU/mGyxV+PA3gVeFeiu3/RJWWeViFmwqtiCOwfzepVv8YvE
	hHjkILc+dGqnS07qEr/UCU9NvnskiPhkRfk+SlJmWJmcD1KS54eKszdQ93T7Ji0AgMtrxZ1ySj9U3
	2tAUxVvNCx7QP8V6BN1m6yNwyUZ3VJNGPc0FH4iPJcTcr4UxPm6vjYtOBSYYGmwgkNMqH4BrdPCqn
	2b8Bsf8TNEC41WIl+aqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcDEn-0005zn-Sh; Wed, 26 Dec 2018 17:44:57 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcDEk-0005yk-Oh
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 17:44:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so16224495wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 09:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e5StMPPFMeRNbftw1fp0WEMyIqn7SJHK8uWKlxriUww=;
 b=ruMcwx3iw6zhSxXv/yhjhNphDrPYQ2LW76Rg+QTkVCh8cmzqK+FgEvJgOzmBXLKgaB
 ni2NbDTiWF6Up11x9hZpw/XK+a8z7nIjgTJJtUbGifjMwHbMlWYkwWSWpRjrv7oXepe4
 cu4RF4ROVFqlA9qfDyCOyWIMcFW+WTPLzMIkNQelRrtgRD3DuZCcmRerAPgJyqspG9Bj
 t91gz6QfYdE9ytAH8wNKKA7Uewg4FXalq0qJyJKfFLc5nSw3GYAyCFoapFQxbUCRMcVE
 RdntgzaW4vn/7NdfrfmKY3L7xyAf/54IAIbASH4GgxPQN8j6Z5b0M13RLYbuUTgqDvQS
 qSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e5StMPPFMeRNbftw1fp0WEMyIqn7SJHK8uWKlxriUww=;
 b=XdW8/xBWVWJ3ABc19iXHyRdV1AXmw30T7yZsUAFis+HpZqCbszHfXQwSINqvKSD4ou
 BVAOJ5xLmYTZ/mnVdEIR6+Hhhs5zgmhgHwLBqK0SEQ2RuHNvA3pXNu0vG2mu6cQXyAst
 TCIuupBgDu7uAGOmSdZ6GUm5XPnjOrpIghaKJE9pF2yn/H7RbDw0Q/SOQ1giOrA9qPjX
 Eg7dS7iwRuyjzEmHS/R9YKY3C58aAqXrgDFm0Ltt8qivCuS3kYAY0kkp55i8EPax2SrX
 WUcSmni3g8+sSX7JLDqVotf6uS/jKCwvGFBUAr5LMYcIJFi6IncTwKgh/RTtAR+21JiM
 ZF+g==
X-Gm-Message-State: AJcUukffktV9cctb14CN9JpvaGriul5P+bDWW2HpFo5GzHOv04h6xqBA
 ASks205DYpbs7EEOGOKRatA=
X-Google-Smtp-Source: ALg8bN7Ga4DsuTjqVwkemUhQ3883Y3CLsdvskq4+J04DI/hSvgRja6SOmPG0IMp81p06g34yQPYJuQ==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr20790314wru.245.1545846282766; 
 Wed, 26 Dec 2018 09:44:42 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e?
 (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de.
 [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
 by smtp.googlemail.com with ESMTPSA id d4sm31348843wrp.89.2018.12.26.09.44.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 09:44:42 -0800 (PST)
Subject: Re: [PATCH] net:phy: Add a return value check on bus write
To: Aditya Pakki <pakki001@umn.edu>
References: <20181226173717.7113-1-pakki001@umn.edu>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <77ffa226-5d4c-3fec-6cdc-a2192eefd5dd@gmail.com>
Date: Wed, 26 Dec 2018 18:44:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226173717.7113-1-pakki001@umn.edu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_094454_801706_1BF70848 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, kjlu@umn.edu, Michal Simek <michal.simek@xilinx.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 26.12.2018 18:37, Aditya Pakki wrote:
> xgmiitorgmii_read_status() could fail when writing to the bus via
> mdiobus_write(). The fix adds a check and returns an error in case
> of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/phy/xilinx_gmii2rgmii.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 74a8782313cf..926879d43373 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -58,7 +58,9 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
>  	else
>  		val |= BMCR_SPEED10;
>  
> -	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
> +	err = mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
> +	if (err)
> +		return err;
>  
>  	return 0;
Why not simply:
return mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);

Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
