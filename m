Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55DB2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vo0vgZTa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agQsC2Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55DB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=B4LRpazGl9Ox8sL/xrf5x+R5z8Mu58NawT/4TxqalWk=; b=Vo0vgZTaW2AolyryDu/AGmXFif
	CCxxiQXCIUa4f14w0nHFh1gW7AfBcy3JwJg6liA0XSIGMX7Gm2ywejmMZPaOuSWpHwLYCuyvHmYRE
	zM5yDUlnzMlA/mFDkynG5dGLB7nk87gs2alDPb2ZWTTRlL9Gk207K4QNQde9jEc9CuBbe9B4QDRZA
	/8SIfl7p0xbQAnE6t3HAziFyJLBfhaezQsRlNEkzkbKdusMiEEVLoVjwCtLotqQZ/bfOvUoM5S6D2
	9yApXqbmIHI3RPZYtUIddkiHfjBYDAj8In1gFVWZdjM4/ELqtJjHpM4tnOZX6ApVREtCKUAbse/3a
	UC4JKZfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkIW-0006QB-6F; Sat, 02 Feb 2019 01:40:44 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkHN-00049n-J8
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:40:09 +0000
Received: by mail-pf1-f193.google.com with SMTP id g62so4074977pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
 b=agQsC2QdMvpn4C7uhQZI3oL3d4Tompeso7z2aiQkFncmX4JWg/uBamjV6PdFYhVR3k
 oX2uDQAPGf5vd3JMceHjWd3zOb6honNJovwJzyFsDilYk3h4kPDusmb8mZ7ZEYleqcSE
 9uBme4VReWk1RL9qbeNyI+Z8+CHg7tBC670AHNS9Ixurcy4RidGTlBfGSEeSBVskoBE4
 kDDouF+hsf/IUxkz3wWDqCor8SL1zRKNxx8sFfe0FC1ZLM9D8d8rtxmhZTbUJwEcx94e
 uAcqSt+1r9k0d5su0uGKjFvdvzQFGnPHQYuPGbaLZGAetRUCfjM2O99LcXRklvHcAi42
 iNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
 b=PLBUCFB50tFtFy+rRXBBdolCkSqgIavWtlUBkOZgP/JPGLf6YQRviANCPNGQafFNfQ
 kCcxiGPyMEoMFftjxKPms0+MfV7tjqh0tGL55CBQffOyKUAmCCHrZn227VscpjeCzeCs
 YolMcrS3GIfcBmGSIKNQl/uui1Shiqx1t1XzqwQ/WVSzzoTL/7KML8mj5NijcqM9CzXv
 otcnP2ObN/R0S+G4E/93cCNb58b80BQqlvZq8g/TrEuA0OG/E3D8/NnJ1ufmWcfrkpnZ
 8DnIkcMaIrJ+U5QQTk8NQNru+ah3tTnyUX34vU2PkR3drlyLEYc8Auq+E2voGuDgZJQe
 Lb0A==
X-Gm-Message-State: AJcUukdhYyX3bXj4aqDzGWKM7VaDCIPtfTWKJe/9+f5VBXlEr7SXY7DU
 LS2/JysX/O2XNKJ1ajfphJI=
X-Google-Smtp-Source: ALg8bN6ijptjqFitOy96WFBZeRXgkg4rQ+4Jg8H6p266gaeKh2xdTdOvDwbEn+uVqVIuUB2t5iGdSg==
X-Received: by 2002:a62:5910:: with SMTP id n16mr41321495pfb.128.1549071572866; 
 Fri, 01 Feb 2019 17:39:32 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:32 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 6/10] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Sat,  2 Feb 2019 09:38:22 +0800
Message-Id: <20190202013825.51261-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173934_323228_CB3DB288 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d57574b49823..6b5e9bed6665 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1718,6 +1718,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
