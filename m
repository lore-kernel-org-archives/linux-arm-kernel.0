Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE7EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3F22084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oRSQ49Cd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOA9ZbXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3F22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xkrYckhGanSqVfm58gVW4UgWW6Lp6yCg8lo9Kuth/3M=; b=oRSQ49Cd2zexo1
	f6XEVxvdK3/Mz2qhnMjaLudby3Ql6M0tkwyZ8HYuibpDpXY9yqjNlIY3M98+FHHAc6UqH0YEYswqj
	Ffg8I51mfz5fYig62jvRXFpom89W/4koxjgQa4AYTyEV5coaEj+lOmu3zg6da+GlUBCdBEyfReHwC
	U+iTAo98VEctyOhJxA9y90R/BisJoEabhKVEf8HkmH2u5BiptAclxapy/77JEZDMh7sPQ9BHIb+HS
	Ji6uNXdJYQOPK8EzG6djEL5HTff+Z4FtjWFG1TqnU30wwTRz05rx0nxBFyY1pQtoQcIdvEnQKrAzW
	/cfqsCJT9ZrSNNftegQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9Kp-0004nZ-L3; Sat, 12 Jan 2019 02:47:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9Kn-0004nG-3n
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 02:47:42 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A6B72084E;
 Sat, 12 Jan 2019 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547261260;
 bh=u7yXAAILupFI7Nj9wYc9SYZKxsE9ZL8329mAJXv4w00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TOA9ZbXzzu/OqIck8h59X6AVhpB7pSVXSufasjgXO7Choj0e2Y9D8vldlzDoE+TmV
 jzrAgdNvtD0mJOJW24KFGPZqnvpT8gAaZgb6KhOrVDw67ssUNF/qwl60l0eoOFS7/R
 /BZxBrN7R7a5pWT9CrwaYMB6aa+OazEu9fIIrtvE=
Date: Sat, 12 Jan 2019 10:47:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Message-ID: <20190112024725.GO32649@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_184741_175913_7135EE87 
X-CRM114-Status: UNSURE (   8.37  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> Add the dpaa2-console device tree node for the following
> DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

DTS patch generally goes to the last in a series.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
