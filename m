Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB41D2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWkjK89W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7QbmsPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB41D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=84cISLJU6E49xGHYc+QICxf4vo7LAA8oqaguedLqSAQ=; b=WWkjK89WOAvnLd
	4qw6+lfGRSuOIeh/aQIq3V8+EnxRObCyrAelgvmHtNJy0dSesOKWwps05Ce6s2JTxPHE2K/OnrZ67
	nZnVBMoCvhgP1bY4fHZsgsXN+uRKnAt+Hf6QeAPurLIw+GbwhJzIBZhLU/2Oi3+hyIS/yCFgsCiVZ
	zDPOx1kFsRXSIf48VTe/3EWmnixQXwhvUKr3srW1u0dYhESz7/SZnOW+EhHWEjBbG9INdKlLkqFrS
	Jk81YtIEkLo043PC/Y4tYNa2bSOZabI8VdowVct/z68HoNkQSwk7UVnUbRwVmgy3pj3Og4L9A1ZGl
	NJiEwd95mYAgiL4GH+5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUNp-00087L-MY; Thu, 10 Jan 2019 07:04:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUNl-00086l-IW
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:04:02 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A975320657;
 Thu, 10 Jan 2019 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547103841;
 bh=zJA2QWmPWQzBtdWt4XO4f9HuTEqs9pPqgsZnQhYFRSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H7QbmsPceOK6nrXYKIeoJYZ/i4f5RjhMnLcODT2xH0MVTEvfep7CK5yiSnbm7VM9Y
 lRsJ52SJOGSeiHWFEPe+0k8oH06vh7Csr3mrx5Cdjq2KZmtl76VoJ8BIBlDnrWB5Da
 clYiA/EqF/NISjTk99zRDV5es9xFFf5+lvL5gAfE=
Date: Thu, 10 Jan 2019 15:03:50 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH] ARM: dts: ls1021a: Add memory controller
Message-ID: <20190110070348.GD25218@dragon>
References: <20181211154834.4489-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211154834.4489-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_230401_629140_13DBA812 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 arnout.vandecappelle@essensium.com, matthew.weber@rockwellcollins.com,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 04:48:34PM +0100, Patrick Havelange wrote:
> The LS1021A has a memory controller that supports EDAC. This commit
> adds an entry for it.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
