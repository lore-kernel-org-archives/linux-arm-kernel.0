Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31592C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:21:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9F9218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jadJBeDa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4HD9FOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9F9218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LCaayu3SLr2LlEfp1iNugHwzUZ7YI8h9VQv+a4uZVwE=; b=jadJBeDauPbLWN
	We/QuqcgmtIGrABXdqL01zQfRBM9ovYJT396VxcpSX4IRaifvoP1Cy73dRzGOoWWjwy9gWAXVCYHI
	F0C9llZC4sRAXgxxMlOM4Vk6uqeBSbTGcuNN+lr63RcX+czchbVR+aY1H5kGXkTIcqhkUROCWdWnE
	jJwP9gAUfxSEMD2mR3G34k+ZDWMLuERV1pyCCChC34KI4RH+5pPMNbPy6aGJXHuGaZMl4oKjouZtS
	mJL7inejZ3cz+IAXh7l3iyZLKshvW8XQfxqRnRwfT+mePeVbAPtJ8zYraxBwU57Kb1ScSiBrs+Cuq
	TaWCkZxkpmSHIUsuwtMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIrh-0005xQ-6k; Fri, 21 Dec 2018 11:21:13 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIre-0005wy-5A
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:21:11 +0000
Received: by mail-ot1-x344.google.com with SMTP id 81so4811628otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NVC3ISHkdstR1OZgFqN4Hqp2m3d03cDIElLAsB+Xy7s=;
 b=H4HD9FOpREPVhnR4ke0wLK313NrnZmM9vRe1ppToUhSVLWWuEfYQgOKz5DZBE0InIE
 OR4OqicIcJQZPEc/jk1BcU8gcJXGKMziH37Zmxp8L3UekFUyyrLdwxdVSqnjA1dGG62B
 yGXbxPU4JPZCx5vuFR8jVyOy8JWWF8/73f7w+7EVTj6d+Vnz9ayc9Lwrt7YqG5d6X/Qe
 +LgL593R03x85Nb8LaKRq4YEQj1BJelvRhzKx9PLykyG9iJjLeu8amEDn/qA6mcsSPgn
 BgdVvs9fZAC23cEDCeiTPmSczM+mQmeQL9Jqfi/EZybf8uDNDqnI9aQLqYaQQIbqzTOw
 ZNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NVC3ISHkdstR1OZgFqN4Hqp2m3d03cDIElLAsB+Xy7s=;
 b=sjeLQ5sVqnEthzCh7xurPCAz40u3okUkzYC/+9+FU/tRujiZckjtnR038foemhDJo+
 6YdfXWYOgpwEENJUOaAnYNNTqVQq1I0cKL/2lvsHSi1zOdQfY9SlaKra+MGH5ICVjkO4
 s3iB+6WkjpccOXWgt+DmwgbKCACeX8gqQ/uY5aecTFHbUsAo1NSKv2PU1TFfJb2wCn45
 9Bp8JN6kx+GXXvvIT1OmdFjZFtrYgfG4liftbY7dWUJGc27EIQWVp3QPlVtohFCOg6iJ
 UPtE+in/0YeTEKVUaja7Dx4sngzxDaElwlL3I4dBNi0MBt1LJug+nLtSl1C5kC1b+fP7
 NTDQ==
X-Gm-Message-State: AJcUukclLZoIYAPie4L5fVsOWGCdvJpTHcC4uaDkb/ot/Hno7FS7sFv8
 OBdzbYhpxIJq+GcCWe31aj2VE/Y36P/+4ca4hVg=
X-Google-Smtp-Source: ALg8bN41MAUNiXErP+o7KKfjNi0LSaPJFTB4+k3D+R+i9J/+Mqm1XidMRjuToiNprgv+wmiNSovll5LG/R8846p2Uho=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr1298675otl.196.1545391258791; 
 Fri, 21 Dec 2018 03:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20181214105510.1174-1-l.stach@pengutronix.de>
 <20181214105510.1174-2-l.stach@pengutronix.de>
In-Reply-To: <20181214105510.1174-2-l.stach@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Dec 2018 09:20:56 -0200
Message-ID: <CAOMZO5Ac0_1QgOUOaVsEUwwZpMUROs-rQPKfasQGCk=MaApWmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq: add GPC power domains
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_032110_225445_D04EBF88 
X-CRM114-Status: UNSURE (   7.69  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

On Fri, Dec 14, 2018 at 8:56 AM Lucas Stach <l.stach@pengutronix.de> wrote:

> +                                       pgc_pcie2: pgc-power-domain@10 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8M_POWER_DOMAIN_PCIE2>;

The address after the @ is in hex, so this one should be @a.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
