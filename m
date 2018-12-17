Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DEA20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GNImcMDA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcGK7U9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DEA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Mn5UPykLPMophBR77ln+h6DmG/mWjZnP2do6/3Nla0=; b=GNImcMDAZCPvs9
	uRrMJZwlDT8KVyyWNZy7E24vpJ7YtPa3kOOoDvzG2ZYsWP03rTv+jxjiaa+49K1iWgzE6CHyIvY7W
	09r+1og1mCtnOfYXu3pMZDU2OiYLII7Sgq6uPD+Dul0mgM5VSBbilvN6dPHCvJYwGGu0QA3NTF8E6
	P+GS1f60ebH16jAC5sE8TibKFiCwMnm+crpuUkSBnV/enMqsv9rImNxTqZNnNulLAuR/R/IWZwRPM
	7ss+VwxAn6m/PMGBxuj+/Ok0IiAEdw0/eF/eZTh0MtFzn4RVa1PnIedLS0yX4Xj0B6ZCXqkB102eC
	YasbtOfSAS4iMpWDTflg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYnVb-0007uF-Ri; Mon, 17 Dec 2018 07:40:11 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYnVY-0006aK-5e
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 07:40:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so10189959wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g1JxZQg+zDQ3RAd4cmu0CH6qXDipWJuyunzbnB9nuIk=;
 b=bcGK7U9p7mwDNnXmL4yzQOLDwDc0EbGtZhr5UdbwvSXq15lfTTIttcrHhQFkWNa8xN
 H3U+Aa676djTRk+w8Xprd8eeUiBquHEkKp/CG4V9cSdOu3FRfMp/ubFQ1yIZJyjHHkcM
 qpnmLXxNiyfA7iqTxR+R4ZA303AutwGXnI+vT5kyz702mTx3j7UFuq1cJMqJ4mBc/9sz
 QtIGtDaVjvQQg9QKmXaWTY+owpM5sSsSfb9UTqoSZDt7q6t/Z5LW+jyO2umLEfOpxfe4
 A0g4BD8N5uygG+LCOQOuU8Shn/UsrPX3QPRXlSqUf3IRuBPoG1iDXV7+zPZ5OjiLH80I
 KEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g1JxZQg+zDQ3RAd4cmu0CH6qXDipWJuyunzbnB9nuIk=;
 b=Kxo57/K5zNU3KCfDUd9To2rYo+VQxXS2ZlTI7PR8Y8AyrJj1zVWcHWsLB7mEBh1OTO
 pnYZLLACJy0YMAqeXdc8k2xl7tOYfmrF4ceVn9rhibXl/+Mp6T32jRVuDz7oCWpGNMgx
 o16W/eR1ElwlDayykUdWYI5SXLhxUu8u06ojw1CjUJyUxgLrSyqVqJXI8sRLn6rfuj6Y
 WAPsPEjYhGSsZdxhIgYhe22ZWbczJEnFpaGVwgVY7wxzQ0MQkNv1NLZGm7zBd5/XAuyS
 r4+pCn9eauMr8mm4o8liOTzY1UhtgomIZxA/HgXo+yZQuFFhxytDZ9VhiPCs4/w9iNWi
 4eIA==
X-Gm-Message-State: AA+aEWYdge39Or4m2YBi6iluLC8IkoePTjOVvcGa5doSBOdwxd3ViHZ5
 3dX44TelaaxewnNAKijXOYfeC1/mmp/a2Jj6KLU=
X-Google-Smtp-Source: AFSGD/Vbhh1hBt6KIQSgBwWCQJSHTVIFVysQ2lpnc8gKRYwDGAlE2Og6ESZsTg9/OPWcMUlu0Dx0rmULs5QzOaCLBQQ=
X-Received: by 2002:adf:93e2:: with SMTP id 89mr9945808wrp.129.1545032395385; 
 Sun, 16 Dec 2018 23:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-3-andrew.smirnov@gmail.com> <871s6gahvh.fsf@tkos.co.il>
In-Reply-To: <871s6gahvh.fsf@tkos.co.il>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sun, 16 Dec 2018 23:39:44 -0800
Message-ID: <CAHQ1cqEx=jh86AkOhqiOmEcu51x-FMujFAsMiGgq5=6atvUXZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To: Baruch Siach <baruch@tkos.co.il>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_234008_215986_471300D3 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-imx@nxp.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 9:03 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Andrey,
>
> Andrey Smirnov writes:
> > The driver now supports i.MX8MQ, so update bindings accordingly.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
> >  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
>
> This header file belongs at the next patch in this series, right?
>

I was asked to move it here, see lkml.kernel.org/r/20181211224349.GA30397@bogus

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
