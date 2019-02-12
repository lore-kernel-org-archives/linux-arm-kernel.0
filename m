Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:37:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF771222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uO1u7jiN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fFmqVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF771222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ppYjuuD2rZcrpBuxAMhp6XEMZvWNeHgU02EATqeeS+c=; b=uO1u7jiNS/849Z
	cDcoA2UDPn659fD4f/mAeYPCTieoZVDGEd9z45nMoF0fLN/oyZIcy0XojjZKiR1h/numfhDnHMD13
	VxA5MRDWawPzJcfXNDgTxyNm4rlAP2hKqTA9ktCLFFgt2s2vbXi6W/yrMr+Tr/c955OJ156Xoi3oA
	0VPEWpTSsEpBEmGsw2nIvSiS79yvIERF1knbEi97FleB11eUfxdQdMviQITsLYDcgGacZeqLLvAIc
	sedIq+UYdlgl7t6LnnmEkpgDy9ty8e0hKuHjOYXRBNHnQDg7Ucl0p0URwHJMZ6X6mmWw/8nFiDEsj
	hpi8LJbK0ZlDP3TO3HHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtds7-00023W-OD; Tue, 12 Feb 2019 19:37:35 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtds4-00022y-Hx
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:37:34 +0000
Received: by mail-ot1-x342.google.com with SMTP id z19so6505885otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qh8jXx9ibl84fm0TlhJ9Ot1OoKWuqLrxObimfZxMuQk=;
 b=e2fFmqVTst9k54mscSZoNvZFtyO2UOA4SXGrFUpA6ORORAV+C1v81iu/gjEIClGde6
 Hbfo8P+4CcZJjH3tN9gLQjZIA1+/F3FpajNmKUAGz3HkanvpI2H6UNsC7SJYcOlb/CuG
 gPIjybczMXPAHcoutR2jMt0QBM5N4YHBPwHF82+K5geDnc/fynzmhgeRyCk+QYjmiB71
 yuo7YA2Mp623gIS0IjU/nyGuEiDray7QOrI6w6b6o5N12Be+VF9xvS5J4bffw7O8Jp87
 vg+0B2/1qLNx3HkcYZ4h6nPBZyv0EKF7XiyBWLV9CazBgDvQ21mYsb1FagJfQs8WBcM/
 HtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qh8jXx9ibl84fm0TlhJ9Ot1OoKWuqLrxObimfZxMuQk=;
 b=b11mRqwF9rklL7lrybRlwrVUIDEgLmdihHAAToUv2C1vqaecUYnB4Hfd+K/nurG4JQ
 v+bMUxvugCuSyg81PffouZYVEYaz6pCJ85TdnmOAAB+Cz21zw5/hx2zk6ctJt1v/NJVN
 HNyIisqBjz5rdWu3xEFfR+e/BA360IVI5GBF3ePkT1Ej2sh1DXso00AfE3ycd136vLoT
 GZK8RgihmjGa8HmjmxAA453xO2925QcRS9wjIxo49+seBmlsRCxGtjdeC/TMr4fcRdOI
 JUASIl6V1BtHY4sIVNWj4s88HzGYHhp2vGo9eRFBKcfTHuu5bI8AHIhiPkSabBzJVa7P
 bnJw==
X-Gm-Message-State: AHQUAuY/xVU4Q1EcxtUZY4f+D/wGFA4wM9htxVSyHLIu7BRiNjEnCxoz
 mXXCznoLKrUe5VF4yLhW/hhsJrmLCc9P4Y0fRDE=
X-Google-Smtp-Source: AHgI3IZg2Tty+buZahU39fVemS7bKOvdrXaVps2KARCkUXOgrYO7IyQYHaP2MOm0efGPapfwkQseadgme6cLNbkJ30o=
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr5692051otl.115.1550000250644; 
 Tue, 12 Feb 2019 11:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
 <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com>
In-Reply-To: <1549923727.3075.103.camel@impinj.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Feb 2019 17:37:18 -0200
Message-ID: <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To: Trent Piepho <tpiepho@impinj.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_113732_619385_E47DB450 
X-CRM114-Status: UNSURE (   9.04  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 8:22 PM Trent Piepho <tpiepho@impinj.com> wrote:

> > Just trying to understand if the SDMA firmware plays a role on this
> > behavior or not.
>
> The ROM firmware only.

Does the problem also happen if the external SDMA firmware is used?
Just trying to narrow it down.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
