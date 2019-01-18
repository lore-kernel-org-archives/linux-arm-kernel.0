Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:44:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70B72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="te9SA2p3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoQYFZZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70B72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ubXUva5sPQfDMnGyKnCaAmk9cNoDn/3/ohlA4U6/NeI=; b=te9SA2p350joNn
	ryRwM3zC1tYCb4GZYHoyAGKUlBJNwc/T4ce+/60JjMNKdOB3cxz0GjD6Hpeoera+OscaVcoBP2j0T
	SkddjagFkGl4Aj3/Wg5T6rotJFVXu5vwSA54KUkVft7K8y+SKfZwzGqQaa9zbeN6GFFO6U+Ok0OAJ
	+Iwon/h7hc1npG5Wb1kWfKeTar5m6hzrE4OQazIoMSHBZ7P08XwS9CTTA4chFI1LTVkaQz21S/qsX
	2kQ/2vKSbtf1rdByXEPUQoCPkrFXysGEcvy+QfmbLRRhz3Sw1NPVHpNui2Mb7bY79SpEUUjn1aBq9
	ukioEaAfaBPn89bCQ4pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkJCw-0003VM-HF; Fri, 18 Jan 2019 01:44:30 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJCs-0003Up-Ht
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 01:44:27 +0000
Received: by mail-wr1-x42a.google.com with SMTP id s12so13174561wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wyf44XYgmRPPBCMR8SnSe3JLJyFdvyPu/Mai6aT6W+o=;
 b=AoQYFZZWESqgXGMPwjDAPFpEf3tDUBQ6zp+2OoawX7/Vcai705ERz0IP8+2ksFlRIH
 yTfwmw12p1aD6+QaxuXJx8Y62abVDN+hPU3Kt2MdEv1iJyrjpFvrRrNtKFTU1qoZAXeX
 x9Xca5PL51mkq7Sv/2xfU/l3YF5Av87zDHOuBXjH18aqIDOiolIK1c66B2UOjOx87isl
 OMM83KK7+qnZbijdGM4ya/FSzrsy5/YNBdwTz+iXXnoSROjexZPEtfdRRta4M5PKohLq
 UxEtn5uE3Rb2tbRf6soeg9ERliJ4W6p/GCr788a7gZR2mITeNAOqrvJbkffMhfbFB85q
 qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wyf44XYgmRPPBCMR8SnSe3JLJyFdvyPu/Mai6aT6W+o=;
 b=eQvnVYTJ5uwOkyOKqn1BgOI9zsm+DLjKbOOacvjGR4Z+oAsdK/BD7HFVw9CYjeUHpQ
 FnsbyWMtB9ysIzkOutkgcka5h+rmqUFXpsOh8T+sz3T8mCeGCC+HbqsiD+dFe7w+2Pn9
 6Qimk7+ZsmCWDC90ttsWMRL8O6qa1GIiERzuUX+wXYSNAyVXrwVkfNlQgEnaR578hQ/D
 zJqY6b/Se/GJLiuqRmH0qviafQlnhR2wYfU7nD0onMMDaMWsJmfPC1mK8wTrftNqVy7W
 h0mRTIa+r4bWBzcaXx0U/665c+49MiBgaXmQ+NijlD6FLOPlstwB3M2HrfmJ2FHY1CVX
 t82A==
X-Gm-Message-State: AJcUukcWR5sAxwiRVaK+xWCuUG2pJvDb9wUsJRi7SW2u+HvRiZSqAYAv
 QVoB/it1A6ag2YvyqS5Ym8bSxiM7lP4=
X-Google-Smtp-Source: ALg8bN6XxV1N/tQMiCxG0/eOvPr11ygYdOgSYJ3JBFX2jJYcPmgvBVl/PiI66e5t7ZQ3UWpOB2XqWg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr14788757wrq.182.1547775864032; 
 Thu, 17 Jan 2019 17:44:24 -0800 (PST)
Received: from localhost (83-215-98-136.stmi.dyn.salzburg-online.at.
 [83.215.98.136])
 by smtp.gmail.com with ESMTPSA id e9sm69409419wro.16.2019.01.17.17.44.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 17:44:23 -0800 (PST)
Date: Thu, 17 Jan 2019 17:44:20 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v2, 5/5] ptp_qoriq: add fiper pulse loopback support
Message-ID: <20190118014420.rlyk36477cqj6yb7@localhost>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
 <20190117014936.48117-6-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117014936.48117-6-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_174426_618440_BCD4C8EC 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 09:49:36AM +0800, Yangbo Lu wrote:
> This patch is to add Kconfig options to support fiper
> pulse loopback mode. This is very useful for validating
> hardware and driver without external hardware.

To me this feature makes more sense as a debugf-fs option.

Thanks,
Richard


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
