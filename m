Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993EC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84221217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVvzbqfV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py5iQJGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84221217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2DgJVwrLnwJowQgg3kH3AMcfEgwtt8f3xDhii/BJnwo=; b=MVvzbqfVk9J1tz
	oD01WE5fTqqHLlaL/vgCO4RgpywEbecgskK/6LiG/e7J6k+Ou90Q7+0eFXWkkvv6mIj+xJEjNHV85
	i+Mw26r0HWHyKsd28rIoyu7TrsxGbU+r/LCdTKW1MUf8YgeqRgMqISI/GfemPNUviVKNqfxPSvVnJ
	i/2ZezjHDDwH90pN0kN995O/Z8bd4KUTXnr4g1Q1Ep+IaZF/6njdbhQPqGcMpsBPiyjHQkSRx8Y6X
	qSRNTMkUxg6vAyHGQjzcIQ647wD5AuEY/Y8h5ePGaS6wX1jOIQeM0PWe9g8szgh2gmViyUUtuKlfE
	vGRlRBlhlHv/t1jInt7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9Js-0004IG-M3; Tue, 05 Feb 2019 22:35:56 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9Jp-0004Hn-GO
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:35:54 +0000
Received: by mail-ot1-x336.google.com with SMTP id i20so8777860otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DhSzsx5n09KOXy4oehQ6Vp11eApZl8xLa5hJcu+sfC4=;
 b=Py5iQJGrKoFIYbxLiwhLDAoO8X1Yf9UMxsG3o+ZJhllMhKx2cF8mQMy8JBmVJz2EKw
 tEswTia98bmF88HcFS6yWCs4hcNkQx3+L4OsGctb9rR3FaKTQdk+fRMQ5OMppyO1qKBx
 1rykVdkMHtBMdbAfGVAyq4OqQBBghHwhME1SMcgNWi3sDXhjIYAvIWHS2B/WDcN9QQKh
 Z8PX9hhL8tp6z9nxafMjINF47Tg3bwyZMyDl6LzOHCB/fIT9ZkO8kTMPtTYBF0UrZ+xy
 aU1U2lr896MREuTBYAkfHQi//bd5qcFexQr2Q+9p2oqciqIrRPSRKByIniN2ACKqvJ61
 YEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DhSzsx5n09KOXy4oehQ6Vp11eApZl8xLa5hJcu+sfC4=;
 b=RaeTvlnzG4s0QSA2KfMtnM8OdxSoXeNohFr78s1PPBRg/TYkxAz2DpvpyndhiRZy3M
 CYjb7SbwJ8a42oYSkj6kwAwHxiFXk914QVytrLNLF7cXWSZMZUhuxBPj4lHznj2nTlFM
 9oWvf+AdpQZn/w7OrfXac3ril23iYVRHe+SqDROmKGOnfMTQL+QcG4iwY0rN6rKIGjSV
 2geaBTV2/F56zrhrPiRbuUqq1dZV2oATHmzfSL8MqVgBzNio5ylU/qWPX+mmx+Caxn3V
 C9MbCCapnwsO2AwBmGMnutg16YXP/RIHk/d//XQF/H/0vAHpNr2LlrVQ3IE3ZSsxqHPk
 qqyg==
X-Gm-Message-State: AHQUAub9EpBDX0QAIJVHdBEi//g4n7Z29Vf9nqIGArTPR9rrEQZRbCvi
 lbdA3sm19a/5qKIH640NY09GH6cbQbMN+92PrnypKQ==
X-Google-Smtp-Source: AHgI3IYPYFWXmrqYQlXm5eJvOOgD/Uko56pk1fZuXQXWTKPY4zaojPIkfro6kv/kumGR6l+A1GhJHRNYtYmXBe4KlLk=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr4160232otq.255.1549406152604;
 Tue, 05 Feb 2019 14:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20190130192102.7065-1-festevam@gmail.com>
 <154940574088.169292.15304825462770873584@swboyd.mtv.corp.google.com>
In-Reply-To: <154940574088.169292.15304825462770873584@swboyd.mtv.corp.google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Feb 2019 20:35:49 -0200
Message-ID: <CAOMZO5BYr_JXZ-ibb5JBvVtF0=Y-cz+qNsPHd0i-kkrC9Ok4ag@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_143553_568110_32FDFAA8 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Rogerio Pimentel <rogerio.silva@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Tue, Feb 5, 2019 at 8:29 PM Stephen Boyd <sboyd@kernel.org> wrote:

> Do I need to fast track this into v5.0 final? Or this is a non-critical
> fix for something that isn't used right now?

This is a non-critical fix and it can wait until v5.1.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
