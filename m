Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7F3206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZT72KgkY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jibAHz/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7F3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cYXUCUovAxIEtiHPskdgGEwdtJTbbUcK+1Rwk5sk8kY=; b=ZT72KgkYE6XWTV
	KkbdvytgE+lSbnNwDBPQ63eeQDVBJ8WDUnUKYT2XlqqOlnT0DatNA6XGEY7xpMCl0zGxUudzeLLw5
	o3MZ6js2nNXNfPeh4NIseE+bGj6srmfGJmc5xdEXTMsfaitp39DzqAu4R2XwzrEareVgkSqLJWELh
	7zL73oJnjIqPGaRM9ecgNZJGiuYpn01La3q+yLiKETODFCDVKIPHtM6jjOlULS//G/j/5PmJRVjRB
	S9KDRA7Ac6u307Pub3b5scin4ohKlwSTKOQEQPZOlCjfV4MUHasRdkZgQWO60aiTmtXSoCnvkPP1O
	53Xi7cICoVMm2Gy6M+NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0tz-0006k4-Mf; Thu, 20 Dec 2018 16:10:23 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0tv-00065q-6j
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 16:10:21 +0000
Received: by mail-io1-xd31.google.com with SMTP id v10so1197320ios.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
 b=jibAHz/hWiGisigzXIHWT63sOyQ3Yo5LngmujgY08aJgD/3dKw1xfQjkD4ddfIIvO+
 gXPRicj8aSRaHyKS7onoovZ59mikIniaIdsynEzp/r8JMFmala/rz0Zg1d0/rQdjLhVu
 uVTaE9zkZ4wQSlG4Y/iB+AOysIerrHwFEg+tqaucITBcsU2xGtTur+dfGm5foFffjiuK
 8FcqrnkzexIxJ02ZEWRdoYsoax0jXxoVNA8FMNvg3Y81tEqCghzwKqO9TJqQm3dck8d9
 PDx0QrKYLF5LXQGFzlQK110xgSHU5meHyHwcwSdBSUxur+cXpVkhfQVZIKY+eEuho2xZ
 laBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
 b=nrtMiMvzYa2MwmmbWsncJaH9HcbX+Z9AHPIoU1rmFwZKZme2HJnh3zCpiRnYd6pPNd
 PPvpuHXQbpA+s56xT/dn+EqCK8DaaslfzeyHNLDPVafBYOd+F3C1n+nf8Cpj7CMw6+Hn
 jIUIHnb8FevRY6IZirH8+yPSYVuNYMcrUAq6iSTG3acZ17kPaAdyS0uVR+kQdz/Dpm0V
 AJjTp7F4YUi7MCrk3rXuJiqtUadspz4jUEPjSUHBkG7VjRO9WOwNW/bfstqumPtdF/t4
 EQSva01hemBP+icFhId2cThMXDutlQK6g0+R1hyFgSgToOPIkB+vuVQQSBLVnhMQxXpd
 vUSg==
X-Gm-Message-State: AA+aEWYzOmyEuM69ZitvdIm6E7d6OwSwYGjqDSAm+0RJk3wMNHf0M41L
 9yZJl6A9L8yMKBfMAr9RfqfBAy1LRgUMVBeOqZlTS2Cehlc=
X-Google-Smtp-Source: AFSGD/Xb54zM3zrjZTrzDO9vA+Ipy3Vcv0RE3PVhkibl9KaBlHgE00bJPoJ7axfBowYkV/QOLu4sOLq1PGpU4ZAeEEE=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr22049626iod.40.1545322206627; 
 Thu, 20 Dec 2018 08:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
 <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
In-Reply-To: <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Fri, 21 Dec 2018 00:09:55 +0800
Message-ID: <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_081019_249230_AFD20965 
X-CRM114-Status: UNSURE (   4.67  )
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
Cc: Lee Jones <lee.jones@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ping......

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
