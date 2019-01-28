Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68640C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:58:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367202148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JiTc9aeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367202148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dUpV2fiXAuXwhE7l4K2UtG3ds30lu0Da62ZCSdfqULc=; b=JiT
	c9aebeviOmsSVvm5rbpi6e+IniM9iD31Jj/LaX1PLUgiSc7pEJ+Roa/o8pMeQrxoYdbMmzXudMpv4
	FckxHJ1NOVEj+rdI9ePKSlNpz6l6tW9IF+xLMDbP6jI/OCS+FyK+xE4hGYUCyca00ifrpUPXHnFjc
	dHDMTWAZ1P1wpOZI3833/nbDGF74a3p7bJGALvQV+0ibeRh6etWn/1WSFd5+lg5uWjHywXUcQezpF
	oNpERDm8hsf98D6Gp47Y5gacF+iKVfLNjz4+jdo3w6oTMj4DfmzkauxS2D7r8GBX7DNDPebwwIja5
	I+r6HqhGMup3qLWaROsQNgCrAX4e1+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDys-00026A-34; Mon, 28 Jan 2019 20:58:10 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDyn-00024s-CX
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:58:07 +0000
Received: by mail-pf1-f196.google.com with SMTP id y126so8566339pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 12:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XRWDdfa8a2hFP/+w/UhxZgnzQ3ire6aybElxeAWTipA=;
 b=PZzyaCGP2F3orpYLnh+q/zgA0pL4umkcDbAEHyDGWQRwiyGcg99gNh+2pQDTO+mVed
 IMmVIuUxpth5Ihuupy+xkAmm7evGYADL+L7FDrNEgYAia57RYro//zDRgN+o8nTREXwM
 bWR8HwKP2DunAfLfTDZjjFdqRBSIifvLPHGx+aT3PWW6leaZf9m7fMi97HN8qdPqKL5n
 qAmJleXAw1lrbUi11G4cNM5bxkBSeT1OYcJ9nmnziSJJ4w24yS88YW2VqwiOoohJ0lus
 aGifm7zXFFDhhsjQ+UTwrHerfExMME2H3EM2vVjr0pDwsmlbpYFN+5csMoV2+laEyo/E
 CUeg==
X-Gm-Message-State: AJcUukdbJ9sV4xuvG/xwC498ef0SphTO8VcO3owJoVTesn9JJnN9NHVQ
 tFHzNdYV+O5hJh4xqxPuYAl5O6EAkIY=
X-Google-Smtp-Source: ALg8bN4oKytAUy6C0niKT56UYHSjkA12k1ozqRC7/w3ZmDvWTyQqu8zA1XkUXZdM5KhEeBR4NmPr0A==
X-Received: by 2002:a63:4456:: with SMTP id t22mr21690537pgk.0.1548709083268; 
 Mon, 28 Jan 2019 12:58:03 -0800 (PST)
Received: from localhost ([122.177.107.199])
 by smtp.gmail.com with ESMTPSA id z62sm57512318pfl.33.2019.01.28.12.58.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 12:58:02 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm64: Expose physical and virtual address capabilities
 to user-space
Date: Tue, 29 Jan 2019 02:27:54 +0530
Message-Id: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_125805_419472_B686507E 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: mark.rutland@arm.com, steve.capper@arm.com, catalin.marinas@arm.com,
 bhsharma@redhat.com, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 bhupesh.linux@gmail.com, kexec@lists.infradead.org, suzuki.poulose@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
supports these extensions can support upto 52-bit virtual and 52-bit
physical addresses respectively.

Since at the moment we enable the support of these extensions via CONFIG
flags, e.g.
 - LPA via CONFIG_ARM64_PA_BITS_52
   
there are no clear mechanisms in user-space right now to
deteremine these CONFIG flag values and also determine the PARange and
VARange address values.

This patchset proposes two mechanisms to provide a user/user-space
application more information on the same:

1. For a non-expert user, getting an idea about the virtual/physical
   address capabilities on an arm64 hardware via executing:
   $ cat /proc/cpuinfo

   can be quite useful as it provides a similar mechanism as available
   already on x86_64.

   PATCH 1/2 implements the same.

2. For a more involved user/user-space application, the Appendix I:
   Example in 'Documentation/arm64/cpu-feature-registers.txt' is pretty
   useful.

   If we can expose the PARange and VARange values via the MRS register
   reads to user-space, we can use them in user-space programs as a
   standard ABI.

   I already have a 'makedumpfile' user-space example that uses the same
   to determine ARMv8.2-LPA support. See [0].
   
   PATCH 2/2 implements the same.

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499

Bhupesh Sharma (2):
  arm64: Expose address bits (physical/virtual) via cpuinfo
  arm64: Expose PARange via ID_AA64MMFR0_EL1 and VARange via
    ID_AA64MMFR2_EL1

 arch/arm64/include/asm/cpufeature.h | 59 ++++++++++++++++++++++++-------------
 arch/arm64/include/asm/sysreg.h     | 19 ++++++++++++
 arch/arm64/kernel/cpufeature.c      |  4 +--
 arch/arm64/kernel/cpuinfo.c         |  4 ++-
 4 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
