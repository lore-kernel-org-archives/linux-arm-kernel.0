Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F2C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0kY6G8A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP/PM6Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Cw/SwPIKg/mPIz0odkH/IGRfra9YlQi6DpR5hc/euyc=; b=G0k
	Y6G8Ati8WnXa78yGTABTNxd5MpSZNlbRxSQgfSMQpirBWHF5O5JCwShaCgn8SaRDlKhKpVtvYqqlY
	RPouuLZV9vrRum2f/ybl8B3BamxmAPrS9duqVi1izT4x94NUfMZNHE5riX0lM6pwczoQJfyQdP7B7
	dyceRKUis9lH+IegRTJhUn08Gej4kWQ3GNcCTU7+287q1wCpfgv2p/WyEisFpQLDNj8649jQVLlGN
	418OTWLHgPZjMPW4ooMVXuaYM2EoikonnAemVooXHr49EfzlyJkY3TTgqG6wM96JIHWaVdfTq4LCp
	Lk/jWIyvRi/7pIUNdDND+Wbb/LWIaDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkR5D-0006t8-Lw; Fri, 18 Jan 2019 10:09:03 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkR5A-0006sb-W0
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:09:02 +0000
Received: by mail-vs1-xe41.google.com with SMTP id x1so8068587vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=n+bIrCa8NP47kNy2c+LBCkgyAzNBjMr/5OaE8AJS908=;
 b=GP/PM6KzhJ5mgHy2MpFiP6V/3Z8fWtWIr7ui26qnGnpyJsgMQsmhG9DPGZJPiGsE8y
 E8MnNBGPBrwMqH5IUF6GdeVgCv8Si72pSI2Oivu5uZfmtkFisV4SbfFKsbgs1iLEVvkd
 NbO61JySwPVYSS87fy+jBN2JeaLp5F1nWMOnzyxBvAzEmF+lgIRl7Ix/dydoLUjbYutS
 Es4zpm7QZHGaurBWOubVTy5C/RKcyl7jX091TgKXES0m3tv4NeZpXVcBFdX04m7C479m
 K+kSbxTk/G5nK0KdyEaFtf2PcAKTvtX9kjgVgq2Gy4lnOSn/d+hhqei9GQUyPqZM7U54
 Gs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=n+bIrCa8NP47kNy2c+LBCkgyAzNBjMr/5OaE8AJS908=;
 b=m8wB4xNtHyoRL9XC4HJ37s0/F8Hluu8v1TSWa4RVs4fO2+0T4Ezo42jGd/cVlxyHHQ
 Kziv9eSfE35zstZWt1nEIpvz9TAcYUxYdrtu64K+G7mfh9yLscjPklJRWyfUgtPwS8Hh
 Pv9VpjhCnf4jJOvP/sfZOyyWBXT0Ydl5O9zMw5MKmnIukoV663IKdPvKY+WFex/ez4dO
 7Cxtjr0ReNbJJkb6h4fy+Zs9ieu6usNcNmREGBW+8bQjyhwMNhmOEiFg/8Vq4u//C4pA
 qEYZSXSWotjK0znB5YTjn4iNOM/3O6u9F8Lk0+qTu+zY19fW3U2nkwZECOXZu/dRpFxP
 Xlaw==
X-Gm-Message-State: AJcUukd2XOzuRTluBatd7dl26ps3nyumYHDjiQqNdVrszaT3V6P3IH0J
 6HIQtoZAe5naxEI6Bx114ixns1AbwIfue3WvsMo=
X-Google-Smtp-Source: ALg8bN5YAP4roDEn+VCrnUhEOEhDQm7xkOO6as2Vt9tet88KRpdW6e+snTl+r440Vp8Jgg3+wEYVTqV3MCJNe50mcQQ=
X-Received: by 2002:a67:f793:: with SMTP id j19mr6892160vso.196.1547806139093; 
 Fri, 18 Jan 2019 02:08:59 -0800 (PST)
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 18 Jan 2019 15:38:48 +0530
Message-ID: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
Subject: Need help: how to locate failure from irq_chip subsystem
To: open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, 
 kernelnewbies@kernelnewbies.org, Pintu Kumar <pintu.ping@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_020901_028529_595EB42F 
X-CRM114-Status: GOOD (  10.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi All,

Currently, I am trying to debug a boot up crash on some qualcomm
snapdragon arm64 board with kernel 4.9.
I could find the cause of the failure, but I am unable to locate from
which subsystem/drivers this is getting triggered.
If you have any ideas or suggestions to locate the issue, please let me know.

This is the snapshot of crash logs:
[    6.907065] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    6.973938] PC is at 0x0
[    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
[    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
[    7.242668] [<          (null)>]           (null)
[    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
[    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
[    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154

[    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
[    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
desc->irq_data.chip->irq_hold is NULL

When I check, I found that the irq_hold implementation is missing in
one of the irq_chip driver (expected by ipipe), which I am supposed to
implement.

But I am unable to locate which irq_chip driver.
If there are any good techniques to locate this in kernel, please help.


Thanks,
Pintu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
