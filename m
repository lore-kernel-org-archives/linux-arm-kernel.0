Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E415C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8C421B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZ0BDaSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8C421B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xfmwr4OvGsh6KnI3JUXBKIJhm5jupprntrW0BNc0vbA=; b=rZ0BDaSdLyzQo2
	qAKDaihvLBWPPLWrudQsl+YSdq8/POI0zFGgdujxkeLxGRdaIChxBbAhoz6iAcM1IMuYzAKawzU3j
	kGlw7m2GP/WP6CfXNQPgq1b1fOQ0YECyFPBnqYEvKnlA7BiYGFDan6n88Rkb5CaMstIrJ3zUa7q+r
	3nOKDPvJErAnierBt+EHJam8cWA2AIeVS9fh/jWGq9OZCy/Zph/25BPgrcxo5gyqhZF8yFmYADLnX
	ga5u1j75ap3+43wGi7V/wPaPSvNUfDeuLiCKHjuM1dm0MLAi83wusZT7xhmYiReYu/A+fbEE4Dhak
	NUM7bwVjBUYoRhCIqI1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugbA-0002Ft-3J; Fri, 15 Feb 2019 16:44:24 +0000
Received: from mail-qt1-f179.google.com ([209.85.160.179])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugb7-0002FI-AC
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:44:22 +0000
Received: by mail-qt1-f179.google.com with SMTP id v10so11557641qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q60BJ1d1y8oEzvaIodbA/xifyUjxKZuIgEUeDDLJwsQ=;
 b=mVtYmHai8/o1/GRouagrUwGbGW9YwIztWOxHcf9HoA/qcLGSKu3RYJYIcthF64StQc
 //LsY+lqY2AKUj0D0MZ2kOcOgah6+Udy2XGDipuKmORLus8/SMEYMsN492vzj+R1iD2s
 8MY8Gbt19xwmRi2zEk6o+bz3ZsuyIhWJpQo5qEiHj+7X2cC2rX8vqLbK/bgCv1r8JwPi
 IkRdxHkz1ZjI1xwV52I16FsW8Hcb1S6mW3VajhDMd7jfnoNqR8zvN9eceMcl4z6kT82p
 XAY5k0JdTiKLv40jYI5f26qBYOgsTHe7iMUeZw7qsy8smAVYUAHMh9EfdbzXUDYt466B
 RAyw==
X-Gm-Message-State: AHQUAua8aaz0rZN9gDK832zzR1W3kU41sPbkqJMhBIOC3xamBodzfknD
 WMlzl9Q9XJU6h1HKfxHjSMNJBRinHuTKNKlx4KKwgA==
X-Google-Smtp-Source: AHgI3IZtGhsy5acwyASJwIrXMKlBgiMBU09kcBOCncX+EYallZwjBySqe47JuVeV+dJ4jGvLqtJ9XjThsI92uBt9SLU=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr7798585qve.180.1550249060051; 
 Fri, 15 Feb 2019 08:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20190211195448.19983-1-krzk@kernel.org>
In-Reply-To: <20190211195448.19983-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:44:03 +0100
Message-ID: <CAK8P3a1U19+EjyuZCESj0zj4CRTUpGKyMP6_rk9QV--FdBGdcQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: samsung: mach/soc for v5.1
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084421_351442_2708B972 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 8:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung mach/soc changes for v5.1
>
> Two fixes: one for handling timeout while booting secondary CPU of
> Exynos and second for S3C24xx DVS notifier.


Pulled into arm/soc, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
