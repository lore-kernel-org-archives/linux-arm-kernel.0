Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A87921874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3XdBWnd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTfXivrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A87921874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lnn1T8YdKrOMoOk3HJFneYNQhgh5dyKECwBOMnPNcnU=; b=M3XdBWndmIid0h
	eC6Y2rxnjS7Yn6qPOLaiT3cRv0943fiVsCifn0i9rr7jUySGI/F98XxzhhA0YfNVr1mFYe1Yv+4Qt
	V98vMtUHhDjIPvJU/WndsVrbyG/5Vq4h0T1BYD/3N09VNErQefErYUGxMzb3Kw2AfkLsJ7rcuROZ/
	3Dm1FZLfs2fNVwDaZEdDDEhojT0kWnWyzx78tdyvax3viLSFIRrvj42faWD4HBjRKhiF2HJnBmVUO
	697NfUEVn+8Z6Jw6NPtuxHjdGtzvc03/teAkHc/rwU3vQ3iabpcMyI0Zp1KVzOHGgyQqeMy9hYA1C
	UvjEz6geF9un894cbnRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfRmW-000108-JW; Fri, 04 Jan 2019 15:53:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRmT-0000zg-EZ
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:53:06 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43BAD21874;
 Fri,  4 Jan 2019 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546617185;
 bh=1X2YWCiiAw6GXRwBak3l2fbQ50ZWUEPB4S95Nrr5h2k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTfXivrHU/jq1REgJf8/EmqL90xMZBO2umo6MBSYr8lozUO6F6pEuDWRah1YmgYKj
 CSXNt50+yhgGpn1mrURAqAJq8KYbYQaTk+MdRdMHspyqtgglblgYssI5OoDglUwnOg
 l3VpvGraRiGcJfojZxIxy2AwJm+eJmegqAozLCIU=
Date: Fri, 4 Jan 2019 21:21:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 0/3] Add PM Runtime support
Message-ID: <20190104155127.GP13372@vkoul-mobl.Dlink>
References: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_075305_509201_E32B7EAD 
X-CRM114-Status: UNSURE (   7.73  )
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
> Use pm_runtime engine for clock management purpose for both DMA, DMAMUX and
> MDMA

Applied, thanks.

Folks have been moving away from using conditional compilation around pm
calls. __maybe_unused is a better choice so I am fixing that up, will
send patches shortly

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
