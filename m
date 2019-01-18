Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E737C1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:53:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DE42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B2VK11/k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwkWOmd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DE42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=DEbea0vfUv7+FH45XPhRjASDzUlWmh1JJs9g+oGepHs=; b=B2V
	K11/kGSW9jrwM38otLAHs/23sQjyaSr5DLReO1B19UBhdCiL5HGlaJWGSqFVcnKH6vyLgSg2XRnaV
	5w50HJb5873iSV3bu/rIgm1hgySBBf/IrplR/rQ/sSNNOjUOurdv09K1LwYrnhdoZfY1f2KtngueO
	XHD6IBwASXWf5QEv23IbTDOMkz1zxjZFHkiABsg6BcaTqn0hsZUH1jf8WZYWSpiCif/FWWHCxArol
	IW6lVYeV5LZ5eAzhLP4e4rxzkYxYUkGyo8W8AkjP9G0MoWCxo+ghQGKWF8DodFoeiwzLrgzdHKaos
	TEyqDDOakXLT6vojIpFgS4+DsR957ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkb8v-0008Mx-FS; Fri, 18 Jan 2019 20:53:33 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkb8s-0008Md-Bn
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 20:53:32 +0000
Received: by mail-oi1-x241.google.com with SMTP id y1so9999434oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ve4hJbdc4x5rLUp3ACTd+wkktsszntDf9C5XeUvzzlg=;
 b=MwkWOmd+JoZ4pI57QU6DHuHN8MT2evsczHjbicoXWdPgDjlAcS9x2t0moHuArcPqcU
 K2H1IrjkZJS5ttKay1TkVannDjJ3huUpGIA7RGcHg1ooVPobz1V1ptR8EF8SBa4QcXyY
 pLbuEeAx7vkugdFAkLGcW+AbejVb1edtTQmDd1wxY+FbAscestNOBWyP2qxvDcN5LD28
 6YZE/Bh8XTBRrtqYY6NjPCtUMz4wDnMJOCK7R3l7I2SCy0IVUPl/8frotSt5OVXsdUhE
 QEdpx7KA7ZUfY4+OdrVI4JessZvIYPH6Twpmzsn5aAaNmlToyX2zGtCstV2WaGydErrb
 Nkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ve4hJbdc4x5rLUp3ACTd+wkktsszntDf9C5XeUvzzlg=;
 b=GaxYXOt345ykjR1JbHRibhUuH8j967HSBc6sm0WUrdFo3xMsWoQZjqgEKfgwpwtQF7
 /saBpms8z/jwfMBOiVdyAuKTi4uk43boVSJQgaoGd/Eux2vZmLxFVtZ/ea3UZsvq7sMM
 IPfn+nhM7W64Cliy9jnIV3dl/y1x9F6mblvEu/eXxejC5OQ7CEttOvBMlJWitHGqv6eo
 d06d5i8xvk3Bmak2izxykkEVLlCnZCpi+M9tiltFRitjJyC/XWDeaEc1E+5BTANkEtAW
 Tpxi8gRXHrrS6V3l4BSSd5ry+uTWb4aA3YsqPwmLlStJAumutBKVKbV+aSco8PcbBK0N
 jJEg==
X-Gm-Message-State: AJcUukeZ4m/0Oc5TLTXqJ6tee7g7PolyxqPm22X/ahJPPbuZHNcg7mrO
 znJgX577ZLgPg9dXT2e8qBuDvcoQbD5J6dXfwoXxD8TD
X-Google-Smtp-Source: ALg8bN7u7Z6gwaLe1IHQwEi+H9hzFCoHUGuDJjae8ndz42CIrRNT3eUQoslajHWj9ev0OrOLcD3JDf/EmqSwM3XjB2Y=
X-Received: by 2002:aca:d509:: with SMTP id m9mr1517651oig.82.1547844808008;
 Fri, 18 Jan 2019 12:53:28 -0800 (PST)
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Fri, 18 Jan 2019 23:53:16 +0300
Message-ID: <CAJs94EZSyCMnou30borJNcHntG_3q=KeU_xC6zRNANLJO=We2A@mail.gmail.com>
Subject: arm/mm: Found insecure W+X mapping at address 0xe001b000
To: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_125330_431442_28479627 
X-CRM114-Status: UNSURE (   5.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

I am running linux kernel 5.0-rc1 on BeagleBone Black board and see
the following message during the boot.

[   23.344422] ------------[ cut here ]------------
[   23.349157] WARNING: CPU: 0 PID: 1 at
/home/matwey/lab/linux/arch/arm/mm/dump.c:253 note_page+0x38c/0x3c0
[   23.358804] arm/mm: Found insecure W+X mapping at address 0xe001b000
[   23.365205] Modules linked in:
[   23.368304] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1-default+ #1
[   23.375295] Hardware name: Generic AM33XX (Flattened Device Tree)
[   23.381456] [<c031f2e0>] (unwind_backtrace) from [<c03186d0>]
(show_stack+0x18/0x1c)
[   23.389248] [<c03186d0>] (show_stack) from [<c0c528b0>]
(dump_stack+0xa0/0xd8)
[   23.396517] [<c0c528b0>] (dump_stack) from [<c0360f8c>] (__warn+0xd4/0x100)
[   23.403516] [<c0360f8c>] (__warn) from [<c0360ff8>]
(warn_slowpath_fmt+0x40/0x50)
[   23.411038] [<c0360ff8>] (warn_slowpath_fmt) from [<c0329490>]
(note_page+0x38c/0x3c0)
[   23.418993] [<c0329490>] (note_page) from [<c03295cc>] (walk_pmd+0x108/0x16c)
[   23.426163] [<c03295cc>] (walk_pmd) from [<c0329724>]
(ptdump_check_wx+0x6c/0xd0)
[   23.433685] [<c0329724>] (ptdump_check_wx) from [<c0c6a2ac>]
(kernel_init+0x34/0x120)
[   23.441554] [<c0c6a2ac>] (kernel_init) from [<c03010ac>]
(ret_from_fork+0x14/0x28)
[   23.449155] Exception stack(0xdb10bfb0 to 0xdb10bff8)
[   23.454230] bfa0:                                     00000000
00000000 00000000 00000000
[   23.462445] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   23.470658] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   23.477341] ---[ end trace cc475e67fdb0f809 ]---
[   23.482562] Checked W+X mappings: FAILED, 1 W+X pages found

-- 
With best regards,
Matwey V. Kornilov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
