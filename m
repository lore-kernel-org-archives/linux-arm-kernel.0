Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:40:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF20E20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FH1F8kc6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yW6yE29Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF20E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KRjXoDwIDtDjs0NvPlG4b7o7ksvVWgXqPl5o6B9To2s=; b=FH1F8kc6sP1AsP
	BrBFcltavABy3oSXD4RAcn5qDzPD5oJx0FTY7+1f1kBGRcxaKNh7S5V1Eyc5VwpQN1aK63XjTmDRf
	CbExojQ8DWX1bAVqxLfM24F/dg27mucmNvPn+nArVkpUDu5hD36kEWm+ZYwxpSInswzsWM/foP4rk
	S6Ok7fH3cbXKFh+7A0Ue2FCQCDHemV/2aOGw8ZL6cm+M3CfPm7S6/fG6ynnr4+VVzVGZWkmRY7BI6
	dSTupSUvJTnhGc/6/wuEEiRaZ/2/eoISLXXWSfHVHreUKuKCyLFhJswYWlL4bt3wqVFelQf3hIFx8
	PdXRXyg+KH3/k12rC+HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVyNT-0007hI-Oa; Sun, 09 Dec 2018 12:40:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVyNR-0006rq-3E
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 12:40:06 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2938020661;
 Sun,  9 Dec 2018 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544359194;
 bh=LWcgiZOCStL8ml90wOI/t/mMSCXG6SmjpQvs+5Izg1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yW6yE29ZQPqYu9fbINteToc17uUT3Qg9VSz72a/sa1w+UBl7zXj6DCZbM6521CKWR
 zwaBUVTOt8hqzOiweobmqqHIbproNP2B1OWiGmTIxBbbUMfPMPnakBClHhG4KHP1Yi
 Sk1iHZV6TJshGTZYlp5PSq2+iSeVEKAFxwzlkVsQ=
Date: Sun, 9 Dec 2018 20:39:07 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: imx6qdl-sabresd: Use GPIO_ACTIVE_HIGH for regulators
Message-ID: <20181209123906.GB22960@dragon>
References: <1544092601-10244-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544092601-10244-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_044005_164123_86C42175 
X-CRM114-Status: UNSURE (   8.35  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 08:36:41AM -0200, Fabio Estevam wrote:
> Passing GPIO_ACTIVE_HIGH as GPIO flags for the GPIO controlled
> regulator improves the readability, so use it instead of the
> hardcoded number.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
