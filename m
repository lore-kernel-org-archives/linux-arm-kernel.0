Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B62DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318EE2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKKh8Po+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsQXE6Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318EE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OCi86BcpnkgdLoVzIJIsfEuCfksDFylcrHIS8ZbZ6XM=; b=qKKh8Po+wlaTid
	VRsRoN4lBZXARZKJoBs+gL3J6HZQ7FFaXaZZVsmC/awYKaywIvGUrbJmLvCVOo2iY/KyeEfoEyAu7
	eHpOzm8eC1ukFr9hf/m2UX4FEcOCtdNw2CS2skeXb0K8nfxppv5M5giu33igldJQ5xB5Q24ZBgg3i
	dIxsGvxEpi/ie049qLzkptrhgupqfsZ/NtfnPQ6BQjl9232Oy3RHuqu8TsuN//8KTsdin1b+PtjPV
	W88K21lofLeIRujVLSOaVtuQDZkfndORQCZvzbdhQ3NQow+e4zoOo6rg6eK1amNBny7LKAq+LG7ig
	77FUl4ZKPPPitvjiFqpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gty35-0001Sl-FM; Wed, 13 Feb 2019 17:10:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gty2X-00008L-9M; Wed, 13 Feb 2019 17:09:52 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F7A32070B;
 Wed, 13 Feb 2019 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550077780;
 bh=zLgtUmUW10DVXZeanZL8BHYBbRtGzPuWhu+4tmVWzaM=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=dsQXE6Gb7jeH54YIpX6GG9p/W3Z/RhnFDG0jMHhD4La//sj4Ci86/9bABiiLm6BYM
 RPRjvACu2JxmY0u5FZo3m5i1zjzWdmPlwppe1oC1xb9aRiAj1lqbF7/uP5IsWJmGnM
 Rw4C+Wt69mYsrle7nnFQxDqYijwF2f7u0rL3MZ/w=
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>, kevin-cw.chen@mediatek.com,
 mars.cheng@mediatek.com, matthias.bgg@kernel.org, mturquette@baylibre.com
In-Reply-To: <9db1f94f-7edd-73a1-fb09-9499c5f8cfcb@gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 3/3] clk: mediatek: Mark bus and DRAM related clocks as
 critical
Message-ID: <155007777974.115909.3599235649247866271@swboyd.mtv.corp.google.com>
References: <20190108121208.2473-1-matthias.bgg@kernel.org>
 <20190108121208.2473-4-matthias.bgg@kernel.org>
 <9db1f94f-7edd-73a1-fb09-9499c5f8cfcb@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:09:39 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090941_657225_078D7968 
X-CRM114-Status: UNSURE (   5.86  )
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
Cc: sean.wang@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, jasu@njomotys.info,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matthias Brugger (2019-02-08 05:39:02)
> Steven, Mike, any comments on that?

I was waiting for Mediatek to review. I thought I said that last time?
I suppose if they're not going to review it I'll just throw it into
clk-next and people can fix problems if they see them.

Would you mind resending one more time with a comment in the code where
CLK_IS_CRITICAL is used indicating why it's critical so that we know
what's going on without having to dig into the git history?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
