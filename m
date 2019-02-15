Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97978C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683E921927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qq0j7jBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683E921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8StOHVOtDfGWR3IMi0x8IMfo5ohHAkGELEAq0j+MBYI=; b=qq0j7jByMQEpa1
	SjRcuTls/oBfAfAHzZyh6vGrv+tQrCN8/p0729MGXs7nGc8SPB3iW/faBzfmkXEp838YxDCWw4tYo
	ABMDikceZ/sNUErHWOMLsvDw5Fbw6mGzwwFv7YO2jhTQx9QSXGtae3k8+uwflh+TAdZHjIyax70pH
	UGM5WX2+nHfkgUgwb+t+keLwo6Cr8DLJDiHJHo8lKrSkCiBujF0ActC6uvTc+TdZtKlkIg+YEpAzb
	Ea4ZBvHGpVyyc8i/JURvSFrzqW5Sgv5B7c1yv5PnkQJDJyNHCgyPG2V35pbDkRwo8VymwaeGpacki
	Hd5pyFFTmAb15GqIXiAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhZg-0001BP-1M; Fri, 15 Feb 2019 17:46:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhZd-0001AC-0f
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:46:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB84A78;
 Fri, 15 Feb 2019 09:46:50 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 380D43F589; Fri, 15 Feb 2019 09:46:49 -0800 (PST)
Date: Fri, 15 Feb 2019 17:46:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 0/4] arm64: kprobes: Update blacklist checking on arm64
Message-ID: <20190215174646.GH100037@arrakis.emea.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_094653_058363_ACA828FD 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: Pratyush Anand <panand@redhat.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Masami,

On Wed, Feb 13, 2019 at 12:42:53AM +0900, Masami Hiramatsu wrote:
> In v3, I rebased on the latest arm64 kernel which includes
> James' KVM/HYP fixes for kprobes, and fix a reported bugs
> in [4/4].

I will queue this patches at 5.1-rc1 since the arm64 for-next/core
branch is currently based on -rc3 and does not include James' fix. Even
if I rebased your patches on top of -rc3, we'd still get a conflict when
pushing into mainline, so I'd rather send them after -rc1.

Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
