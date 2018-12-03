Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:49:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252B020666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DQjzJzEp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="2BISXMDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252B020666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ub1XQ294xM40nRy5Vc9/eJB4qkFOJSTmtXCro0aOyg0=; b=DQjzJzEp7siihe
	Bh8KIAqKKnunU6OTDRLrn+RRsG8Mi9YGBKQTN/erste5vmt1rgtSx2Aq6/CJS6UngAoC9h3Hyp1L9
	dwnc3YvyRsqVYQx8EpYtYA+nRi98zI9R1K0QcGUTGi/HYnw1juWXWaSf1hqGgKZtkvg6gkae06dAW
	cLWccmdheGRmQZBX3Bws4WzJBzdQPRHiMI2BIdsdFgU9eP9RYG8wz+0U/HI83cBwK3Bx09zuzhHfn
	J/k1rq+IhPz/PJUoRhF+0hWbVj+T1yMTa7aqPERtCu8eNneZxT8OOapKEnFjJoIqYWrRYYTCMnjrQ
	eOSamUSzqtSe8Lq6TctQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv9j-0007GK-6h; Mon, 03 Dec 2018 20:49:27 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv8t-0006H0-8U
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:48:39 +0000
Received: by mail-lj1-x242.google.com with SMTP id x85-v6so12752757ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bjc0/eeHT5HM2HebjbP/8Us5NaMzzuiyJ/DlqGQiF0Y=;
 b=2BISXMDXmCl0ZVp3QALTWUY56mcECTySfIsZ9GNN1A0ZFPNyAHdUQ3CGj23XI0oYZr
 Ms+OsVm99QOUjPNmlqR0nkehSsU180Tcw/4CQm/bB1drBSMvBxwiT+j1XKBLhYT4zN31
 pvAk7iuo97Uz4Qhy/Y3o7Afqd9bB9uPTis9i/wB/CHZl3cuzxgXJCwfSoJPwLDrZr0h5
 PfwXlnB+ODgCZDhOdT2yelB4fIvkVv74WyPqbJKaE0gAew7xylWPKtFm+WZ5oyuA/goY
 JnvITvzcYE8TENWZBHk/MhUHmmKJ8tvKWC0uczZZDtUdmKobF2lnjeAp99/0tUdpyyAV
 92Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bjc0/eeHT5HM2HebjbP/8Us5NaMzzuiyJ/DlqGQiF0Y=;
 b=czBs+qYh1dgKR5TM+QtSll5+/5FIR8ti0RtAsgcM6stpQ4+Tov87CMiNE3SZoATr6V
 +FcZuaYmQLQbRjOYUAP7dej/ZJi5R05x4XmNAHF18b9NZeNf9vGRTk1hpaAMeEU/B71b
 XRfU3gdQBgkEuuygEJ8sZQqMT8M/+oXIfZdnyL0s7tO1ZqzDGy07iVSP0hb7fM3MDQFJ
 PA+RB8k5DPz33ALVfzmzyhzftHgRHDwsbd4XxaljxuKE/Om7eauDodtNOfsEeMoW7+BS
 AqZ2x/hGHsoWYjGzEDBD8dIUsnF0ociS4TbIif0IVYEIsUVmyApxkwINPTM+gBLnNrbh
 6NlQ==
X-Gm-Message-State: AA+aEWaSyslC1Pek9S/7X/0aFpW5pnA1yQ4iM27M/grwPF/HI1vHrwSw
 ZzBncpMRD4XOzv165XugcbkVmQ==
X-Google-Smtp-Source: AFSGD/XKF37YD3EzQdEuhrGTC26aCJGzWBmkzHi4fAzh55g7pZ/2GFICku46AXbHDCBA/zAWnfrUfQ==
X-Received: by 2002:a2e:7011:: with SMTP id
 l17-v6mr10056269ljc.147.1543870105078; 
 Mon, 03 Dec 2018 12:48:25 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y9sm2539180lfe.75.2018.12.03.12.48.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:48:23 -0800 (PST)
Date: Mon, 3 Dec 2018 12:40:32 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: realview: Fix some more duplicate regulator
 nodes
Message-ID: <20181203204032.lk5udkxngupowxfj@localhost>
References: <20181203191248.13067-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203191248.13067-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124835_636916_CBD25F41 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 01:12:48PM -0600, Rob Herring wrote:
> There's a bug in dtc in checking for duplicate node names when there's
> another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
> another section. Upon removal of skeleton.dtsi, the dtb fails to build
> due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
> much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
> by renaming the nodes to something unique. In the process, drop the
> unit-address which shouldn't be present wtihout reg property.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Sigh, not sure what happened, but I missed these 2 cases.

Applied to fixes. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
