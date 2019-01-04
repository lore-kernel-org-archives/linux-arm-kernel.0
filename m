Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A8DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:40:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B484F2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n9NLkLyU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guk+NAtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B484F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nJzb8m5gxcMprig7MxGVbpKAVulmPciQLIqi6EOhGFY=; b=n9NLkLyUSOBqZg
	mpkQ7r6+tO7YHLXrIjJgCvdzIz780WpX42PBOwr1nJiF0w983bmaJLja1OrEZWgDeWuC+jxZzoF2/
	IK31vClrsoO7ZLhoi2WPR/YzrwFeOo/dGtTAkn6Z0c0t2TEGNAZ6cj0M7jf0O7Snpw5STEN4+y77A
	Ihqo1B/KKSdZkFN7ModwzXteoq617S7q9AfijAKahW/8QvaGWa7e9OwLh9AZAzr7+VJ3UQ3doddDU
	+KhaSWGauran6+IjL8PU23AD68dds/c+XkNi5R4ZbV/BntxzY9wLbGi3A9VsR4lZBVZ70UbrJfGkB
	rAIyLN50vMqRn9PgCFWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfQe1-0001hf-EE; Fri, 04 Jan 2019 14:40:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfQdy-0001gv-2F
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 14:40:15 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EAAF12070C;
 Fri,  4 Jan 2019 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546612813;
 bh=Zl3/URiqzpvTB3vS6mRLLA7ulMgDYB+jSLkrr1Xe/4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Guk+NAtQyY79sNAK4ErIZUjdtmLtDz0aTPDNVNrE8F1vTeTWykBzj+nF7ja4kzZu6
 1GnJi/3QjkqiWHkn6U0rggXvFc7foTfKZYiHiSNlsFsYYBtbkyzIb05KINLbAtNwYW
 TZ5bM5iNdINIGCqVuQyV02sX+ToMTckYD4urPPL4=
Date: Fri, 4 Jan 2019 20:08:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
Message-ID: <20190104143835.GE13372@vkoul-mobl.Dlink>
References: <20181228201119.11920-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228201119.11920-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_064014_127567_3BD27B65 
X-CRM114-Status: UNSURE (   7.42  )
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
Cc: dmaengine@vger.kernel.org, kjlu@umn.edu, Sinan Kaya <okaya@kernel.org>,
 linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
 linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28-12-18, 14:11, Aditya Pakki wrote:
> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
