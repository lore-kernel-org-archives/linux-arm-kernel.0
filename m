Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202A821874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6ZCJfjQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sytG6HuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202A821874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oTWehVmZKWQxsWRsq4C2KG8c+lSyZyMZHClNbmOlNtU=; b=V6ZCJfjQMp5REO
	N0Gb5kxpJohZ3aAZJoZjuSWPA1nRFAx7rAZxH2gyu80gNsTgIE3whX2X5eCQo1ZFckzMWbrkuQolA
	Z+79wmcA63E/N7EtZVrPztIh3HTCLtoOZDVELgyLTJBjfZSoS1s1053rMAXxnh54SQODsN+BXYD+7
	72OfUr9UIi/E+TMnhejMq97v56TBzXhVYcV3xu9B306RQQ41RtCoAJoeYxZ329IRe7mgGnTwgRwIe
	Ue77yiaouo1LXWZX1BdVi8JqyDkm+EbJPR6sAo0pFYHcgkt5Y8DNHYMMrNczzZIdPyZygXGt7zyqp
	vS9ubzSjxN/pcF19tp4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfRix-0007S0-GJ; Fri, 04 Jan 2019 15:49:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRiu-0007Rd-Cr
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:49:25 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50E7721874;
 Fri,  4 Jan 2019 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546616964;
 bh=vTbiuBlWy8oEFEO3CSJCQZaK/1TBaTw/SDjVJsn2SSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sytG6HuJuZjPjxmXOFAk3sqcH7v9rxW11+Jm1bSAirS3qR1nHnYJK1wRbloeI9IKi
 pDwg8UiLTF/JFYBAOxcdCA4GBMjnekM0re84P7xBrvuFVAtk6WzIJSKByh5xLnNehj
 oBpAIRsyejjIMmK673r3dm1p5EhQy/pq7WQfxpEQ=
Date: Fri, 4 Jan 2019 21:17:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1] dmaengine: stm32-dma: check FIFO error
 interrupt enable
Message-ID: <20190104154746.GO13372@vkoul-mobl.Dlink>
References: <1546510649-16744-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546510649-16744-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_074924_452679_748EE179 
X-CRM114-Status: UNSURE (   6.72  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03-01-19, 11:17, Pierre-Yves MORDRET wrote:
> For avoiding false FIFO detection, check FIFO Error interrupt is
> enabled prior raising any errors.
> This will prevent having spurious FIFO error where it shouldn't.

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
