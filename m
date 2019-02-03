Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32A820855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ubsXRWB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pl9ERk+FJv3fbLT0/DRMUa6/CVvduKBe0b0BTSF4cVg=; b=ubsXRWB0Ddu5E2
	PbJfgQhPeNTrg/5Le6vdwQy6pdh7TIJiNPVp+IGDchWaFSd9NgKM2VBicsGE9nrBP7/bDvKHtieMz
	Z8mjAyaEg6VWlaZv33iMXVP/j8KH1Vxv61XswAmuPBvBixnT7jl7oTWlIBfS20xe2qUKuzsEsc7HP
	ZlqRcVF6nQJZ1dCK+xg49su7CpZV73tXeR0SAaYqIpi8iEAIhKxx382Z254KYUXML1rL7X7jlzMlI
	M9zRdJiamSpYPbB4WmVlSiVMbvh/UepT0yMmTk+GMTJ3QUM27e+ad9ehjc3AoQH3F+71vLO9Hciod
	L1XwweZf9humuKWlrK+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqDTG-0002DD-2b; Sun, 03 Feb 2019 08:49:46 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqDTC-0002CP-7Z; Sun, 03 Feb 2019 08:49:44 +0000
Received: from [164.15.244.47] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gqDT5-0001I7-AT; Sun, 03 Feb 2019 09:49:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rock960: Enable HDMI audio devices
Date: Sun, 03 Feb 2019 09:49:34 +0100
Message-ID: <3467399.GglsX2lTEV@phil>
In-Reply-To: <e80f7cea65a51a2746aaef2c4efb1c1a474fbc1e.camel@collabora.com>
References: <20190129113324.29440-1-ezequiel@collabora.com>
 <20190129114031.GA17014@Mani-XPS-13-9360>
 <e80f7cea65a51a2746aaef2c4efb1c1a474fbc1e.camel@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_004942_421430_2438A609 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, 29. Januar 2019, 13:08:11 CET schrieb Ezequiel Garcia:
> On Tue, 2019-01-29 at 17:10 +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 29, 2019 at 08:33:24AM -0300, Ezequiel Garcia wrote:
> > > This commit enable the hdmi-sound and i2s2 devices needed
> > > to have audio over HDMI.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > 
> > Since this patch affects both Rock960 and Ficus, it should be mentioned
> > in the description. Other than that,

I've adapted the subject a bit (arm64: dts: rockchip: Eanble HDMI audio
devices on rk3399-rock960), mentioned rock960 and ficus in the message
and applied the result for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
