Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE05C2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eOaPgDnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BNj/QrBeqlmB4TM9k4nN5NlYaWvAmQRV08YGRMzHCuo=; b=eOaPgDnYM8uCFc
	tMoM2pavMau66s2JfeBCK3p3v5cztxwTfBeytRoGCEPB127E5gsu9d2NZMC8B4WHqjg2wjWHvM3k+
	/VpTovOVsAuG0o2tFZF75lfPeXKFInpQye50EB+T+mnNuEjZDUL0wRyQeltVbRHmlPpdGxsDkbJme
	bGIhtNeNE7ndzHv1HON5nY9DjkW+S4L3/prsiJGxecqZbR7UuJhls8odH9TdOpDbEAK2gOVSXADel
	jEhy313C4pV3V/3WvbbwdVI17CHpZdhl8Gk6UsRscnKVlVuO91IXTY9BKu97mdDfQfzohGH+0OfPc
	ioaXIdizVJwSt8EUIs5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbKa-0000j5-1v; Wed, 05 Dec 2018 17:51:28 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbKX-0000hq-LD
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:51:26 +0000
Received: by mail-ot1-f67.google.com with SMTP id k98so19462118otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ibqsYSKAoSqnlOjk4KKyyzbiSkCmLucodSv4g6hHtWo=;
 b=r7TlI3JAyw5ZCKdpAmVzl4ODkn8VtxjlQdODNAQJnS0N60ADuIfCr7x/C2P3BoGkSe
 +PxHPAj9ZA9OJq67H/8lzRwOzRu/i1UxNPCcj26U6L0PRu/lnd7sFQWbUpfAqWgfnUC0
 Ufdwfvz8ZOGlbDrBmXMfLZt5a3Pd0ZyQT/RsHKBvX7PuyMEPydMAXMXJrsXZCSAHkItx
 XfW3VUkgXktdrNXJtwfXIUi+zRRHTrepPAyT8gik6p46Kjysdah6bYk6kld8TDCLvBFH
 N/TfIIkoAGkiT2DdnBicRQugy/hYDx36pn616w3nOJZXucAGgrYo13UW2iL2r3wlUsFU
 1zfQ==
X-Gm-Message-State: AA+aEWYFgoaPNtaO1CuyGHThaCDgoIY0zj/QOpc7pis4HMM3WKQqWtcI
 e/Qdqm9bFqiFT58K8T/STvnOLtaZoNs=
X-Google-Smtp-Source: AFSGD/XR6iO4WLwnEYJ5Nt4+e0Wzb4u1LMNQH43DGWVTqEp1GxTHPdMbvMaL2j7mh9T9aNQceNbcXg==
X-Received: by 2002:a9d:a2e:: with SMTP id 43mr14686544otg.8.1544032274377;
 Wed, 05 Dec 2018 09:51:14 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id v3sm29143595oib.57.2018.12.05.09.51.13
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 09:51:14 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id u16so19451740otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:51:13 -0800 (PST)
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr16231441oth.338.1544032273394; 
 Wed, 05 Dec 2018 09:51:13 -0800 (PST)
MIME-Version: 1.0
References: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
 <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 11:51:02 -0600
X-Gmail-Original-Message-ID: <CADRPPNR43D4jhcdMigUz3-CrNp4VEhUJmsZXofha2kY+gkLsoQ@mail.gmail.com>
Message-ID: <CADRPPNR43D4jhcdMigUz3-CrNp4VEhUJmsZXofha2kY+gkLsoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on
 dpaa2_io_down
To: ioana.ciornei@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_095125_697975_F4999260 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: Horia Geanta <horia.geanta@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, youri.querry_1@nxp.com,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 5:21 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
> object. This patch adds the necessary cleanup in dpaa2_io_down.

Applied.  Thanks.

>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>   - none
>
>  drivers/soc/fsl/dpio/dpio-service.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 9b17f72..21c3e32 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -160,6 +160,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
>   */
>  void dpaa2_io_down(struct dpaa2_io *d)
>  {
> +       spin_lock(&dpio_list_lock);
> +       dpio_by_cpu[d->dpio_desc.cpu] = NULL;
> +       list_del(&d->node);
> +       spin_unlock(&dpio_list_lock);
> +
>         kfree(d);
>  }
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
