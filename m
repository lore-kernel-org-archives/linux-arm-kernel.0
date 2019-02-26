Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA805C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A182173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJIQU2j7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSEifZp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A182173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BrYwkkYeZ8sUm+3nGLrJDbP3sSv30XHQY3ItUolzPxQ=; b=DJIQU2j7hToWAu
	+vK3aa1N3de3m5idSlsZKBQBzL66l/VzmukICL7IdGYtMHFQfcnhWuEeoX4UeCxD85nGMhYka+1W+
	4TwhqwS+O4pjCPld/mXyoxZKLVYgFrvBe2/IKfckU8d6ZglDVnDReu8TyU2E1on1vqHWvGpfZhQvU
	cOVIT2v1in42YPtczEBC1okDN3D5Ge3upbnl3QTFjx+pdko89Ash+D8ouZpdUq34j8Z1HNEsA8Y0f
	508pnEvMiHlk+A4S+fIyaAQ6+wAx5sbb8Db4RKNaIUL0pM2peRWwPgu5x6En8m51YO+kpqP92ucep
	niqg8SF4eZG2sZ7h+Tvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyb13-000106-5c; Tue, 26 Feb 2019 11:35:17 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyb0v-0000xx-14
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:35:15 +0000
Received: by mail-oi1-x243.google.com with SMTP id w66so10039407oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o2O4nftI7EUiVu0gZW4PMSggC36F4VasZbmifgPoWuI=;
 b=oSEifZp/drYM6UAtZzkODb6Fme2qWBjRjalIncoKTROIWLd3c28661ftn7p4Vxgrrp
 68Yki51Q9gE4tjUZKbagxC8zZpT1/JbXtSgTMx7o8eYKf6+JwEDjaHaivWIzCSG8eBXg
 U1PdqkLPF8Obqe+mstPdmGYBryH+qmIEKVHYoWU3QIrhU/oNp/UuOzScjr/mDuz3aMsl
 xd2dp/kwyWUxgUpAkbTsJ0Hjn4qlylkn/l7y7/M4FE59otaYx+iVMgdu8VFQkRlHRxsy
 ULhwmGTrH+MVRFuEWlkMeqQxk4euke/tkQKvEKL/nrZ5jnd4n0UiCus5yDSp6OiZtE3t
 o5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o2O4nftI7EUiVu0gZW4PMSggC36F4VasZbmifgPoWuI=;
 b=U7NFlsjuEHhISJt6NvMTTGqY8dukQEuikMYzh9o1YVqsOVHa4bdFijiUeKwM7GSGiM
 nEhXnJaWcWju8cbmITZNASuNHTqTBm8G9YvzoOz8k6UGyBB1zzBnfhPstsra0jsvk8Ma
 jxB/J7av/NN6fTgyNR6NQKbyCztMPuOF2XeiF3yH+AzbYZK/+UNvIWACkgHX/N3gx3Sw
 AAhHGe4pNVXa6xC0DtghN/ZKs/V0TeqoqFeOTQElFKvx/briYW1GhneMj36HE/D0jipC
 vicz1CjoPT9UO3FkqYuzKN20kZ3VZ+a4NRiFvFEyQEn4+r4iLP9ruKxco+2c3XHB+VJI
 +JvA==
X-Gm-Message-State: AHQUAuaTJcuuRllGSm0uKTgV7rk8Xx/XHsvuAyN3K9vl/Sn10LkvTpdy
 FLgQXfuVzLS6Qbm81Pw2Q654YE9Zt5frwQF8zxNXq3UY
X-Google-Smtp-Source: AHgI3IbKPwklhiU8ydtcG9noJ5jAfSbJJt0doWjV1xUv77J0TeuqvMwZuPTLw0jnup8jiC83Y/HFzw03nBMA/0qmFAI=
X-Received: by 2002:aca:bac3:: with SMTP id k186mr2059688oif.67.1551180906897; 
 Tue, 26 Feb 2019 03:35:06 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Tue, 26 Feb 2019 11:34:55 +0000
Message-ID: <CAGUNXRQk3XwGr+LJO8T+m5sqJPSa6r69qqS7r150Rq-C4fuEnA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_033509_073625_FEF18A6C 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: Rob Herring <robh@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Abel Vesa <abelvesa@linux.com>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 10:53, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
> revision it will print 'unknown'.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested on i.MX8MQ-EVK. No idea what i.MX8MQ revision I've got on my
board, but it shows 'unknown' for me.

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

Thanks,
Chris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
