Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBB62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r2r9JBWZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4ZyTf+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBB62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G/1oAlUsOsinnX/7Akn9Ikii31Vr1tqiMHMj8UqtrSQ=; b=r2r9JBWZ4I/utp
	ok4iDaxbh6WkNJtW245rbIeW4hdO/TVP5Jga8QVg3GzTlhJorCWuLIyOuRuCZy6sJH2qvtZtkNpmj
	cJn0KDOURCyS9yUU/Fm1Lu34BefGTVRwIdRrCsgF5ST+exUtfAPKrIavXVRiACrfyU2OVWyrwAMnu
	8L1TTgQ5/Y/AFFGQjLJ/6QCsqdE2Y0fzbUBxI73j6z508+4g7IQST7WSaKYaCAI2zNHGqrzKyncyI
	rd1SOEaYIi8xWrk4Npmfy//jXGWiMwgoedKYt40Qy003MKDojS3an7PEeDZFD8ZPU3C2iZ++9WAMN
	n5Fn51OU5DP1DMwAuf/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1ZK-00075u-1m; Mon, 11 Feb 2019 02:43:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1ZG-00075U-FW
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 02:43:36 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A5B92082F;
 Mon, 11 Feb 2019 02:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549853013;
 bh=5yItu0gt0I1xrBCHE6iTfiWNu84AGCGj7JVYcSOG5Dk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M4ZyTf+KGdJrTirOMpX+4U3n1i/X7AGc6/U92Xp4XRmnrw4mI3aSTLClnMyvQcybl
 6qV2+3bUdBiSs8DEI5wkn1S02xeJ4+Y7N5AFOqz/db9X8Z2EBvV5w4jWPQ1+SULgni
 dsovxPeJeM95qKkKUY3BqYxXKelKu1lUsxTpOzzg=
Date: Mon, 11 Feb 2019 10:43:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] ARM: dts: vf610: Add ZII SSMB DTU board
Message-ID: <20190211024321.GH22487@dragon>
References: <20190205231641.21508-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205231641.21508-1-andrew@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_184334_534610_BD4A7023 
X-CRM114-Status: UNSURE (   8.10  )
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
Cc: stefan@agner.ch, linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 12:16:41AM +0100, Andrew Lunn wrote:
> Add the Zodiac Digital Tapping Unit, a VF610 based network device with
> 5 Ethernet ports. One of these ports supports 1000Base-T2.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
