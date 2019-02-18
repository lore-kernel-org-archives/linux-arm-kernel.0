Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB20EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:39:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD772085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgKpJYKz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhpHm0wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD772085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aFwMl6a1uowrV1sOxbq3SONXfxjAzTLA7zObez+kIgw=; b=YgKpJYKzMUQohf
	giwsbyM9ziRiDguDA7gZRhXEJj08L4sy7qwzOG1vIJ72Qf+soaawHqGi4SEOGUn1rPV/PPhUeugTB
	BV/HnZ2/+jSLJl31oaRZm4XwF+CBBc3HUmVcRbwRzstoghFGGxrp3MAzPKvAaoCvb8OSAGQpEdu18
	6zVh8liw0A8LyfdlrL0lLR/VC2HT+rfEgrZjcPTQ0b/ORPwGQrkrcS2HyFLoam0Fn55+149irU0jm
	teVbRtQbRHbbmJbZefulCSjT+DtNdL0Kulr1EV8nf7eVV+p957sVpy6oOHrG/si4lhEWtTb8qC1pa
	GbLMrDMjiRyvl4lVzSiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmsr-00049d-VD; Mon, 18 Feb 2019 17:39:13 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmso-00049C-Q2
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:39:12 +0000
Received: by mail-ot1-x344.google.com with SMTP id v62so20779386otb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lPq6JgeJlfOMlBKr8ZIokMvU7bEx60jWLuEjCLYHXhk=;
 b=DhpHm0wYLnHUorR/3WrCDfKq2c3Ghx/69RD2/XyERQl3YCHA2Ss12fOA2oq73hstcj
 qTJFOf8zLQm03aBjvDMl0ERPeRcmW7d6xsD0SA05UtOgoWmQOQOLHPPh1Cn/zZHsdME/
 aonl1+jW6W0AMxl45ZGVS6yOJ9ZTtEYLoWMzETQzYQf4RaMU2zLoT0D+YymQJAVLreZM
 LrTCXUhO+gLh5ev2SRVIuSX2Krtzs9cnJl3VR4pJGB5Zpa/BIjdzHxANzgFe3zWrhVFc
 DP/dhJ9fZRzxaycUmaQ+q7VQUmuulyGvBIsGN+5nR13YZg7RT+pEN7bm28BBZt4KlBTv
 Bw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lPq6JgeJlfOMlBKr8ZIokMvU7bEx60jWLuEjCLYHXhk=;
 b=m/37KCCwPGxKfWjxCUGySdolQrSnEyBW4QqcSyjEqL6pO2zGTNaMdMS7qBw8P6r8DH
 La4Jz5YSWQLtZV9SV+3O/JZDuDdfgWDheHqlN85lWTgYGEcv3VXVk/3qDZQjt8CLPq+I
 R0JsirN7qK5CrV8hiCso2ek/ERE/TGxPd5mcDrkPERbk2DqZVDkflI5sVX8odG/5MeBV
 yYz+kP2d4+RDZkxSxs3F06bchdpzpG6Jb4PKu+KdiUA+SbwOGaAra9zbvaOft8WRlqWZ
 98K150lyq1jYz0swgsoIXuVhglTJkVax3LV+uo+6A1lBgvqEPUno7Lx5JFV2OLlmnO8R
 mqrA==
X-Gm-Message-State: AHQUAub4HPlXI5odBoRJjp/FpNQVs/g0iZIUdkeFlraXw+2pSKf+RLa3
 yobJlN8xFvkyClQyzENlAzjljxPOZ3L6Md9vZFUzDw==
X-Google-Smtp-Source: AHgI3IbzisbKYiBbpKJ6BH4gJB0buX25wt/UQdgOW8/7v7QFH0QlZ4s3wl7+RtyWHTyOqbwgbfHQi5LLQtn9v3pyZ24=
X-Received: by 2002:a05:6830:1547:: with SMTP id
 l7mr12050435otp.196.1550511548045; 
 Mon, 18 Feb 2019 09:39:08 -0800 (PST)
MIME-Version: 1.0
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-3-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550253761-26841-3-git-send-email-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Feb 2019 14:38:56 -0300
Message-ID: <CAOMZO5ArupZLgfw5abDdrBFK4B2s0vC7+g0H=oZiYMwn5nHSOA@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
To: Frank Li <frank.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_093910_863485_B7C3D9DA 
X-CRM114-Status: UNSURE (   7.15  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 4:03 PM Frank Li <frank.li@nxp.com> wrote:
>
> Add ddr performance monitor
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
