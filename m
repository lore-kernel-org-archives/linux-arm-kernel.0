Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF3E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OpKp4yNS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgGZrhsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF3E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RJ14HbMhQnV1YxsIsbbCvKQBVmSEi1d8phUjSK+1vss=; b=OpKp4yNSOwOsvd
	+TyIM/r77lOGvdHAATwuYdnoHq70FEUVSOU/pzYzUAIClPhscRiKVyYwoEti9QDvCEhmyIeO6gcRW
	c3cvLjMAcCLPBjZJCHTsrLvedRIpTc30wxnd8GfPWvsTkaTspzK03Xm9qxIdPv8HTMkam5LMJqSd3
	qVbPiv1L3FFpGs5h7uGRpLc4OdjKP6DeHijDkLqL6sJh98aSFfh1ilhtgRGGCUSZddzEe+YuqZLcc
	cDLFzr9kpToSBTwwly6zny1+0CHmhICAVCGTGIH0o1dCO1eclPx/dg6bgjNZpb8bbA4Oq6apYzdu4
	tXfoir70UJ7edgNsnEwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUW7E-0003r2-Ns; Wed, 05 Dec 2018 12:17:20 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUW76-0003px-3H
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:17:18 +0000
Received: by mail-ot1-x343.google.com with SMTP id s5so18384918oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q7F4jQAxIjA2RYWh6EUzGOSX9EbmUsbYMsDcO2KLINs=;
 b=VgGZrhsRVeU/6A2RcMbQhweMi79hFv2fFfUHRuKNz6j7KN3HtD6nKu9jodsY1wYA5b
 W1ymYB5/UJzMCTwZNn+ySu2GPMr/yQcMAXIojGt+mFktzRl9tH/UEAOY7i4Obp/7HCdQ
 Q9MXuvKiznQY6Fdkm/A4fxYHT3blxITf0/roCwI4WO+sKwWEjiSOFroU+mjrT6B0O1Eo
 jjJi+aM5qsbUJth2Bv9Ni4fHMA/ztiTpHpOsC534VX/ZkCXbgat4A54xoQvont48An+V
 YigLk7K2zD5kcHGbPCy0fLNlpSW72Iw8IvSkTkeYXWYkREBqWbyZJcILy496HCFZ2ZKf
 /HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q7F4jQAxIjA2RYWh6EUzGOSX9EbmUsbYMsDcO2KLINs=;
 b=qa2TpXzD/Uv97jGWeNYYgAX//ZOwb2+vs07zddNgvv+I/61JkHsIwbBdAVsSKvsYbr
 Gt0f3OrLj/PLPcqNe/zIZXy8+gfwhcgM1QNxE8KbKzJbB7JYL0+6HvArgjg0GDa9+uFq
 4FyAVGloP59G94Doee3hTVYpqpT2WBNl6tswYnQXv+CNHwvXefV/uXlgkUpbaphfGhqK
 ppFQCazNgPA0Y3fOev0UwryA6xfAlgqB/ct2Q02WAR7sTFy7Nl/2+nl649iIkPoFTQn3
 QicrualXB0P4O8gsfs7XydF+PSwXUoNuMPtohgGlKZMim5aFrFPNDYMLPpRRs2DW6uME
 bONQ==
X-Gm-Message-State: AA+aEWZSAYp381G52GV4a5cI/JrGQWlsiJMVVh/ACPv7JfUF7rYQnn1l
 CFLn/ZKPJZaGGirauiqypeTXOqB8tYHQOp8ABVc=
X-Google-Smtp-Source: AFSGD/Vl+mXhnfICGBdS/GcvSRiJEIFuEHs/maZbKOrzhjjL8KexX3YYDBSUtcN7yyVqYD/1mZ4goGBEky93+maNYhE=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr16537778otp.225.1544012221012; 
 Wed, 05 Dec 2018 04:17:01 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
 <1544001240-18622-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 10:17:05 -0200
Message-ID: <CAOMZO5AC5eACNK8n1Q6iSmah-Myv3sKka253JGRmSg3cMYKqEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: add magnetometer sensor
 support
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_041714_071741_88E953E3 
X-CRM114-Status: UNSURE (   8.16  )
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
> Add magnetometer sensor mag3110 support on i2c3 bus.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
