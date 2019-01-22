Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B039C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfumQ7KS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTqatmkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B039C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGxzjm/zfI+tqSq8Q20iubzGuok3yUu+bsq1miDVMd4=; b=lfumQ7KS4wI53g
	qb+I7L4TNEqgkTilte+OAoc4LHKdrXeyZ1cW/BnqfLuw/8rLG/nKbHd41f1gFbHMGl5dYVj1c61MT
	EzwWLc0RvVXlbvWog+9Yh6QOBn0DSf2X8Jfp1RIbxbObUBeG67CyY8xwM7vmTs69NGwWNTh3q265v
	u3lMqGuAW1Ct81iodJYArIDXXxdQgkikqc/nt4yc5/oYEvCxBtggJ9hcwuzjbDsJ1THVU5clS0rMq
	oQmVcUsVqlsM5eKRnOu95ug31egR1iEONcSFqg8WoEGe/14eSVAYvHl6UmvWPeRUNzu+4PXvsEQvK
	aBYHWyVr9lH59astrH8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glp59-0008IX-JV; Tue, 22 Jan 2019 05:58:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glp56-0008IC-FR
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 05:58:41 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CAFEF20870;
 Tue, 22 Jan 2019 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548136719;
 bh=Ug7uP9VQ+I1hvob15mUa7ch9wstwpTUVBtgQ5p3gNA0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sTqatmkEjltSGP+5Rw36v8n7XiAQMAkXabcD3e4Pk29zDDJR/UkU4wJWPGRCGNgSw
 UDQ7CVgOj5hTFGo+Mo2gBXUYAK/GsBNmQV+4vXb7msOq1TPUUfkWbTPrdFTmT6t7VX
 5i/Ps8kM9gB4SEl38WpzONmKlRwd4Z6/OEkWJGPA=
Date: Tue, 22 Jan 2019 13:57:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add vendor prefix for Catalyst
 Semiconductor
Message-ID: <20190122055754.GA19929@dragon>
References: <20190121095705.27452-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121095705.27452-1-martyn.welch@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_215840_526730_D9ADC385 
X-CRM114-Status: UNSURE (   8.37  )
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
 Stefan =?iso-8859-1?Q?Riedm=FCller?= <s.riedmueller@phytec.de>,
 Rob Herring <robh@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Christian Hemp <c.hemp@phytec.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Thierry Reding <treding@nvidia.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 09:57:04AM +0000, Martyn Welch wrote:
> Add vendor prefix "catalyst" for Catalyst Semiconductor which is
> already in use but undocumented.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
