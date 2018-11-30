Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DDC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EFB20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7zk4lso";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fgA9Mxzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EFB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VbPd2GMg28aprsuiLE94pThuTUQViJrurlSlXjvaQSQ=; b=c7zk4lsoOrD/1p
	lZDYU2p7IEIGr4KQSLml009f/l9kBa3ncBs6352+mTRtn7jh98DiuEuiPIzLReEvdzABstCbl89xg
	neeuzDd/pW3MZLf+FhEpeFhtmbygrUB8dQeVlmm6lmfOeguXJ2QrWbAXwkW13qD4zpHrlZEX3V9ns
	6CF20Brs8bQGjOGQ6PhWl9Ohnd8nEjopLS5HVoE5bfgNc1YsiMwLurw5+yv5ez0ZFTpZsZ7I8zU0H
	w9H+hdi4j6HiYZKvCWFEyJjxfF6wWT+LFSTufCsUftNI9VMrEXvGSZ2OWiIztYwYrE+/eE47Zy6wU
	T0GY8y5jixIflPZzJ1PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsh4-0004OZ-09; Fri, 30 Nov 2018 23:59:34 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsex-0002Oo-0o
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:32 +0000
Received: by mail-lf1-x12d.google.com with SMTP id p6so5337612lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SRUg4teIsAzKhA2GzqFrwwTPvHJ/4TlCsX9XzJBGB40=;
 b=fgA9MxznYKgmasQJl87t7RiJZ8uA8Bpzi/fBpMMc2I56uFQ01Rz04hcM6KARW6oqLz
 mosUbgfcOd98Fx4IeXcybSmAqXd3Y07+uIZ1okmSBKRBf1E5vu+7KIxLNmhzUC6gMMnZ
 sscsQ5lvsKZR/IgJnSKYQrGMFd2yxFOmZpWJdekDi+LXYPQK7Y5BbD4VEn6k62xjOiI9
 dUG/vdaIVKl3yQkvzGPNkHAaDvz6YDtBb4uiZQ3PPjejncyrGAyZDjU3oEj/EviTgffz
 9vdM2h2QoCvtCw+XYQ/9lE0ZlUW+k0AWGPrqEnq6OLeAJR3PBDr2gXD7enQ2VqWCvUC8
 4Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SRUg4teIsAzKhA2GzqFrwwTPvHJ/4TlCsX9XzJBGB40=;
 b=plZMJlNqoUCzLBM0/dXyEebcydGDxA7E0KH6CVxHSxVAX7vWGOIsd2CpJO0MotWWJ/
 7G0c34Edg+lDlcfog8avPGWpDihmoljrYDljvFfcFP5kxgMD4wbPJKmPWsL4ZTHu9bpc
 Gkz90A5AqoBesLhQFXMM2SCJ2vcU4/L0j/+29c2sor/6LnQqz7nGXXU3qCGBAFpYQN1A
 Ym2GXPSY91P77zhYBbSRJZR88wGQP1Trn1rZdX2MVioD2iOqXIcw7rwBShdgO5JpnKax
 Yp/UE3EnKmx/8ZJeqWhhNUFlMtnwQVXujAwOfLuLQerAwGME0VFEPCGENytPdHYATajJ
 XrZA==
X-Gm-Message-State: AA+aEWbU5a1RRpjIbYWGBNwgO7TQywuvy9rR41ACOWmJI43zMsDT3O8z
 m/NJRkwXApMu8vkE2TY6Ag+MXg==
X-Google-Smtp-Source: AFSGD/Xagp7p1T7PVDYOyorH8s+A7bwy54Qhe/6JVG/PfxPW1bhEpnt7GQa3ncMymx1m/iL+HPSrGA==
X-Received: by 2002:a19:2106:: with SMTP id h6mr4603498lfh.29.1543622231008;
 Fri, 30 Nov 2018 15:57:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id n16sm1034940lfl.35.2018.11.30.15.57.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:09 -0800 (PST)
Date: Fri, 30 Nov 2018 15:38:45 -0800
From: Olof Johansson <olof@lixom.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
Message-ID: <20181130233845.ynd6dwf45jdh6hbr@localhost>
References: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155723_500634_3729BBA9 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: linux-kernel@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 12:04:03PM +0900, Masahiro Yamada wrote:
> Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
> for accelerating the SD/eMMC controller drivers.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The insertion context was decided by savedefconfig on next-20181127.

If we apply it now, there's a risk someone will accidentally drop it since the
config option is coming in through a different tree.

So, please resend this before -rc1 so we can include it towards the end of the
merge window. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
