Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217CC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E641A2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="namx5bIS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LytRdUfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E641A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eREV1nzcvsNDdCTfifQ+uUx/TcTQ++P88eM6kWHj/JY=; b=namx5bISycfEBx
	EWWfOZjl1Gzw/V6yXxoxZq1oaHJgiqHXmmodpJR+gWmSSrP9RQkjgjVOacKxQSzkc7TCD6eyDUmXu
	+2yI4Wy6DRl37ZKoXtoybGzfKZkMPFUDCsCl5lBrfcu+1h3RhMAIb3MC+rwdCm5YoWilG9a2lifeM
	Ikr+Oj/Yy5kvC0TVsHH+1L/YYZxjKosdJ0eM38cNiCXKPGtXzKM6a2HBx5wUZF0RP7zOG99ZTRYEj
	ifqNoVwKTquOnENtGZzG/PrAiDGaLiVUze0rEbBPdmq5CywMhtinJoJ2zJamelhD03xg+hWAkgycb
	FXeWcaPdM2DDASZC5JlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZ9U-0007FB-EP; Fri, 01 Feb 2019 13:46:40 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZ9Q-0007Ei-PB
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:46:38 +0000
Received: from zn.tnic (p200300EC2BCC5000206D6264C5583287.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcc:5000:206d:6264:c558:3287])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3E231EC0586;
 Fri,  1 Feb 2019 14:46:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1549028794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=i0MCChPfL+Z9b0zZCKNJEZsG1jk8hrvKlUmFO53Cb8M=;
 b=LytRdUfBTMfv6GTei5uI11GFJURWbTSFGYDChUBIKWsNnF+7qjJ9XflyACn03NR3jIDlM/
 KhcE+cLJxvSFQjMjbGbkg1GZXFpRFzuOuvHmJez6M27m7t/FcDVtzxdWPY5tjWBVdVYWnU
 Nl/LWyqcYN25Va32y3xeWbb9TfGsMu4=
Date: Fri, 1 Feb 2019 14:46:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v8 09/26] ACPI / APEI: Generalise the estatus queue's
 notify code
Message-ID: <20190201134602.GI31854@zn.tnic>
References: <20190129184902.102850-1-james.morse@arm.com>
 <20190129184902.102850-10-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129184902.102850-10-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_054636_964485_FD029C87 
X-CRM114-Status: GOOD (  10.99  )
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
 linux-mm@kvack.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Xie XiuQi <xiexiuqi@huawei.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 06:48:45PM +0000, James Morse wrote:
> +static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list)
> +{
> +	int err, ret = -ENOENT;
> +	struct ghes *ghes;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, rcu_list, list) {
> +		err = ghes_in_nmi_queue_one_entry(ghes);
> +		if (!err)
> +			ret = 0;

Do I understand this correctly that we want to do "ret = 0" for at least
one record which ghes_in_nmi_queue_one_entry() has succeeded queueing?

For those for which it has returned -ENOENT, estatus has been cleared,
nothing has been queued so we don't have to do anything for that
particular entry...

Btw, you don't really need the err variable:

		if (!ghes_in_nmi_queue_one_entry(ghes))
			ret = 0;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
