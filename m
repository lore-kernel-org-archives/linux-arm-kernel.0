Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BFC5AC81
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A40D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWOAjSJG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ESpMeYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A40D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ey+0ozBvIIyFSGVsr9C1wCyAqlLwOBu/R/QpfVr4JNI=; b=QWOAjSJGVbps8D
	IkNWrD78qdyRo94iBZOcW5q7vCB/r0U1N53HRPiPlRCVJfc/11fPeu60qiV3reyB2iihb/MJO8d/S
	fTlrcf28z74xFOeYJzIl0RfuGI/LbUZpqVPlAkmExcKQdW95rcJX5c0q3SV0qYvN2Vx7GKRs7wHND
	QQ1J/ry7kA5syuvLMva0m89N7Z4EHH/GWIjvETjIvCulfp/BATSebfwgqJOQIwC/9+rb4L29qwN7l
	OyzjgXnK8AL4ubj/CcfXyZHoQUIPRuATB6ERblM/R91Ir6LGxFDFO95vk6Kez+6KplDXarJFKWi9n
	f0OpQ4C4Wm3gP1QTx1BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXfZ-0006r4-EO; Fri, 18 Jan 2019 17:11:01 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXfJ-0006dR-5A
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 17:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Emlr8gzN6AJkYYAx3SCt3VpzzNfKpsQ2NBBX+LsRrA8=; b=3ESpMeYuD2tg1NVc32HBTO6VY
 +d/enjdKpv6AvhJPnqbooRHCd+0yhkxMkNCEdoHNZzdO/Vf0f2e17SyqdNPx8VsuP9aqAzf5VTucx
 bNK1w1hLdXsgFxiEbAbbceM4gEFDIpRqWfHQMD0Xp6INA/aEk81j3dmW/Ov7HWO8U8G0/Xc+3JvAP
 f2rho3qkjzOJSX3YwoVRvnOJ5gPr+lyBwU34rORY5Ou8eGlu+7P4YjZzrrO/XGTrfnWTn8dN4QX96
 oW4Pq6SS18nQWOhhdFxm0wGn7CvuzUdssLWSGap1P1IkhXyk/KSMCoUKB4S6aqUOucC/hj1Hje3dD
 UkkkELzPw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWyT-0004Sa-Oc
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:26:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8CDEBD;
 Fri, 18 Jan 2019 08:26:26 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D25633F557; Fri, 18 Jan 2019 08:26:24 -0800 (PST)
Date: Fri, 18 Jan 2019 16:26:22 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v8 11/26] efi: Let architectures decide the flags that
 should be saved/restored
Message-ID: <20190118162622.GJ118707@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-12-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546956464-48825-12-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_112629_880471_5C5ECE9B 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 02:07:29PM +0000, Julien Thierry wrote:
> Currently, irqflags are saved before calling runtime services and
> checked for mismatch on return.
> 
> Provide a pair of overridable macros to save and restore (if needed) the
> state that need to be preserved on return from a runtime service.
> This allows to check for flags that are not necesarly related to
> irqflags.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
