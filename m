Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929412133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzhi9Az4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LTpKCPnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929412133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1wi8oAeD6wfQl7udm/iIjPbowGnEy8x+CtieYpi+WCo=; b=tzhi9Az4HcmWb5
	AJzhhtnLmySA+JvwqyZiztLDweiInhrrazaTEv2x9WbX43YuPNrVLWBrTfvCiKbQEnHxdXuk4pp2/
	Ln91kHf8sD/m0oSjnYCVjnBJXtVUe/VlNG/ciJoTW31hXYqLLiXq3d76EVeqtoJB1R7KMqJ3YNfH+
	y2yDvIxjCzC1EKpCIweLgiYMLzJ5OcJohwnXYe6kRETV4q8rcwcEVHsuNJrPdnXmMP+dQKj6N1Kk+
	JV2zELMuIU2LxpjASdfyiPXUmj40iOJLCfom0EzyRLxUnO7feq/4kncMCmPDyGHm/V5zw0dpMk5rg
	1TKIG7zlXnfjHQLl1Qkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2zV-0005UQ-1R; Fri, 11 Jan 2019 20:01:17 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2zR-0005U4-0N
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:01:14 +0000
Received: from zn.tnic (p200300EC2BCAC500F59AF9850531CFF6.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bca:c500:f59a:f985:531:cff6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 739591EC0B1A;
 Fri, 11 Jan 2019 21:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547236871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=tYCUebBSqDWIxvvs8nDDh9gQGbVZPgRT5lQ9BcgCVmI=;
 b=LTpKCPnua2EPkuczDLj8KUt1a9D9MrUjNFhBUx3Q/+wZ95PnewmWxvga2tusFfAG9UBnx/
 duQcUfCvBGjORode+us3+Q4/1NQS4L67GbeLeIXWQ83b/XigC8HaYwz6nzg+hX7QekCte2
 UtS18dOlIoeS1Y6Bx5Zm0albKzw4yuE=
Date: Fri, 11 Jan 2019 21:01:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20190111200108.GB11723@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <0939c14d-de58-f21d-57a6-89bdce3bcb44@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0939c14d-de58-f21d-57a6-89bdce3bcb44@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_120113_201129_1BB13461 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Tyler Baicar <baicar.tyler@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 06:09:28PM +0000, James Morse wrote:
> We can return on ENOENT out earlier, as nothing needs doing in that case. Its
> what the GHES_TO_CLEAR spaghetti is for, we can probably move the ack thing into
> ghes_clear_estatus(), that way that thing means 'I'm done with this memory'.

That actually sounds nice and other code in the kernel already does
that: when a failure has been encountered during reading status, you
free up resources right then and there. No need for passing retvals back
and forth. And this would simplify the spaghetti. Which is something
good(tm) on its own!

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
