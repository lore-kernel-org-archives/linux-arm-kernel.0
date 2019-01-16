Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:31:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27932206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g/HZtkG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27932206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WmGlkfFusY/lwGFZxkOYLzQKhsnMv5J5yrWMOCGx5rc=; b=g/HZtkG9n6Jg1U
	EJVu5Vfvp9IECoxgMj4cbxo0uPy8J2klcD2iDBOeGc2rikSA8fz30PTrzQ2hAgJSNTNwsf3w3YRm6
	shxKr9UxnU0DpXCeTMLw4riOP7oBBiObsRJ4frNOe6Sn5QxeQcFvljr1xe99HsV0hXPTtyZe2h2jn
	jBbnPJFZrP/S2cuy6L7iGckt5lAowlGRJdS2Rf7C5PwVVQ/4D8t9suzbfLyELnfgYyKp8Hw3gP6Zw
	YuI6B8DD615DwOW6NcadAN5XNFNCd5zt95WQFRSetsdnyqluDVbmE0kCF6Ny1UBc6xNojrOvZpEYf
	bkR/gfSyPg9Rk5wQb3Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiTi-0006fl-9o; Wed, 16 Jan 2019 10:31:22 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiTf-0006f6-9t
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:31:20 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id BCE5E13F902;
 Wed, 16 Jan 2019 11:30:49 +0100 (CET)
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To: Kishon Vijay Abraham I <kishon@ti.com>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
 <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
 <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <94402bb7-2bc3-96fc-f37e-c0e57698cdc7@free.fr>
Date: Wed, 16 Jan 2019 11:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_023119_488303_BC4B4C4F 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Matt Wagantall <mattw@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 16/01/2019 10:24, Kishon Vijay Abraham I wrote:

> On 16/01/19 2:40 PM, Marc Gonzalez wrote:
>
>> Would this patch go through your tree or Kishon's tree?
> 
> I've merged this in phy -next.

Thanks Kishon.

Do you mean here?

https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/log/?h=next

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
