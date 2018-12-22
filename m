Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:40:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152C62190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4uvNhQ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgEeS0dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152C62190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QuzZqt3ffkM4WRMEBTC511UrLi6ElWFTt1Kw6YmOXgU=; b=u4uvNhQ9FNaf5D
	X/6Nm9hyNRa9paAL58bAPH8OjwYYYcK5ZJuCR/1fN/kbulZ0KlwVSRptP42AJIX8xfnTDvlL0tIrE
	V/INPcotYy0sLNudlXcfz8dqfPiajpE6GRr5sMNulMMD2GMhY1tddB784f7iz8jBH0wHXDV62x5rV
	MVQMNd9DEVhNLuJxH61T+dgBGuXd3nlrWhIo0tITsrt6mxnHWKb2Szr54L1Gm+3fogtlAIT8SmgV1
	JT0Br3crfhni/jfCisHmVrTrkWgLApTeywMsD45SzKGd1VeMi0U7PhZoLm+vBOxi/2WJf10ZKzA+i
	3mVXWNVXqqHmnTB27A0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaVKf-0005qw-Gp; Sat, 22 Dec 2018 00:39:57 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaVKb-0005pG-R3
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 00:39:55 +0000
Received: by mail-wr1-x441.google.com with SMTP id t6so6893173wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RWFx2MmP/okSvy1n/Y6kWzIkSGB2dAYp7bFmgMiY1Pw=;
 b=HgEeS0dMGz395pT2i0wBx7Q4W23AZ6Qb7dPRwg0qmHSf4oACPbr8a7UbQW8KdaKEd8
 xZ9Tsgse76ZopwUl1NRVvYB48Q2QDGY8PY+YiZo1qp3BhJNb7qgunrkIP+7rzIB7f12k
 vVcJH5uUpq8etwmOQf27ISMZTASUPuVYOJ6CdrAzGwvyf0ZkyvtQ8e2aUaIG6g9xP/4W
 AjN7btsM26Zy3xE7cQ2LIcTlDub+eqV9jcbzX+CObs1YJ0HQVUDcu6bLDaojKPcwnJw3
 JBU0msr5u+VxZOHeyGNHqGI1tZaOZtRIyZfn88SeiCkgcb2lZ4faP9icZlzqhzv8/lam
 h8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RWFx2MmP/okSvy1n/Y6kWzIkSGB2dAYp7bFmgMiY1Pw=;
 b=ML0+EKBlEdIXU7jaQpWzTVJ31GtZW3mfS5JqZ1kn7ZPDNn8XWGPvKispnxIY+JBJIJ
 1vjZbtj2NCaCT5JxE/rLK4f1Dqgt4WjCajeieP+szL1NwyGnJvaLGe1ssFynGPg0y6O4
 Xd/UJXfvrpj+ohkV9AI5B2oiQliHgf20c4rGefz34Y/HJUUaZFK4K7NpF71J3VUldg8i
 aMAT8wm0xJINqMsPXp8YBt+Bn1FeofvYn/ghX8b5dfJ6Sd4b36PtbTRm2A/kcw0WpWAx
 1gVtx4E3RUYmHxaXB3fhIsbR9xcq6OCskhO0pUDxd68t9RsQlhyPeNghPmkAX7hIg0uB
 wirQ==
X-Gm-Message-State: AJcUukc2pi0L1jEmIxnSHydExo4bfj0+/298tO8dlaf+qyLlulw9xWoq
 ZtQkhnbZHheFRFndMBGoIuEbGk1l+ksEDJL61CE=
X-Google-Smtp-Source: ALg8bN5oyZu9IUHT2ZeSGIxlYBiw8ezG6IonBuvgn3wPJPrGLUIBRK60wBPA5Nt+hjhlD3v3k3mVGwnBcdc6I9ku2PU=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr4330590wrq.5.1545439179793;
 Fri, 21 Dec 2018 16:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-10-andrew.smirnov@gmail.com>
 <1545418520.22930.82.camel@impinj.com>
In-Reply-To: <1545418520.22930.82.camel@impinj.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 21 Dec 2018 16:39:28 -0800
Message-ID: <CAHQ1cqF_DgxBK7Un5KVoDtsoNSzM0SZvy+6TkV6=ynEr1gDh=w@mail.gmail.com>
Subject: Re: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
To: Trent Piepho <tpiepho@impinj.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_163953_880935_56EFAF8A 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
 "cphealy@gmail.com" <cphealy@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 10:55 AM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Thu, 2018-12-20 at 23:27 -0800, Andrey Smirnov wrote:
> > Until commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
> > imx6_pcie_wait_for_link()") the driver relied on both LINK_UP and
> > LINK_IN_TRAINING to determine if PCIE link was up.
>
> I've already got a patch in that fixed this issue.  Queued for 4.19 and
> 4.14 stable.
>
> The problem was created by 886bc5ceb5cc in one branch and by
> 4d107d3b5a68 on another branch, that when merged in 562df5c8521e, the
> merge kept some pieces from each commit and dropped other pieces, which
> resulted in this check getting dropped.

OK, cool, this patch can be dropped then.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
