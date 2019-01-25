Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB717C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA2120881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ruQinPBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA2120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eDSMWRGhpBzIsUrT18jIrVGDJ0qlGksakDsuTHP77oE=; b=ruQinPBxoOHyNe
	jDXOK/zG4gIfeVTJwfwFrLj3LynOWaE9m++svgCtP7Mw0rnCDCCjUaubFj+bp6fzfVD8dQmKdO2Ep
	z/BG9TibkYJLnSn3GVWA4oIHiVhP12uVCuukqxpIzL/wvkPawOMcD+nxJUhHBXDJHCEcFHeM0SCkV
	iwuxtMSIlMz67ciMZakUXawDRPtq/Hi13Ipg1K0GuzHMxM3fR0qzu1pllUFrT8nE6xQtL2nnM/iYm
	f7Vxav5BqEg34jW2Vx3Avg/bhn/7oICgj3acL3q0Kcf21dErPsOPk0pA0HVOkzecb9tE1k2jGRP6R
	iH3U/dyeYbvab4edpLOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2S1-0007Eh-Pg; Fri, 25 Jan 2019 14:27:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2Ry-0007E1-QK
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:27:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B355DEBD;
 Fri, 25 Jan 2019 06:27:16 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 16B4B3F589; Fri, 25 Jan 2019 06:27:14 -0800 (PST)
Date: Fri, 25 Jan 2019 14:27:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
Message-ID: <20190125142711.GD25901@arrakis.emea.arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_062718_852137_481E9C1D 
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
Cc: peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com,
 valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

On Tue, Jan 15, 2019 at 01:58:25PM +0000, Julien Thierry wrote:
> Julien Thierry (4):
>   arm64: uaccess: Cleanup get/put_user()
>   arm64: uaccess: Implement unsafe accessors
>   uaccess: Check no rescheduling function is called in unsafe region
>   arm64: uaccess: Implement user_access_region_active

I queued the first two patches for 5.1. It would be nice to upstream the
other two but patch 3 needs an ack from (or merged by) the scheduler
folk.

Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
