Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F67C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:53:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64972086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I5hgxncl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh256Um5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64972086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MsvmUlEfGE2mFY/dbz28E7Tmv5B9AbjD3dTruznY4+I=; b=I5hgxncltVBgsA
	/vcTiV8d5pxMHqWg0sqSfcM6axElfhJOgC8ybVShVjp9H7DZYQGlXB5NrfKFEMGybibMLbpA4ZNru
	TzkXajOLlHL3EMCmaCXkXWZjmQYwbbYGq7Bn9np7SuWAxrIhNbDH52DAcrYC+KUnEvq/G2KqKneYK
	Pa0qcNOhDPC/pvTbzEclgJKvOl3YldlyGnGstVRoW1pgrl8FDZgcsXLx/odXw/Xv+TbjQsk0AK1S5
	1xjbwzn9L2PyCXvgEHQujMlEmMFRg2SJg5xU7LDJ+4Qm+H9n92MEqXYvPGKeeSrULUg6Y9FP/K6K8
	MMWfqwREtBf9YDKaNgHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyiM-0003ut-Rk; Wed, 13 Feb 2019 17:52:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyiK-0003uI-24
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:52:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE5A02086C;
 Wed, 13 Feb 2019 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080371;
 bh=Gihc3fmkYKu/C7mgar+ypPMVHeAY3PyKF6QaZhfNYYk=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=Uh256Um577Uxcyuq67gjHB3YDv7hYIyItqpKomHcH97lzzNVqxTnUeZ1nnGXPAUaa
 J25RkSh+hyREIkm6Ezx0xy8Zregz28KQUMHswVmzCOJnQSPm4DWpLBakuG2arXrwgN
 jLVcIYl7G4G4mjysHtZd4+UD4vwmzPeYqESxYQqM=
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
In-Reply-To: <20190208104519.2ix2ujxrpmhqrwlf@flea>
User-Agent: alot/0.8
Subject: Re: [GIT PULL] Allwinner clock fixes for 5.0
Message-ID: <155008037100.115909.17240340756688940476@swboyd.mtv.corp.google.com>
References: <20190208104519.2ix2ujxrpmhqrwlf@flea>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:52:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_095252_114707_87401078 
X-CRM114-Status: UNSURE (   6.74  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Maxime Ripard (2019-02-08 02:45:19)
> Hi Mike, Stephen,
> 
> Please pull the following PR for the current release.
> 

Ok. It's sort of late but I'll try to send it off this coming Friday.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
