Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638BD20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XODBDAZG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1iTC/pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638BD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=shXQetXFOEnsVawYBqnj+ZJJUzp7Tb9GQ+DFQULSJzo=; b=XODBDAZGxT4pCH
	1wdT+XlCNSkkj7NOXz6MoOzZI9Yx6hSKx8t+/mcDY+DoJ45cc0iwKuk9LOaiU0/Qn1ix6lZPm7JpP
	k/HZ1Y/QrGTiEdvyrMFdYEShVE0DQOa2baA7B1AZiw84hKlbFF1tw0L+NnxCZcoqy2Y8T2e/Qx4C7
	B/pv1+c2tbY3E6wZAoS0x3Lz3qgJgtFRAxGVOFBc07pLb+PjptSGhRkWy3FrR+Hebxr+isRookPtw
	hV/dJ4QxbTjOscNwpXr7i7blOuIKffOoOVuypLHSQ3nayiq3Iw30EeJ3a9Guu/4p36hD+SJfDdS3q
	1CQdfEhE3KQHOC+EvOMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY2Py-0004vA-On; Sat, 15 Dec 2018 05:23:14 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY2Pu-0004sv-1C
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 05:23:12 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so7301378wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KyWspEE7w1VDTUfQwdSqFJ0hR2sxKZBxKf+M5Sb4W1Y=;
 b=E1iTC/pWWL9NFG/+C9veT6qo/owl1NsXU5dWZJSG/P3mFupDnz6yJE12IMhNiaeh2V
 6GnuiVUGBZx4g7e91iqQaHmK1ciDutVVoaRjP1SyYxdntaY8hNS6GaBxZwCYvs2DTgrj
 WFA5gSZPteJPBFL+xI3cD9cxP4s//0BN6u34Xym/KqFiSaVY8QeFr60juCGBxx20NfWc
 +0ivfy5UfRaTTBohiooe+6Kvs81NCt8jBmWdgfHT8bMC746LPf4GWYtodiGY7Xg9MBzQ
 j4ApBjSb18qcRUNexPanqz0FZ5OmFdS6qkXxuY523y2BfJ81CLlRrMSBCwVmJDNRpt9w
 5EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KyWspEE7w1VDTUfQwdSqFJ0hR2sxKZBxKf+M5Sb4W1Y=;
 b=q90Jx7XR5EzqCcbgauuHXJh3Gi4YlCvbFNKfF7TUBilt4UljJOK9XnowWy7lEWtCKs
 aT+nQ1S46bWZQkqseSDXYIJZ9Wc64UvJYZoIILmbbd9fld2dhVZ+XDBCz6ifWDQkbYGV
 URHJFeExoXk8s3CSGeUQRAc6ftALRc6IHfCvv+M3ACjxTUC8AhfOFiLxOOuca0McvguM
 YHm6g/0gLfHKDFclLHA0e4pQP8pRc9jN7H53TEhGKR3lwrvzoYZeLgmeld9KucxLr7Gd
 I0/+7DpT2wHc8oNTjG3xKfdgSsJjIOPIxWcnn+l+Kkd5HoCFRN5fD8xdiqQxh71ytFxC
 C4Sg==
X-Gm-Message-State: AA+aEWZ06iXSggCagr0WcFB/90nZhFVO75qdBO5IGFDGSaHm6LQlUvxi
 nDJn/yumvEYLfzZrt8PAWS9b/kZNmMC6ik/ZdUY=
X-Google-Smtp-Source: AFSGD/VRSQTo5WD9+hAPfM0qo2Hf/qVPtfMiRICt0flGweyq+C0dv7LDbTJzYYMUsxsH+Iwn/+ORMq94hyroeDmjX1A=
X-Received: by 2002:adf:93e2:: with SMTP id 89mr4694110wrp.129.1544851378092; 
 Fri, 14 Dec 2018 21:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com>
 <20181214203042.GC20725@google.com>
In-Reply-To: <20181214203042.GC20725@google.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 14 Dec 2018 21:22:46 -0800
Message-ID: <CAHQ1cqFFm_YJne91yKVHWhMZY0KhpDfN0mbWL3YECnMo14JH4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
To: helgaas@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_212310_077495_7274DB5B 
X-CRM114-Status: GOOD (  19.81  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 gustavo@embeddedor.com, linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 12:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Gustavo for fallthrough annotation]
>
> On Wed, Dec 05, 2018 at 11:35:45PM -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
>
> > @@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
> >  {
> >       u32 tmp;
> >
> > -     if (imx6_pcie->variant == IMX7D)
> > +     if (imx6_pcie->variant == IMX7D ||
> > +         imx6_pcie->variant == IMX8MQ)
>
> This style looks like a maintenance problem: the code below is probably
> IMX6-specific, and you should test for *that* instead of adding to this
> list of things that are *not* IMX6, because that list is likely to
> continue growing.  There are more occurrences below.
>

Makes sense, I'll update that patches and send a v3 out.

> > @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >
> >       switch (imx6_pcie->variant) {
> >       case IMX7D:
> > +     case IMX8MQ: /* FALLTHROUGH */
> >               reset_control_assert(imx6_pcie->pciephy_reset);
> >               reset_control_assert(imx6_pcie->apps_reset);
> >               break;
>
> I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
> this looks wrong.  It's the IMX7D case that falls through, not the
> IMX8MQ case.
>
> The recent annotations added by Gustavo are at the point where the
> "break" would normally be, e.g.,
>
>   case IMX7D:
>     /* fall through */                    <--- annotation
>   case IMX8MQ:
>     <code>
>     break;
>
> But in this case there's actually no IMX7D-specific *code* there, so I
> suspect the annotation is unnecessary.  It's obvious that IMX7D and
> IMX8MQ are handled the same, so there's really no opportunity for the
> "forgotten break" mistake -Wimplicit-fallthrough is trying to find.
>
> If we *do* want this annotation, we should spell it the same as
> Gustavo has been, i.e., "fall through".
>
> Again, more occurrences below.

Yes, definitely, same mistake of mine was already caught elsewhere in
the tree https://lore.kernel.org/lkml/20181214144406.0dbffbc8@canb.auug.org.au/

I'll fix it in v3.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
