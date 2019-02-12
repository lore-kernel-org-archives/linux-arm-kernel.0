Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:50:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB59222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZwKC3M27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB59222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAyPnZMi0fo3u/uebxqN+g0Mhl5gnkevbSg41/RgzDk=; b=ZwKC3M27se0uBE
	Kof852evRuAAOqaczxozmgeroqAUExMTqGfGv4/2UXyXDvEgZ2Ly/cL01xXPHx45YNNeO9d5Zmr6I
	CAJWUYmNb117Zan/08BGmvQ0WWh9Wnp+al95yys7/H6hF04h6MYIIUBXk/CNzGR5DbdAOH0XRGj5z
	xwo+sb+c3kijWDxXyhNpBzJfw6BX00R4CyhZ6u2F3utedkZGrKUZ1FgYBBdFtdNEMeTQ+6lJD/JIg
	IWrAuU3wQE91E7jLw+3J+LHDM3yDiH97xBo4A/DQb0P4WL4tRi6/gel2mWmwIkILaj8VTWvRD1Hhk
	J7wx+x9fHq0iO8DCFhdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf0X-0002gg-Ci; Tue, 12 Feb 2019 20:50:21 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf0T-0002fq-I6
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:50:19 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2019 12:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; d="scan'208";a="299229573"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146])
 ([10.122.105.146])
 by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 12:50:11 -0800
Subject: Re: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
To: "Ooi, Joyce" <joyce.ooi@intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
Date: Tue, 12 Feb 2019 14:52:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125017_677768_A7D4A9E5 
X-CRM114-Status: GOOD (  13.09  )
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
Reply-To: thor.thayer@linux.intel.com
Cc: netdev@vger.kernel.org, See Chin Liang <chin.liang.see@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Joyce,

On 2/12/19 10:24 AM, Ooi, Joyce wrote:
> As there is restriction to access to EMAC System Manager registers in
> the kernel for Intel Stratix10, the use of SMC calls are required and
> added in dwmac-socfpga driver.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

<snip>

I have a pending patchset[1] that addresses this but can be used by 
other drivers as well.

[1] https://patchwork.kernel.org/cover/10612891/


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
