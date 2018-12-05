Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49D020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aa8Q17++";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6PNciP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49D020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XJSWck8ozO4bufAOYUeh5UAEvAK3Sb5a9ezDA/6iv0=; b=aa8Q17++jy6cGp
	h4SxXBTZp/c+J5bQA5zptp1faZqGVXpTgXBb5eC4FQ8woq+MmUZ12A0uBj3TfzxCXSYWydpHWIkSA
	q682K9wDqqMUPB8gDQ5Ujf+Qne09YQX6HeQFJqykDVy7A9rswkuxFlGs+ZvKWmOk6i9MRpDjUO+Rc
	RwQuxqNE3fx96ZatumqXG+vQcRApIevjjZQSgA1DuB/8VhDWrSqsmN1X/ZD0WGAtQg5F0EThNIhkI
	MBtJReCCd4PFQBPrGWTFRZ9YkXsjdTIZAy7T1FIy5g47DZ35g1dz0r08xYNbQPMuaALEQ5v1rUVqY
	uJ6llkT4WzkL2gMQt9qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUW7i-000482-BQ; Wed, 05 Dec 2018 12:17:50 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUW7Z-000430-Hr
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:17:48 +0000
Received: by mail-oi1-x241.google.com with SMTP id m6so17294252oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vCrUJs821Yu92WMTz2CLkV1KZsPO/jLYFCnJEtYDGJs=;
 b=q6PNciP0arUTM+KUnKhL6PiyWHixa+HWqMqT4KgOKm677hgBXyo5glgDWmaLsu2zgQ
 IxmPwWDF8ajLiBfa1IzjL4P49V10zyxTbyA8YJ6hCcMalMxI6KVECtz+oBOVxMLmCJMf
 W7BrA3/ZQ75FDHk1FW6k+QeYqmZ/uILoHDPMUBivH1v6QJ21rO++DyApkS7R/UGWw6NX
 8lbzW6bUG20C1OfBVQX+WFahYQy78wa+dcIOxvthAXz3DtySylIndnO6Yo47MPA0CeJU
 Yddl98uBgjAwmrxZWCkF2vOiJibF2gZy8Q9dz72AgIINJf9S5bgw1nnjO5HgxJndXAZ4
 DwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vCrUJs821Yu92WMTz2CLkV1KZsPO/jLYFCnJEtYDGJs=;
 b=IggfVI2mDzPb2G3nsqLNqQxc0NceByebR7RJhoZXKirGJZ1SSStoKnb4fYF13pX2r3
 ku1rFfjdPLy+/DukO0YPnapxPvyale+FnA0+xuhdzwVwn0oHmkJtsUOpa5HPc1nd1MLJ
 wVzJotJJhJWWaGxguVSH3y4ukn/TxxHR++qsp39fCr3hOqa+cb99qrLR7DYgBpIdof8M
 EmzjdgNEHmJZKwmaiOJ3aG63myaUEfhEpXnFTCDtyKNwoQxwajoVavtMQs/rMprBgsAA
 J7WBcl9oxtIYBSc5+i3bp0YlnGdyvHcR1YpkbvoTKDUHYdyY/AlTOE9fHAVAKKsIp0y/
 FHuA==
X-Gm-Message-State: AA+aEWY1XokPLZKMlouc4deh2U2n5WSJ7ymvKi+0PMm+hooxxfzsMmz0
 Sv+xZxQjYnIXT/fXl6paMXT4sg0quBjLJ0xC++A=
X-Google-Smtp-Source: AFSGD/UDvORwQm10nk95tzk4QaXDBYCZQOnzawIrVCVqe5MHi/jElNZWzRUg2rwcyNsgYPf77WNjtJxnRPBrhbe7H1I=
X-Received: by 2002:aca:d056:: with SMTP id h83mr15495745oig.67.1544012250786; 
 Wed, 05 Dec 2018 04:17:30 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
 <1544001240-18622-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 10:17:35 -0200
Message-ID: <CAOMZO5Bg5=atQhEro+8Gjxxbu9Fn_MTZrsVBLotwxVy4j3XDAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6qdl-sabresd: add accelerometer sensor
 support
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_041741_588780_460C7C06 
X-CRM114-Status: UNSURE (   8.48  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 7:20 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add accelerometer sensor mma8451 support on i2c1 bus.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
