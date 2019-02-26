Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9704FC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C6D2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqJw7fJd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WhM26Nli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u40ZAIBu4JShTblHoLsORpjsGQ7X4pmm6fjNcPici/4=; b=AqJw7fJdVeHL/V
	65bbzBGGRdB7bwlxImThASYIBbhI3HAHUFs2HXwpk92OMHVcEPYrolmL7tTSLnzm7WTai8jsj+Puz
	MJUGZYUDRsvaBkTX6YDPvKzNmgt5Yhm0lZLzWqcxD7UWf3TqQfjUgMdYMga0aSq9qbJ4yRDOM5BqZ
	vzBrpnLmXDKDy3RvCDRc5GIe5XTJcOvIawbrdeY6wWstylpAWGCkn3sK7Qonui4FYaogJMyuAPe3l
	QSnfUi7Mzq0X8kaBKNKRv3F+/ANrUXiwQINvW425lYd7xyRCNOgr2MqeIkpug8abgcEfi6GaAqPmw
	QzW/HmMkYQGnbSVQqj4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygpB-0001cl-8a; Tue, 26 Feb 2019 17:47:25 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygp7-0001W8-AA
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:47:23 +0000
Received: from zn.tnic (p200300EC2BCDB200F19C36A0CFFF8AC0.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:b200:f19c:36a0:cfff:8ac0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3611B1EC0354;
 Tue, 26 Feb 2019 18:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1551203233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=yECRnf9xHA+bF8UOcSdNEYGxwopzM0d+sVOWkJpRWKM=;
 b=WhM26NliI79ALDctbwpTCK4XPu1Mgs8ha9YfOQDpFPBAPiqZJd+FbfehLbYvY9WpOUtAOH
 VqucDrxVnmGI0BXFsUVv1kHvi0/Cd+de37AUFziUIPvq5o7fv1ga5Tm20nGTiLKOl99zaG
 Gf0X/fvpS4ZIXSCe27mnLpNb2TM2dpA=
Date: Tue, 26 Feb 2019 18:47:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Message-ID: <20190226174705.GF14836@zn.tnic>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
 <20190225204244.GJ26145@zn.tnic>
 <17733148-82fd-e119-3525-c2d580fabc99@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17733148-82fd-e119-3525-c2d580fabc99@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_094721_509776_00C06E00 
X-CRM114-Status: UNSURE (   7.61  )
X-CRM114-Notice: Please train this message.
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
Cc: thor.thayer@linux.intel.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, james.morse@arm.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 08:59:43AM -0600, Dinh Nguyen wrote:
> If you don't mind, I'll take the defconfig patch to avoid any conflicts.

Ok, thanks. Applied the first one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
