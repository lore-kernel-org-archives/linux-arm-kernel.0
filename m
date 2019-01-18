Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC1C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4076F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCe3F+Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4076F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dE/OuBboUWmIFBuwYTuOteTlUk9h1+8rV4AlpR61a5A=; b=FCe3F+VsNukj6A
	kZl0cA3lyFMofGrkgiHXiwfjXZBwwdr/VMpiYlbh8b6oKsQQbxQLLZd6qK6HLy+m5NRLiUrBab6DJ
	oNmmfHiebRyLXlrPCo1H3R7VG80g37g5ViTTfgsTiXsWZXzYE4reVTlJ2OWQ39BtwQYGWYnvIWmMf
	RrKp9ycbFBp2Fecr24C9Q3WBl/13n6uK2xL4FJeNE4fxcfY+dHdDgjatSdjuJ9dHGtbGehGNI1jql
	u6Tau958+A9/W/1OATxN/W+agAbplXu18SQ2rLOuCOGyEcOhmXQsBZbrjXzMFT5Z76pY4rEKKkDem
	XCJNhxhyn5TwNrMPdHdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYWe-0006Na-NL; Fri, 18 Jan 2019 18:05:52 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYWb-0006ND-J6
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 18:05:51 +0000
Received: from oxbsltgw66.schlund.de ([212.227.220.204]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxEYY-1h8x5s34zQ-00xZ54; Fri, 18 Jan 2019 19:05:36 +0100
Date: Fri, 18 Jan 2019 19:05:35 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jeremy Linton <jeremy.linton@arm.com>, marc.zyngier@arm.com
Message-ID: <575913854.422488.1547834735236@email.ionos.de>
In-Reply-To: <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
 <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ZoURWHSIlPpYkd2EnWsFsQ8SWv7CpPvZNTMHt3wz4UaeaNhZEzy
 iOxccCipZ7wm6wnJigp1k7fjQ/OlSNWmcFbQ1tv9x4nZldlWSLYK9BH8HiG8YYrBq9qrkRy
 mq26uzJRV5RmsCaC1AvbuiVLReROd831julPROi4BzrS0glCoJCud/CBXrfNBJXDOUwrIHO
 bff2QxmS9bCKRRNhFgnqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31AmI8rdDIA=:pxW8TEtyU2nbIAidssiwFi
 YMzQ4SGC9vu8nYoFOEsnvBQcyAbiXYtoupCbhexv/xnMgXO3w6ndIB7iwjcL1oYv2sCVpxW2O
 qwyqslyuCVjY3GdyjZkmryCZx/Sa6OqMaAmd3ILL9RiwxOfs6M805K7IRLEpICCfGcxYRyT30
 N95+/tP41X72suqOGnJ5z+KaRRYHfHQKC85Hu/jlCWF6rWmRlao7WrboLRyx6gibTi0S2MkRX
 XS1Cpo7/+xloCxcQwDEO399e1VKIXp7lYn+zBpEf7qfDlPgyAbAscMvhw7Yme5kCET+2W2Pcv
 JLKu4TDsrF+ehYgrS7w/+k1dpifsqecntIgNlyN4+b6xVGo4q+uXjHTf5JG7d04AX0s5k4Zmi
 Nm+7Cvp0S55+00k+GBXtHkXMecWh9Oqgl+aUPgmuh8ptISkp6vAXLIM8Nau3fCHg6ZlbZik5k
 kKarDXnMOx0IcPs0ILhskBRWLJWw2ibfCRJSHf4i4Y3t8H10iXa6KuPndMknt7zZZ4lxQWCtS
 q495UWDGsJC1iKHVyvMM2Pmbcq+pBj9Mv6lwCu5blPZ8l6Fb1GRLeIpCPxXMszv7hLF61oFv4
 e3jNRJ7i4A/qPcmBQzd7B/mt+uYsdEbhMw17ucUSzAejeUqa3vW4vGWKmpWNqIuHCvYup7KVS
 GJmbb3CybBRh55jfH4jsO0Kvb/fsS2Q4vC+iizSxaW0nEUeudLvIQ8Uc4PVSi6v22uspEY/Kj
 1PbNSvwNfuVh8Y0O5ZbbfrC8cUzOblJHDTLd2PHSuV+KC2sAsoles5LKKec=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_100549_931593_67D3DE16 
X-CRM114-Status: GOOD (  16.93  )
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
Cc: mlangsdo@redhat.com, julien.thierry@arm.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 steven.price@arm.com, shankerd@codeaurora.org, ykaukab@suse.de,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> Jeremy Linton <jeremy.linton@arm.com> hat am 15. Januar 2019 um 22:21 geschrieben:
> 
> 
> Hi,
> 
> On 01/15/2019 01:50 PM, Stefan Wahren wrote:
> > Hi Jeremy,
> > 
> >> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> >>
> >>
> >> Arm64 machines should be displaying a human readable
> >> vulnerability status to speculative execution attacks in
> >> /sys/devices/system/cpu/vulnerabilities
> >>
> >> This series enables that behavior by providing the expected
> >> functions. Those functions expose the cpu errata and feature
> >> states, as well as whether firmware is responding appropriately
> >> to display the overall machine status. This means that in a
> >> heterogeneous machine we will only claim the machine is mitigated
> >> or safe if we are confident all booted cores are safe or
> >> mitigated.
> >>
> > 
> > i applied this v3 series and Marc's v2 series.
> > 
> > Now i'm getting the following on a Raspberry Pi 3 B+ :
> > 
> > meltdown:Not affected
> > spec_store_bypass:Not affected
> > spectre_v1:Mitigation: __user pointer sanitization
> > 
> > So the entries l1tf and spectre_v2 disappeared.
> 
> Yes, the l1tf entry should be gone.
> 
> I believe there is a problem with the "1/2 advertise.." patch in that 
> the 'arm64_requested_vuln_attrs |=' line needs to be hoisted  to the top 
> of check_branch_predictor() and the '__spectrev2_safe = false' line 
> needs to be hoisted 6 lines immediately above "/* Fallback to firmware 
> detection*/"

a snippet or a new version would be nice

> 
> That should re-enable the spectre_v2 entry.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
