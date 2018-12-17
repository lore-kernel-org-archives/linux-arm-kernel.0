Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:19:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA73B20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6zxvORA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jq8C1R8q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q83KDvgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA73B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bpQr+gp1BNgkYz/kuFFqS9gMZ2KaHty7BcN5rX3Olxg=; b=I6zxvORAnsIf0ZfXvQUCBIsJ2n
	Si5U6Nkdqxcm3YDv4RGILTbfY97cn445wt+zJFuMYpz4lHdEnC3B47EmVBXz3Aa/R0+UsZQWBArwi
	99h13uzgWIYrQ+P0LaFayKfhoRjC/BGhl33HKlWQJ5v8Pcg2A9uVlCevuuW3iK3DP2oaewiUB33b9
	tS+TnU4flXQFwBvzDPIF2Fw5KLK5Yiw+xucQSOI9DF537QZ8q2/YyN8kmeQlUFVAuGQ88MbsVuMEy
	2AFqSG7SFgx11ui9qbiUH0ruXeI0ODqvFj7jA5c8ySJm9ZRxkB/Ov3o7UJ6xC4zE8kPGnBC5owBPH
	IEEqJORw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuff-0006iV-2H; Mon, 17 Dec 2018 15:19:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYufd-0006Vr-Kr
 for linux-arm-kernel@bombadil.infradead.org; Mon, 17 Dec 2018 15:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/NYUeSTLdxH/6E3N8GH3z2DtBM5s96DNd/tQrVuMo/U=; b=Jq8C1R8qREorvdKDMOaNspcjp
 o2cyPaYskhQskdrd5avBjTW6VpXPrGE4i+OY4orfBbjl+js5OQDUd47z7Y/gZS8sKUg8XVMYhkevd
 aJxUMsTVOaAT3JXBrQgRMMUCuKIw0driULsjtxsQQWxcwmuPzj67zzaU9kVvc7iBiqsn5K8HiotSt
 rNeVLYzfY7EL4wbIRVAl7G3AVAH0mG9JRqiAo0dXnVDdYyzhN1IfukeRO1LbWw0oFYrqsON4SRZoE
 DD5GdNy4nR7uq9sNYIqyoYp1bFNv4Lvx7TO7+ajmsWmPVR5fhppJTeBO0D6QnT5uK/r7x5LEtyWrp
 KE3YigXeQ==;
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuPZ-0006kV-4I
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:02:28 +0000
Received: by mail-ed1-x543.google.com with SMTP id g19so4392499edy.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/NYUeSTLdxH/6E3N8GH3z2DtBM5s96DNd/tQrVuMo/U=;
 b=Q83KDvgEvHlrlht6RwlC5r+XbmNvfzsK/52Myxb9AJaElQe6OgT6iZpSBQwLs6iwh4
 sDKa/3q6tGZAbz6wPfNyUB/AC6jcAkY2JwH9e2CrhUlK/SZdq8RKX60drwuSoh4LnmAD
 Iac20hm3ch3f2y+V7V/pp5qfkaJc+eJTc/1EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/NYUeSTLdxH/6E3N8GH3z2DtBM5s96DNd/tQrVuMo/U=;
 b=W0VSVMYlHpnRqGXbbjPyrZ13oUtIil0CyhbPZe048MTMQYjc4nPBtj2GIgxll7amZR
 8jtgKhItmOF6mkao3ZdHpDK9IdwKMdtz0T65TRUYuBwx0MxDDS4wmAzQvG++erGQYoR8
 SuAylf5a9qsVMYkhA4Mnc+UwU7/7p31hhpcK/ral+nUtziXuTVUokcqppKgs+ANFu0i5
 t5wJoAKobGwoFowGLJ1ftvX6gVGj8i9xsgOiIHwUNVkpJHyThWOBhLO1rqBHzFwmRxFT
 IHKNlGf4qqYt0pXFPTGwHem4XAhIzOUCNGBN6t1olAPCVSvna2mb4H4r9xfaBRhRoufN
 bZKg==
X-Gm-Message-State: AA+aEWbtz1UfjDfcOY8SqlJYse7LhkPrqcE92MYFrCoua+2O2mKBVS4O
 gzluVJXhTI/bvn2llBRPXCRb2ITz4MeCgZyD
X-Google-Smtp-Source: AFSGD/X0iGV44R5OnEL4OIPXf+ICdXDxQphoXYDfLaz5kSZevl0mp9vjYxVo5njALs9z7c2S+is3Ig==
X-Received: by 2002:a50:b5c6:: with SMTP id a64mr13487968ede.112.1545058933183; 
 Mon, 17 Dec 2018 07:02:13 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl.
 [77.251.17.237])
 by smtp.gmail.com with ESMTPSA id s5-v6sm1904340eji.25.2018.12.17.07.02.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 07:02:12 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/2] arm64: kvm: describe data or unified caches as having
 1 set and 1 way
Date: Mon, 17 Dec 2018 16:02:05 +0100
Message-Id: <20181217150205.27981-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_150225_176477_54E27DA4 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 christoffer.dall@arm.com, Suzuki.Poulose@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On SMP ARM systems, cache maintenance by set/way should only ever be
done in the context of onlining or offlining CPUs, which is typically
done by bare metal firmware and never in a virtual machine. For this
reason, we trap set/way cache maintenance operations and replace them
with conditional flushing of the entire guest address space.

Due to this trapping, the set/way arguments passed into the set/way
ops are completely ignored, and thus irrelevant. This also means that
the set/way geometry is equally irrelevant, and we can simply report
it as 1 set and 1 way, so that legacy 32-bit ARM system software (i.e.,
the kind that only receives odd fixes) doesn't take a performance hit
due to the trapping when iterating over the cachelines.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 464e794b5bc5..eb244ff98dca 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1180,6 +1180,21 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
 	p->regval = get_ccsidr(csselr);
+
+	/*
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time.
+	 * To prevent this trapping from causing performance problems, let's
+	 * expose the geometry of all data and unified caches (which are
+	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 */
+	if (!(csselr & 1)) // data or unified cache
+		p->regval &= ~GENMASK(27, 2);
 	return true;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
