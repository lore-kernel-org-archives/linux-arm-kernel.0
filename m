Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06408C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2162086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENKSCJsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2162086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blastwave.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3nIAtBhWRWQRqPI8alJAsk+6hEzquxvRH4pXPTEII8=; b=ENKSCJsykk5p2cm8M6R65pooK
	X4nnt2UZbJd3VX88OR8E5VqT4nwbtjEKpTDs/xidLpbDHsMF1LhxZ77O5tEBKm3KyZE4xIqUD6hME
	aXRzDXRzkj54Fu0a5LHl/U6QkP3xHRwcMobSOU6fp+ITpqywD18TTrT7j0n4PCDzJWLPb/vSGj4Ur
	V/GylcDk12umQHkxWLDZHCKD3MPQXPVRp+pojc51BPeHLtCRIkSZlP3licpnG9e7UHvO8J7Nn7ARw
	uAcrMre7VyuB1MvGytuCp1uKdmRDHCbe/asGyO0UuQ++SenFYZt3vX2pCCusG+XTStNycrMr2SO+W
	yJ72XdnBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXSZ-0005j4-Nv; Fri, 18 Jan 2019 16:57:35 +0000
Received: from atl4mhob12.registeredsite.com ([209.17.115.50])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXSV-0005iU-Hw
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:57:33 +0000
Received: from mailpod.hostingplatform.com
 (atl4qobmail01pod2.registeredsite.com [10.30.77.35])
 by atl4mhob12.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IGvRwJ022472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 18 Jan 2019 11:57:27 -0500
Received: (qmail 46093 invoked by uid 0); 18 Jan 2019 16:57:27 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?)
 (dclarke@blastwave.org@174.118.245.214)
 by 0 with ESMTPA; 18 Jan 2019 16:57:26 -0000
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20190118161835.2259170-1-arnd@arndb.de>
From: Dennis Clarke <dclarke@blastwave.org>
Message-ID: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
Date: Fri, 18 Jan 2019 11:57:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_085731_716472_22CD8569 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, will.deacon@arm.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> This is a minor update of the patches I posted last week, I
> would like to add this into linux-next now, but would still do
> changes if there are concerns about the contents. The first
> version did not see a lot of replies, which could mean that
> either everyone is happy with it, or that it was largely ignored.
> 
> See also the article at https://lwn.net/Articles/776435/.

I would be happy to read "Approaching the kernel year-2038 end game"
however it is behind a pay wall.  Perhaps it may be best to just
host interesting articles about open source idea elsewhere.

Dennis Clarke


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
