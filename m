Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAD5217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Af6dm0i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD5217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uDerjJYZ0+oOJNJGrozn7fwFIUUmAQXmpudLkqGbPVI=; b=Af6dm0i0xf9TEy
	POtpc9zJm81nKTToTFKZhhAdMjuM2OaW6upNp4H5Qg42zRjxczneCrMx0DXkdYs6+/whS8VlJUEqd
	hJZiR2emeWQjEYW45ax5Vb3rBgHhiEhfKl6LvRcGfB4C0EdQkc38dcvEiw4kjUbhR/dmfMd+Xf/aG
	UnvAd0mzorlw9VipAb8XPxrfBO/7rf02J2fIs37Z6fW9s3TuVKuG36K9dN8rILQ4LPp+v4XHv3PvN
	5OF6cnnchJcRJKsZVgZfmfM9XfM574Ul7Ns7fHErMCqG8nIsPNLmgDBK2icPdwOCyC1Jjpdb2kjo7
	rG/2L7O0rdY9G33Bw/qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8hc-0001mX-Q0; Thu, 03 Jan 2019 19:30:48 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8hY-0001mC-Ge
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:30:46 +0000
Received: from oxbsltgw35.schlund.de ([212.227.220.134]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1gcwpb3SFE-002GgX; Thu, 03 Jan 2019 20:30:07 +0100
Date: Thu, 3 Jan 2019 20:30:06 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jeremy Linton <jeremy.linton@arm.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <1951199845.271163.1546543806398@email.ionos.de>
In-Reply-To: <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:yKSS8p5egjlaMhfhDeQJPIdcmGhd5xl+oENISsah/WG0MujPa2h
 LiJMMCQfW6PJ7Eqb6eOi9GIn0PtuqJuNzQe+lzjg8s7o+Kxv+fchFK4zeE5rWaRNBXs3WHb
 twJVYOfDA8BNqd0LJCGuflSdsIvfhsrOAq2FzC0PW4K3DmSrH1AmZd51HDxqM5ItLJGjsKm
 igvqWwly+YzfdmD1huaQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pW995/OWosI=:4S/PKYyQXhoWhzTuLBtOvm
 4i82PGUuiX8qrxniqMs0zyhWzTTXvBZV5beXckYtn9X9/DM9caKtF1mMCXcQr95kDuosZj/HQ
 VyWTe7QGvbKjziZXFvxdgq/xDtgjczTeN5LTiy4zvOsfvZ9Pq7h9YhTb5hX2UI99b6BevZ9I2
 8eIbuQ/GWIFaaky/macSzOPqoNj/tqG+wfCrdDRZCqFpL+N16YjLR0umKQIfkntKYipLJCeDz
 z8WH51ps2dNVU6rZFxWSDPnVJ99JEmqvEFnKkre+i31wC4qxTelrxn1aDKE/hCGtKQl0bykNj
 C+Em/5Z+fY0q5ov33Jm7qyyatgXvO2EXy33zgs/64Hb/3wt0fdnFVAsHq9d6jIT45wuVbBAeV
 TivN1+XinOOAe5N1z3JcvReq5UzMtRNmhOwldRVG5GCp6CeUwNwMWW2qQQmabI5MVGc7/5qlZ
 81K1ZaT73S5GynEZEAdlDgQn+cEApsAj5b7+CGb5zfFh8HsJIOf0Fld8H+Pdh2GTS1hM+mI55
 f0arSTJ2RdG2WOPqA8sRLkkKuB2q1IgL1f0Bp2w9AH/P1vRhBxwJfZLTsRAykwAxnIqfqyp/3
 1I8VlEKdXcsTSMuq1E45tuVSQjHozQmd+zC27LmR9TZY7ki5AcdQTM3nvavy3OaBe647NSPtT
 9WNJBjhnLIo8ifxd5PVT9IIuWVcjdXAkArcpCGXON4KGZT1FJvPJ32VrLqqRhs5/afdf0gypP
 qRIP3DFW3j565ctOIw6cr6y31zGnwkcjUbhPFsrWdf4SC1jjEeg4MWNARRo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_113044_853921_F5383B01 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ykaukab@suse.de,
 Thomas Gleixner <tglx@linutronix.de>, shankerd@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
> 
> 
> Hi,
> 
> On 01/03/2019 10:37 AM, Dave Martin wrote:
> > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> >> There is a lot of variation in the Arm ecosystem. Because of this,
> >> there exist possible cases where the kernel cannot authoritatively
> >> determine if a machine is vulnerable.
> >>
> >> Rather than guess the vulnerability status in cases where
> >> the mitigation is disabled or the firmware isn't responding
> >> correctly, we need to display an "Unknown" state.
> >>

i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:

l1tf:Not affected
meltdown:Not affected
spec_store_bypass:Unknown
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Unknown

AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.

How can this be fixed?

Thanks
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
