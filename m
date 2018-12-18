Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3449218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOodOyB8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7PG1sjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3449218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wucWN6k/UFj0IApOl++IwBN3ff95aQ/30ouzqfv3iJI=; b=bOodOyB8sEfGoc
	OzplLP6HvxJxBm27QEqIbqjrydSLuOknpsKNwjpjv5+zXE0XUfW6HiaX6SBrD2/pOPki3TagqIFoS
	0qauATIEBu7wwh/7+Q7OYGhtPWwlfwpk8yvBF6EwNmylLaLiyBg/OGpkoURyLg9iikFKkvn4Gidr3
	rZYRHG6IYAKeqarIHgZHvPECuXFczKZRpF9u9P+dPOb10wlV0ntMd2shuo7NJAL9nrrVh1HqIO2Ei
	dGm7xt1dickeNJKU7XLQTyc9G0d1DtOXT6sJUmAUvEBxRDtxx/70uGhJCBbfpJFuFZDppeHYBptl6
	KehPe+w9Xae8vwrbvn1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJtO-0001Ii-IM; Tue, 18 Dec 2018 18:14:54 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJtL-0001H8-ER
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:14:52 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so15929445wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9R2IW6oZdYoMQnsGgIcxUNJDJQzxyJljdHvK78FWCkA=;
 b=J7PG1sjF/DKDNf37b/jiAdN9FsXoislCWpZKSmqTg59jTqSOw4IFGgZL4T21rWi+ne
 OSzzohKJ0UEmooMBKQwy+gPJxhnItMmpxgQ2miU9KkkMN3hdNbJxqh76+R2skeeM+PGY
 XkUzkieBWMPbeBhPirBFKrTYZU5CjIZ0K7cNf81XcRe2Xwl1JNUjaz3QZfEIcnkkL+nO
 Ajc4fqsFutmWnXzzjZvJ+gqOm2mTV+bgjxCYuxbPK6CQ6jZyoRDuuhjaXF5a7K3ZAV0d
 Fs0x3LuqOsFlN+UplIFy6Zfg88Dd0w+SIv0gf22SghH7OQuPJKOZF/kFGRqJnJDXuvSL
 /1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9R2IW6oZdYoMQnsGgIcxUNJDJQzxyJljdHvK78FWCkA=;
 b=QldGm72WbtKFh8PB5nTLgTkKSgErTMvORldRjI9EXonFplHkBZk3KN2/pmBzrMgRHf
 09RbopIbT6FzOZaJb2NGUU8jINXF9GW6s2fMa9AsXYzydYxAzeY5u/UCCl3jiQ4lyoup
 8HKPqAmmTk1WnXu4iDXU77SKIsjUbUhMeuAlbEvbfQxEZ5uH5nQ3J9kOWmjcx4sJJLfy
 VbjXztYXLgQB+Yf/xYX0tkog8ZsUuhbWjCk0x/OuuuDPOisoCW1y08M4VPYlekGFfaOq
 IM3AO3A1AxsswLA0aElSca4LaiUkdFWjzVwID8iiflH7Xq+miwXcRJh+NmTbpegW+ThH
 eXAA==
X-Gm-Message-State: AA+aEWbG/kPAJptJUV+8Hp7zx31XzNjU+toSChJhDHDny617Yy1i4Rlb
 Iyu+TFmr9Qfv1BuLpVUod5a0HIYe5MChFdeSY+I=
X-Google-Smtp-Source: AFSGD/VmznuWHRt96sVx9keiQwcyhuA6Esgym6fwwg1RsaGDNCrX6pvn56l1/7ZID6xQthzVSKUAifRoxzOE9dtL5eo=
X-Received: by 2002:a05:6000:51:: with SMTP id
 k17mr14844433wrx.259.1545156878056; 
 Tue, 18 Dec 2018 10:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <8149d09e665c4a4efb85a9d60f266d478bee02d8.camel@nxp.com>
In-Reply-To: <8149d09e665c4a4efb85a9d60f266d478bee02d8.camel@nxp.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 18 Dec 2018 10:14:26 -0800
Message-ID: <CAHQ1cqEw47XSfNnohg=VJdQJ+fF-F-nucNm=Qqu5Tt-tZt2-PA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_101451_489131_23FA7A69 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "cphealy@gmail.com" <cphealy@gmail.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 1:34 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On Mon, 2018-12-17 at 20:07 -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
>
> >  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> >  {
> > +
> > +
> Remove empty lines?
>

Sure, will do.

> > +     unsigned int mask, val, offset;
> > +
> > +     mask = IMX6Q_GPR12_DEVICE_TYPE;
> > +     val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);
>
> ... snip ...
>
> > -     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -                     IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
> > +     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
>
> Maybe setting port type should be a separate function from init_phy?

Sure, will change in v4.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
