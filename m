Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B994120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JgpC/es3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtGjyDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B994120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5njXRb9jkKWE8tPVN6Zz2JOb/3ZSj9czsdDo9143mQg=; b=JgpC/es3UmvxOD
	b7b0fqO/hSOld7T2ZMhJ9jWGA6WKYn/cKcwwVIm1tQk6erxPqVdIJzFAom4ukt8Bz4o4Z6iGPDwdR
	r/YllQLRwlXpkRZaZMCaqqJTya9arN3aeX8tiHUFFIJc67E8UdyUSyAa+wlyyp0R0CMUuQl3KPMLY
	du5YU+ZFomvcb0a0+Eg05Jdw3Gw58EXii6ZfCCfhxOh735kuGxggQjG4tXOVzXxm9FspV1/0MfKls
	+ujgk8aoB6Zyjfd+YsoBs9GtuGC+a23Kke2ChWqgxJzYiolulYmVdc6rLeQHjO58we12ISoNeGqXZ
	fEQedUj4ER9bsb+uklhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUW6N-0003Xo-Au; Wed, 05 Dec 2018 12:16:27 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUW6H-0003TY-Vb
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:16:25 +0000
Received: by mail-oi1-x242.google.com with SMTP id y23so17337935oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SwKVrTYXLSSMg9QL1O1AmfDRatCuJQyQS166HfPNS7M=;
 b=RKtGjyDMSe523r3Rps7iqbn0zHshUrhqLDoOy1NGZQ57vIbpvWYr2G+kPzlE8K2ySV
 8llrCDDPHI50+Iz0nbKuTZbiMYpyO5RZuZQjzlkwTYa+edeVjJcxGG+aapHk3zMDhIlR
 Z9PH8ukbC1u4dcFWI2A0AX3PzPrjOgULurbHHoG77h2V5xceyT+6CYhkO91LrGIu9MFd
 EY4ExMYf85Y76+k1H+scoXuxJMxI/ghKNcNdA2FcSNtbRaL2kinKg0MkSZUzghcS9k9X
 Hp9R7g3iB2p+O4cSO9MYAu8ghFRM/Xj9EuRAXy7o+CKCJD6XfdgLe+rZm9AmiVvkaEdD
 ygAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SwKVrTYXLSSMg9QL1O1AmfDRatCuJQyQS166HfPNS7M=;
 b=YVy9kCu54A/z0e6JoE0GPt60ICWtZnXF4Juc8Tn9kLo4KZiMzFRBzKh/bzLcIwCHYw
 1b+1xn03QQwExgCWMzPhghvYNhAQZY7L3El26Zsbcmvpe2Qrqm6epM9U8JM1d1hyDBEC
 JW4IfsSZY2LtK90vVyHSuzR1jr14p7md2zg9lSz1HilLpmZkr2azCNT1tSY88UNQOVXX
 zBBgKxO19/oZ0DcGQNtbQAw7PzFoe67J0f9G4OwdZjVZslKdmCWPnI+OBcYDpFD3wE9o
 6/IaZJ7SxtDO5vu1hwTIXWjRVF8Cv6AsZek6/mTXJWpXlDEkN2yh6sHhrB71n3Z5XIPd
 IvsA==
X-Gm-Message-State: AA+aEWacVT40yJS2LfpzQ3/stJs8A51XOKylNspfmCw3W62A3uzv70I4
 IEneNz8DnN+DGV+F0xe+A+7/ZDK9w/3/UgdQxhQ=
X-Google-Smtp-Source: AFSGD/V03BYC8tHjs+oQl0Za0OfM2LtyUlKXvDI4QWATi6Fpa2h1HZ7SUjRUEKY/0XUnycM2Yn7V803pDFsbWPf8wlc=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr2825735oig.266.1544012170975; 
 Wed, 05 Dec 2018 04:16:10 -0800 (PST)
MIME-Version: 1.0
References: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 10:16:15 -0200
Message-ID: <CAOMZO5Awn=KcHFFpE3Quo5BXkqTmVXjz9udrR0KUWUq3e8UShQ@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_041624_669125_910FDC21 
X-CRM114-Status: GOOD (  10.17  )
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

On Tue, Dec 4, 2018 at 11:14 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add egalax touch screen support on i2c2 bus, it is connected
> to LVDS0, while the existing one on i2c3 bus is connected to
> LVDS1.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
