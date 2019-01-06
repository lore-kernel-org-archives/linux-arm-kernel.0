Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E30FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D321222AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kGbYGAIs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NMb79ZOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D321222AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TGWa75LkS3oLJ1KBxWiXPMa7A2VMHtexGB1k1IArOwY=; b=kGbYGAIsYw7ESg
	7gG22AEX55Fe0pvbyDwT9NiZzI52LZW7zkDA7XzIrEKmHZCRAtOOu58Ic7VdrKQsK6h3bZJM9p518
	gP/1xwMrhGuVN/WsXl9HpVNEhGZHzNMxjWb5jsdhBaCYiXVx6E5lFP+0Nyo7OGOkpY026X7FiD/vk
	aWmYPHVb5eoF4dCoOa17pxTn7pQ/vXA+TmdMppgHqT03oVntWEYbdSskzy+jBKArCRNd8y7rWamxt
	mVdCUP0g4NgQ0PUpYaXmO4N7CL65g88pockVe7WawGKL/noxE11tgbU3TiKbK0L/y/T0N07tI5pd0
	fLsjdN1IZOBPz6BI08wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfxhR-0004zF-I5; Sun, 06 Jan 2019 01:58:01 +0000
Received: from conssluserg-02.nifty.com ([210.131.2.81])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfxhO-0004yT-31; Sun, 06 Jan 2019 01:58:00 +0000
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x061vW3Q016763;
 Sun, 6 Jan 2019 10:57:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x061vW3Q016763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546739853;
 bh=Ci+cXksoanD9GGaO2bNjRFHAELAMOrzQailOkPVHQYE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NMb79ZOQRE/ukbnmEjDrJGA5tvivz2hGgHOaTgGfdgMT52BZ6MlaAr9OOu6gp/trS
 WRvlISuskTt/C9w/iDminFk/VmuJ9K+4j7Xp/WpUFRpd9QfK1vzbMR5QAeZcE/reH/
 JKKT7xjyR2AjKkSxK7daBO5QkIdGziiuUIo+2zrcX7Pu/9ITZX4x4iiWvBJBp/ogV6
 8/ZxSB0AwO1YKYucspCQrCKcY1jBhBoaL1g5l7VH3ibFUGPMPch9IcmjPm97i9eEma
 aL5xyOpb5aKSxeaSWgIpHUpNGrB3jfSmAjh4fdN0Wp8MEDNtY9uvQkqSkHTti5ld5z
 I9NT5bgUv2GDw==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id d21so13161832uap.9;
 Sat, 05 Jan 2019 17:57:32 -0800 (PST)
X-Gm-Message-State: AJcUukfIHcyCpjS8NyLnen+nK6oqYLXiXk42HIFHsoO2SFE6xJ0vWgEf
 hmPnmxPcz6q6VSaS9A5dKnK5hauY4qFMzP8Vj54=
X-Google-Smtp-Source: ALg8bN6cT+r8bP+L/JY/qMkSv+NJJcFADhHCF/8lIgeiq0xHTMpVWWCrVYA9xZ/dikGtlkLGbnhtFyZaG0ON7Y1HgiA=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr20163513uaj.42.1546739851430; 
 Sat, 05 Jan 2019 17:57:31 -0800 (PST)
MIME-Version: 1.0
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 6 Jan 2019 10:56:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATS79a=vBdjvy18oE4XNOvCTPWwh3=BN4fV2No+VUV3oQ@mail.gmail.com>
Message-ID: <CAK7LNATS79a=vBdjvy18oE4XNOvCTPWwh3=BN4fV2No+VUV3oQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: remove redundant kernel-space generic-y
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_175758_380279_C46C8B5B 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 10:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This commit removes redundant generic-y defines in
> arch/riscv/include/asm/Kbuild.
>
> [1] It is redundant to define the same generic-y in both
>     arch/$(ARCH)/include/asm/Kbuild and
>     arch/$(ARCH)/include/uapi/asm/Kbuild.
>
>     Remove the following generic-y:
>
>       errno.h
>       fcntl.h
>       ioctl.h
>       ioctls.h
>       ipcbuf.h
>       mman.h
>       msgbuf.h
>       param.h
>       poll.h
>       posix_types.h
>       resource.h
>       sembuf.h
>       setup.h
>       shmbuf.h
>       signal.h
>       socket.h
>       sockios.h
>       stat.h
>       statfs.h
>       swab.h
>       termbits.h
>       termios.h
>       types.h
>
> [2] It is redundant to define generic-y when arch-specific
>     implementation exists in arch/$(ARCH)/include/asm/*.h
>
>     Remove the following generic-y:
>
>       cacheflush.h
>       module.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - rebase on Linus' tree


Patch 1-4, applied to linux-kbuild.



>  arch/riscv/include/asm/Kbuild | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 6a646d9..cccd12c 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,5 +1,4 @@
>  generic-y += bugs.h
> -generic-y += cacheflush.h
>  generic-y += checksum.h
>  generic-y += compat.h
>  generic-y += cputime.h
> @@ -9,16 +8,11 @@ generic-y += dma.h
>  generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
> -generic-y += errno.h
>  generic-y += exec.h
>  generic-y += fb.h
> -generic-y += fcntl.h
>  generic-y += hardirq.h
>  generic-y += hash.h
>  generic-y += hw_irq.h
> -generic-y += ioctl.h
> -generic-y += ioctls.h
> -generic-y += ipcbuf.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
>  generic-y += kdebug.h
> @@ -27,34 +21,15 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += mman.h
> -generic-y += module.h
> -generic-y += msgbuf.h
>  generic-y += mutex.h
> -generic-y += param.h
>  generic-y += percpu.h
> -generic-y += poll.h
> -generic-y += posix_types.h
>  generic-y += preempt.h
> -generic-y += resource.h
>  generic-y += scatterlist.h
>  generic-y += sections.h
> -generic-y += sembuf.h
>  generic-y += serial.h
> -generic-y += setup.h
> -generic-y += shmbuf.h
>  generic-y += shmparam.h
> -generic-y += signal.h
> -generic-y += socket.h
> -generic-y += sockios.h
> -generic-y += stat.h
> -generic-y += statfs.h
> -generic-y += swab.h
> -generic-y += termbits.h
> -generic-y += termios.h
>  generic-y += topology.h
>  generic-y += trace_clock.h
> -generic-y += types.h
>  generic-y += unaligned.h
>  generic-y += user.h
>  generic-y += vga.h
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
