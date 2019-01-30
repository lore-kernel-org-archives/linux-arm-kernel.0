Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CA621473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9DCx3JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CA621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Wd5p7+SwSLbJ7eQCO99+D4ltJv74CF5MwFwMK+K7F8=; b=T9DCx3JAObnFQF
	rFR5NNcUlTrwKBrp4gaTaZ1hbHy0OZ8D+j61ofTKd+lsUww9+CFGjuUJReVqJ0aGZbHSRRFm8pIrH
	T5gEGbzfeoBXrOwutpsn0OkDZYsutMSBHDLHZpUZ67ie2AzR8go8bQmbq9CS5yezDMMG9POrMRugZ
	nMi/PsWcbT8XrY523KFOU6ujtyNtr8btGFBChlIhhzzGnzptg4Hzo2wXv6CP0TxBnD3WAy33nhxCQ
	cLrDbPjGCPLnWjShWzySb7JSv8wZINhd2681gY4aLS4llC8BNj2At7SwcgLHPGVTTVA+7cSEzuPZS
	ehczLmbEeOZMoJZJJ1SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gos9p-00073W-0K; Wed, 30 Jan 2019 15:52:09 +0000
Received: from mail-ot1-f46.google.com ([209.85.210.46])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gos92-0006SZ-UD
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:51:30 +0000
Received: by mail-ot1-f46.google.com with SMTP id n8so21495253otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 07:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=a6KhZ/RV34XWL8J67/X0hcpg51Ps39ws0uRDWZ+Jn08=;
 b=Y++/vexqpErbC3bAMMXj6CtC5/XXPm6iCE97C3nLNU7dQNWJL3UO8IzVc1ID3dZVRY
 1xibCJktdUzf7syiLIgU7SmTXy2wAuF7lFqP4J+Pez3BAlIltThkRTMbxQKW2w9xLL4W
 tEO30OTXWAbyTfh17e7IyG/6vLduZaI4pjcMu1JQ4rctzLWZ46HNh82h+COPieNgYJcr
 0fM4MZub6uNIxqfOO5L2JRX17yTE45IbNrTqCv6kbk5OYKAZqmbMyiKER7D8jn0lOoVE
 EB/k9s3+4EfDlP9NmQtAFiTlnutFB/44wQ3kjpWgrT/CmpnbtFgsms8x8/XFVjRdkBqd
 GAVA==
X-Gm-Message-State: AHQUAuaWu9Xu30YGp26E6zleVogymWUwSEjF20G30bii1OVXs8kNtNZq
 0LRnTqldfyc1UBgShd79Pw==
X-Google-Smtp-Source: AHgI3IbPCpSr4frSE4DFFnyI28JcrHoO2LLNY94lhKjo6YsKjckM/xxAze38HrYmYXaf15hydLE8kQ==
X-Received: by 2002:a05:6830:1310:: with SMTP id
 p16mr13183255otq.309.1548863479707; 
 Wed, 30 Jan 2019 07:51:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m26sm661431otl.32.2019.01.30.07.51.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 07:51:19 -0800 (PST)
Date: Wed, 30 Jan 2019 09:51:18 -0600
From: Rob Herring <robh@kernel.org>
To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv3 2/6] Documentation: dt: socfpga: Add S10 System Manager
 binding
Message-ID: <20190130155118.GA29638@bogus>
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
 <1548713655-25940-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548713655-25940-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_075121_434930_B944727E 
X-CRM114-Status: GOOD (  11.74  )
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
 Thor Thayer <thor.thayer@linux.intel.com>, alexandre.torgue@st.com,
 arnd@arndb.de, catalin.marinas@arm.com, olof@lixom.net, will.deacon@arm.com,
 linux@armlinux.org.uk, bjorn.andersson@linaro.org, dinguyen@kernel.org,
 joabreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, mchehab+samsung@kernel.org,
 peppe.cavallaro@st.com, lee.jones@linaro.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 16:14:11 -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the device tree bindings for the Stratix10 System Manager.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  New compatible string and usage for Stratix10
> v3  No change
> ---
>  .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
