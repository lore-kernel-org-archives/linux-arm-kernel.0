Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D823C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:30:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F1F21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SzpYD/Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F1F21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ng8SQNaXyX61Xg4GNjb14YKy/D/Y0dLMI1Kl2mqiwno=; b=SzpYD/TrUV9/ZsOpMgmyrUfGY
	qaezFZKf2DMVuHSMmasVxod9yThZU2nJ8iT0WGIok899OeIA95k6qHyiGQXfqzWzxWrqxtPUuMnMy
	mrnqth0AzKNt9mZm5iTpAcHS4lkD4VE5WnszfqgCpNC/WWq4BlRAPAQP2kbCOx7CKVGwVHrVZ9w00
	D7JwZCYSYVRuwLbwnVnxBqSr5E3TFmhF7aFImvhV1Tv561bYqts0bqJRsYFJ2ysSqAkDWC8SkSGUQ
	RHmKseDa3McpnaVFNnAeOR5mMNm4wnx95wWhJlxW3vfkTvzTysg5A+JzLzgzUwvI44DfYNQAdj7zW
	4ssNDBzDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaW7Z-0004pW-OY; Sat, 22 Dec 2018 01:30:29 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaW7W-0004ov-TL
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 01:30:28 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A205DD1F38AA1;
 Sat, 22 Dec 2018 09:30:10 +0800 (CST)
Received: from [127.0.0.1] (10.40.57.36) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sat, 22 Dec 2018
 09:30:10 +0800
Subject: Re: question about broadcast invalidation and atc invalidation
To: <linux-arm-kernel@lists.infradead.org>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>
References: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
From: Zhongmiao <zhongmiao@hisilicon.com>
Message-ID: <b3c7db29-6142-cdc0-e319-9800020a6469@hisilicon.com>
Date: Sat, 22 Dec 2018 09:30:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
X-Originating-IP: [10.40.57.36]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_173027_125104_1A900D99 
X-CRM114-Status: UNSURE (   8.56  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/21 17:31, Zhongmiao wrote:
> Hi Jean:
>     Now Soft need to make sure build atc inv cmd to smmu after Execute
> "TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The
> smmu automatically sends the inv atc command when smmu receive broadcast
> invalidation ?

Sorry, The expression is incorrect. The reality should be  "Why not Smmu 
The smmu automatically sends the inv atc command when smmu receive 
broadcast invalidation ?"

>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
