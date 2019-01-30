Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC5920881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3fhPuZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC5920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7o+ltnxgSNuw+WluOTKmWvEcSfiLYnSpkVIZYeDV/cc=; b=f3fhPuZRrSfgh0
	G50pHG+NOMiQszvbFDRH44+X1XCV4UGR1TQQKv6VJ4xxn3aJZrSunG7E39SwK0sRo3W+M8IWj73Th
	oEu/CQuTYtSTo3yDr087FjobAzwKosz7WL3zQEWBT6wLa6MUHV6/4REZxLG/fpksHp2AcAjva48nC
	hHbb30tOwvsx4svfjVrJ0TKtyQEVuLc/revRMKNVKx+xCWRMS+SH79ixOv6ja2WYIFOphQd0+Kgji
	b4bXzrkkrmK8aGiFsw2PGZAOKwDJ5AMf0h9HoOgjTqSu1yvpAUXlTLGgOoNEMy0IZG2+QdCQRkc+n
	HJsrFGES7Uh4sgKBNFnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxeV-00087C-Jn; Wed, 30 Jan 2019 21:44:11 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxeR-00086l-UM
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:44:09 +0000
Received: by mail-qk1-f194.google.com with SMTP id g125so709778qke.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kswaJEimFuVpDnW4dMVzOTN4P+ueZCKccCEk7f7EXy8=;
 b=VEZsuhED/UtlDkN1ZOJauxcEMW4ZSD9l4NHM2Hpb+csdUZCQpBSTXKEYYYTdF15RsT
 rMCj0NznX+FW2vARdzcXVrt4fr0bfzWuBRsrYN5rw+CUj7U4uic1NCQkIXVbDxU8eF+W
 fXQC7MBz87kCpIlWCbny+heUNouOiCpmGAVSprHI3y2aZh25t+OpUiPuyDxv83MdhEb5
 9E/Vz+FIMUDwr5nlWwl4BM2qGkTDY0H8oQ/hgWOZmLvAY5npVqoLfTBzPLH6iZB+bmX3
 cYoqqA3Zp9t/J1bPo9AxmFiQchSvozTRMP/uwNJbdbcUuHSuhIQXA5ML7ZmPy5z+qI7g
 WrKQ==
X-Gm-Message-State: AJcUukfRTPjxPBPcm73ZfWs/+80VTauQyaZWbhQtCP3i6OFxR9YJy59t
 axwOJrwjeGMhHTlp+ljVR/tWtzbTEtaKVUjOWws=
X-Google-Smtp-Source: ALg8bN7J9Sfxhxo8n+SjEZNSaiKO+8DkhUYDSnK3NXayFto/wn0YpTQdxh6nabEcX4e5Niq+b7WwR6vVy753SDcPh7s=
X-Received: by 2002:a37:9a89:: with SMTP id
 c131mr29361398qke.173.1548884646776; 
 Wed, 30 Jan 2019 13:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190122110912.31134-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190122110912.31134-1-ard.biesheuvel@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:43:50 +0100
Message-ID: <CAK8P3a3sOdvhULfmYDYOut+FzL1EkUPM7F2+qawP=me566YgmA@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable GCC plugin support and
 structleak plugin
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_134407_976982_1EAF5D8A 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 12:09 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> Enable the base GCC plugin support symbol CONFIG_GCC_PLUGINS for
> multi_v7_defconfig so that builds hosted on systems that have a
> supported version of GCC along with the prerequisite headers will
> allow GCC plugins to be used during the build. At the moment, this
> will also enable the ARM per-task stack protector plugin, since
> all its remaining Kconfig dependencies are fulfilled by default.
>
> At the same time, enable the structleak plugin. This plugin ensures
> that local struct type variables are fully initialized, preventing
> inadvertent leaks of kernel state if such variables are shared with
> userland. This is a reasonable transformation to apply by default,
> since it does not adversely affect performance, and does not affect
> GCC compiler diagnostics regarding the use of uninitialized local
> variables.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to arm/defconfig, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
