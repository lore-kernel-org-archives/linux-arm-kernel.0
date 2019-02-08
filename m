Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B6C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:15:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B0021920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hdnsN62/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCYYlb8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0021920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fZc4usD7HbXKsMQOR7NWRc9AX/GjYntNMq6htCOH66U=; b=hdnsN62/pGsDqL
	irReq2tWR7FvqER6g10RzrlPGU07fChmOSotZsy6Tl+QmGmxHPeh2jGB680t+fKbAYCpfOss5S7az
	xnFFm745CdQnJoLPy/ty61Yd/sSZPbc02aO8iRDGHnmhIuKqpaFj4NOwE1hex0Jr2HnZtlAPMN44Z
	/9hyiUUZL+VDBwBNDtlf49M/Ktf7jf9zfwIoTma2uYXV6aUmCcViRFs4F0/2of69vb+0Aj7m+R5QN
	CS+1bIWb07XniU254FnztREOThNRrtVov3vl2Kq9OzuxNkyEmo51GQ6mhRx4OOwzW/TPwsmXjTzc7
	WbceVTJnrclUlsRRDOXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs1Je-0003x7-KX; Fri, 08 Feb 2019 08:15:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs1Jb-0003wo-Hr
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 08:15:16 +0000
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E677121916
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  8 Feb 2019 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549613715;
 bh=XOLF9xV4M15uvNkhw+DCkMazl2OsiS1cGhHcsyThPrs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MCYYlb8wLlhpT2rCX3kishdPZ1r3mTUFGGRFR+1H8I9qr00jaFrqJhXQU3OYEZ6eH
 xh7e1PhontCEFstc1Pc9NZD+GxSgFJ3NDkqV6dK35l8Aa9WNEiFV7HFVbNtVQhzky9
 +eRntSCzN8aVDmw/jwZk4nM7Jx2b6+d5N7sNRlcc=
Received: by mail-lf1-f47.google.com with SMTP id t14so1882910lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 00:15:14 -0800 (PST)
X-Gm-Message-State: AHQUAubCJKCLc0g/IZQ0YUBJywZs6U7a+bBa8bu89YH+NKFWtnVWqHBa
 /f2qjzrXihhx+tKrU5fwqRZ+xyJVwpWn1a/+ijE=
X-Google-Smtp-Source: AHgI3IaJVJsD3NixG45D0R51aHwHYz6l70pi+46b6gTAPlFDhPB6+YCoF03aHzaiKhcvyfsYPC80xFbLY7tEkdXL1SI=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr12221134lfe.137.1549613713228; 
 Fri, 08 Feb 2019 00:15:13 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164723eucas1p1ec009489584e1c85fd0d62270796e003@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 8 Feb 2019 09:15:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf5_0eXt45eRmiXCvVhmKTOFwTFpJ4SkP=yG=5_qc8sMw@mail.gmail.com>
Message-ID: <CAJKOXPf5_0eXt45eRmiXCvVhmKTOFwTFpJ4SkP=yG=5_qc8sMw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] ARM: exynos_defconfig: enable DMC driver
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_001515_609863_36EEEB34 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Enable driver for Dynamic Memory Controller dynamic frequency and
> voltage scaling in Exynos5422 SoCs.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Looks good for me. I will take it after driver gets accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
