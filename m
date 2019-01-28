Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618EFC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBB6214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLTrG/rx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPaSY4wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBB6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MKfxfxT35xZ/P1ZuVLH6l3YLCsVKZXcv28NJ/slktIk=; b=DLTrG/rxbKPelX
	qmqxW0DnJaoi1LeH0iepilVuxqezyliVPa1MqPIcWH/rwOxFyxQqY6T8qqf3pPjWTEWJJ3cormN0U
	5O02PhRqjyosqKqMpbDxe27CD3D+/32WVlzqMBGCC0Zrtjgp0FSg/Ycv2I1iHF5cTBSgn80SPHFu+
	r+x+Hr22lfPMKx+i6KItzG38KN0Jo9Pl3JJi5dzYiR93vj0YWDaxUuMtolJJb/J1oF2CQ/vm/NRZY
	s8oRmy4FzI5u63Vy+3RNWaP9ogsgc4V5nVVPlqgF+yNWwsdWOHKiGAZ+HGSfQ8l2QYl88IqTdo4/p
	PYYSxDHQQVyv0X30VNvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5l1-0006zd-OA; Mon, 28 Jan 2019 12:11:19 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5ky-0006zJ-Tv
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:11:18 +0000
Received: by mail-ot1-x344.google.com with SMTP id t5so14429953otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8zzLz5K9EZCkeJgbzDbTXIeYF1Inm/ZajFrbCMNArDY=;
 b=DPaSY4wApav+cEiwEHB7kfKykUwb7IzhPbFHwHE2qQON9GEDl0QfNDtLuXC/3asK86
 XNFAWC81BKHUsA3aQPNW5esjjMxOd5+J9uiU/AF5xLXE2AxKuP//0Kkmef+HYR6nip1m
 arBMCuQdCFUULPy/bBfcS2ZR9I0gStX7xssomxx0b3cA8c87Vqz/EtJmqzCGjQDUNtB7
 iK+kHGTVZsSbiwb7bi3Ms4cUfDR/isNchbbEZvEDjlP3fHD5GVYjAEw46/u+PdmgD7+5
 9ZUIVykF9O7njIQa8A7Yfc/TP89dzxaRpNoC3V8RVwbR8igIDfu5YZZo+v/GzRYKPWPl
 vVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zzLz5K9EZCkeJgbzDbTXIeYF1Inm/ZajFrbCMNArDY=;
 b=S5hp0a4aa01umgbUG+8x9GQ+WD0+VtMUkyDWmRP+FwBNQ9eXD5x2gnOZ5hmRZipP3H
 0D6YC0GyMwz3WsAhYUtlMAW6+yahoZ0wAsuzw0OoBSL3bcLl7nZ45spfK6dHVUzyPDmP
 ghS6I7zlN3wZr4PX8gOuydfGXq5yAINH8V/1a94w4vtHJ6u+KOtp5gsFXqYSfBpMfGGd
 ioddhj8+NwcQ6nddlphzph6mmti3T65ZWEgixXHc4BJn5ZvhdGIV+iry/sInBCcX3WH4
 hvPRZ6KvBwqOKllUcWxyYqmJgC9S/RWaHdQBNEjoi68QZ3UtFJIeG8Qln8JpY6QLgBQZ
 OCog==
X-Gm-Message-State: AJcUuke/m1voZ4GWrF0GXr8hceuArEEx8G/u6phJDeWmM7qw+9bTzDkw
 tAGquZQu42YJcA8THJEZUqxbXkS4gwkEPqRZ8oU=
X-Google-Smtp-Source: ALg8bN7GspEdGDbIJcwJEicreJNKSLEmG4qAQqE1R594ARw01Pb0upM4rjlqaLLSdn+kDCGtlcdXfsgRj87QVxbfCL8=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr17382719otp.225.1548677475800; 
 Mon, 28 Jan 2019 04:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20190128095212.14681-1-ccaione@baylibre.com>
 <20190128095212.14681-2-ccaione@baylibre.com>
In-Reply-To: <20190128095212.14681-2-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Jan 2019 10:11:09 -0200
Message-ID: <CAOMZO5ArN_xEDaJd=se=WcGv+DoFr4KRzoS7CZ_YcieHxuexAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq-evk: add missing MDIO / PHY
 nodes
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_041116_962743_0FA7E865 
X-CRM114-Status: UNSURE (   7.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 7:52 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Populate the fec1 node with the missing MDIO and PHY entries.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
