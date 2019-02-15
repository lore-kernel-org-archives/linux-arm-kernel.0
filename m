Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94510222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oga94c4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94510222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6jofY0B/bvfv+APltPTeW76U8flXdubiYVC9/qaRbQ=; b=oga94c4csng4db
	nbiE6cr5yx6cCOGjM9TxrQJnO52/CuKxFIf7BPM8htRMwKzxW43DuvxXmhemigSts6REJzWkPQoX4
	gyznHkIufZMYyRvXH9DmaiHcAXrslzCESHIB9znmMdp/7Bsev2Qy2EVGuJRvdTskQdYLyYCmU3i7y
	fFoocZscRpQ7mKXlfL5qLK9L8/dn9mgFScxiai+/30JUjZXnH6AQiK3IcyRUx3q817Bg2hHO4tbnV
	bQoxACFc9B3GRjjkrE31n2bJ9eqkAOdmitqmeCWpYZUvyJ96QmSctlVoHMG53ar7oBA8dpKdxBatm
	914CnIGLAdkcC85wOKzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugXQ-00016e-Nn; Fri, 15 Feb 2019 16:40:32 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugXN-00016J-Tb
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:40:31 +0000
Received: by mail-qk1-f195.google.com with SMTP id r21so6025822qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u9Fp369VbwAoCxXq9wVwajdpnZvma2BUEhsRA8B5xno=;
 b=PugwhQu2pFPfhkxcVykUN+sdHQ9MlmE5N+1CbUGv5fjnPY2pBjyJsjW4dYaw12cjah
 EQsdPoLkOgM0KFcpTkcK8Sh5tVD8gGJEzqKt8YeHaQ/B2MAVnUswzquP/9yNeuBEm6yg
 TMMJB+Cc6y+cxZ18FFPH9yQEBV3oRofjwKmuALzZ8cMFrwncXvWyzpDuBY1gkfS054pZ
 8I6hIUEf7OhI4j7I5Z5HFqxQoE/pyd+4DtFU4JDmsWeNL8wyih1Yp5OgXm64ztoSUSmE
 QdDIjsuiJtMoTY8EWJqQbK5xWCLPdgqW4qJACbVpOxYg/gSsjz2nQMHNSNvEV8VcEe+7
 Dppg==
X-Gm-Message-State: AHQUAuYmyo4eGGwCfCTeqGY64v2a/nGECigsGdHGBNY6Ea8/66mFS9sA
 32G7vgM573j+bFnc6uZmdj8R4rcogvC+A4PqLI4=
X-Google-Smtp-Source: AHgI3IbIFsIGSitbLrj9WMo3zLcsZnNaX68GNKL2WXvpywuiO94ov9vKFrFoswFkPGpCVMzpsGyMiO5IOfPylsvxZzU=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7698298qkh.173.1550248829053; 
 Fri, 15 Feb 2019 08:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-2-shawnguo@kernel.org>
In-Reply-To: <20190212112126.572-2-shawnguo@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:40:11 +0100
Message-ID: <CAK8P3a3jmEeZh_R=srL-fAakOJamCqpYyqERPTu3avAzEE0+yA@mail.gmail.com>
Subject: Re: [GIT PULL 2/7] i.MX SoC changes for 5.1
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084029_953037_CF266A6D 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 12:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-5.1
>
> for you to fetch changes up to 84a2ab25b12d69914c96dd12e762f7ff912f9735:
>
>   arm64: imx8mq: select PM support (2019-02-01 15:04:32 +0800)
>
> ----------------------------------------------------------------
> i.MX SoC changes for 5.1:
>  - Support cpuidle for i.MX7ULP, states WFI, WAIT and STOP get added.
>  - Support SoC revision detecting for i.MX7ULP by reading JTAG_ID
>    register from SIM module.
>  - Select PM and GPCv2 irqchip driver options for i.MX8 support, as they
>    are essential for building an i.MX8 based system.
>  - Skip build of ssi-fiq code if SND_SOC_IMX_PCM_FIQ is not enabled.
>


Pulled into arm/soc, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
