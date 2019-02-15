Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A36D2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhaOcTWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A36D2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8J5MVUEVK4SEkNGYvkuoCjlSGzCM2Nb/G1KRpfAGcVg=; b=QhaOcTWN8zZ/Ur
	Rnku9t+nyp1z1fOUx6efDXkIqk3WNDKkNwex+Atrl8pIVmDlV6ydiufZApoXVNhrwCSSvwJjmtw96
	2frmwV1z9v8VKIrxiICPiUIaqgVioAcsYo2EyzYvdatw38rp1qc3dS+CcMUpwu230zxTCtdpeF4ka
	B5LA+IKNFaNEN+qAR0hr1vOsj154EDXwSN4mUu6ND/aNjGG9yPXDNNW7KEDBwb8cCxflW0TIiq1EG
	mlPq/nXN+USAqx0u3bUPc87ZH0OiFqqCv5HsgGWpjY5sHbpyYLW0op7C7m2JcsNMhH8McRRCrDIsO
	Eh4kE8QEha8pm/G4dSKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guepN-0007eP-FO; Fri, 15 Feb 2019 14:50:57 +0000
Received: from mail-qt1-f173.google.com ([209.85.160.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guepL-0007e8-0y
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:50:56 +0000
Received: by mail-qt1-f173.google.com with SMTP id v10so11105256qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O/f2kCEDmnvgFzHZJjqu5GAJNUdBlOOsmoL5cL19hzs=;
 b=ajsOXK+CWsHZO/hBl+K561CFGtmxhZvmk1/CuWAqFLb6bhScRUMBoS4aQ6VuhSHcVS
 ieo7lRpkB2jqliCqjAHz59JGSyLBl7Xh4z2ZVxxTu1hMUPt5mmy0XVtZDarG1+O5UXjx
 jd9gCMzKhPLMY/V4OCs14Y5r2oj4nAtUFoKo7gKJyJTka4X2QFpPGOyGHjL+b/5chRwY
 LF8fuyZWMJHojmkqS2+AR+dWfJQQgA14d5XAlPYEQ/DlKnEDjwWTnFgSec3pRGa5Da1G
 eI8qflWQnWR3iR9ek/T/Z/UiKsxJGMT1J+NJ7EKrUSKCWcvftuojpZ3n1RlNJpyHz7jM
 rboQ==
X-Gm-Message-State: AHQUAuYwsbQ+urxUOWeo4c9adhu6PXtn02jf0Kjx0dqJGTGq4mDXYqvJ
 NDaPVh7lJaspWzl8Gc8P+ie/t40T6ovZIKYr6vo=
X-Google-Smtp-Source: AHgI3IZkUdrwFqe4j1CREcQTsRyD6Q9AfhGaWEuwhd7kGMQX4mRlDLPC9DJ+Ijq7nFnl+EXWlhZq1NYHOq5oG0glwQg=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7716453qtl.343.1550242254003; 
 Fri, 15 Feb 2019 06:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-4-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-4-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:50:37 +0100
Message-ID: <CAK8P3a37UG3EGqmkBeiYQ94LOYB8y2ZQKrfhNj8QwUBH=k_dDA@mail.gmail.com>
Subject: Re: [GIT PULL 3/9] dt-bindings: tegra: Changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_065055_063735_77EFECF3 
X-CRM114-Status: UNSURE (   7.71  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> dt-bindings: tegra: Changes for v5.1-rc1
>
> This contains device tree binding updates for CPU frequency scaling on
> Tegra210, BPMP support on Tegra210 and support for NVIDIA Shield TV.


Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
