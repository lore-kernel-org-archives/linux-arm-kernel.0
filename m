Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151B22084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVyYObF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=o2X75bgiZzLzLlW0+fs9PfJ/X0ESn30c54Jrm/6s1K4=; b=bVyYObF7GHUTlL
	4di1EgVEZacGmSigA4fiNBHxLYu5vmixMGjlMuQDdxc8z3hZWxoaoCSJ3Wkcp1X3Ajv0zK40sL7TI
	rv/3D65kc5KYj0BpKE3t7iItPGET8iQhVkVADIdIwhxdp9kC67bolLbTBoU7waxEVcm8sBBoKqE/S
	GFCHSKuV8h6xeruujoZ4nK94DdLXGx0EOXxHo2kcOnIrE6b7e3P0pzSfuL8xzr7QiYTy8AzMKaQmU
	xE1zbpshdwKUfbs5FZIOKfXX8wUGw3rVZXhENOZpdmYd2CushAAsto6CtXcfN4atXsOCl1y5JXSoY
	WHGB4Zv4KV53yc7axvnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrpK-0001CK-TH; Tue, 22 Jan 2019 08:54:34 +0000
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrpH-0001Bs-0d
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:54:32 +0000
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by
 mgwym04.jp.fujitsu.com with smtp
 id 7d5e_4646_b5ba7d51_d7c8_40a2_887c_0f6891d13a57;
 Tue, 22 Jan 2019 17:54:25 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id A905EAC00EB
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 17:54:23 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id C8A126925C1;
 Tue, 22 Jan 2019 17:54:22 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Tue, 22 Jan 2019
 17:54:22 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Mark Rutland' <mark.rutland@arm.com>, "'catalin.marinas@arm.com'"
 <catalin.marinas@arm.com>, "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v2 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdSyLOgvncWewEHxSDCVdyamf7TefQ==
Date: Tue, 22 Jan 2019 08:54:21 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_005431_315468_CBEFCCAF 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
 memory accesses may cause undefined fault (Data abort, DFSC=0b111111).
This problem will be fixed by next version of Fujitsu-A64FX.
I would like to post a workaround to avoid this problem on existing version.
The workaround is to replace the fault handler for Data abort
DFSC=0b111111 with a new one to ignore this undefined fault, 
which will only affect the Fujitsu-A64FX.

The detail for this problem.
> * Under what conditions can the fault occur? e.g. is this in place of
>   some other fault, or completely spurious?
This fault can occur completely spurious under a 
specific hardware condition and instructions order.
 
> * Does this only occur for data abort? i.e. not instruction aborts?
Yes. This fault only occurs for data abort.

> * How often does this fault occur?
In my test, this fault occurs once every several times 
in the OS boot sequence, and after the completion of OS boot, 
this fault have never occurred.
In my opinion, this fault rarely occurs after the completion of OS boot.

> * Does this only apply to Stage-1, or can the same faults be taken at
>   Stage-2?
This fault can be taken only at Stage-1.

> I'm a bit surprised by the single retry. Is there any guarantee that a 
> thread will eventually stop delivering this fault code?
I guarantee that a thread will stop delivering this fault code by the this patch.
The hardware condition which cause this fault is reset at exception entry, 
therefore execution of at least one instruction is 
guaranteed by this single retry.

Changes since [v1]
As Mark's review:

 * Adopted errata framework.

I have confirmed as followings:
 * Fujitsu A64FX - The problem doesn't happen.
 * QEMU          - No problems to boot.

I fully appreciate that if someone can test this patch on different chips 
to verity no harmful effect on other chips.

If there is no problem on other chips, please merge this patch.

The patch based on linux-5.0-rc2.

Zhang Lei (1):
  arm64: Add workaround for Fujitsu A64FX erratum 010001.

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 13 +++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  4 ++++
 arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
 arch/arm64/mm/fault.c                  | 24 +++++++++++++++++++++++-
 6 files changed, 51 insertions(+), 2 deletions(-)

-- 
1.8.3.1
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
