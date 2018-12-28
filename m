Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0378A217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7+W21rE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2ITBvzjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0378A217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M2EpiIIA8Srs2ymiCJ3+vP/jmRXoQkCzcDpc04fImCA=; b=p7+W21rEx+K4eh
	ZkUoTuuH96KyPkTnbdZIf7Rn09WZ3kg1jHI57CTUXGr8ffy9ZWvZRZVBLtyDVtzmfJ3v7vhFR5+Vz
	Q+9SP4/PHKyiWt0DXiCS+mGC2e3OhhS/CBJ9tuOHUyR+tdPwnvPxp8TYfAkyqFuDqOdAPTneyXxr9
	FFJAkcgScmKSag3Ija471JsqcY9PPtVwTL3wroH7F7IU/XMb8clifgdkOSFFwtOAAQ3D7Wb1KKbx1
	Xt17n8I58367PJChtdsv4GPPIjCKUGCLKp3o3P/ht7MgJgHIBsjZklyfUjuXIlO6vGMRaL3UnGEhb
	6078uxoUOM529dGjcK5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1Yf-0007z1-UR; Fri, 28 Dec 2018 23:28:50 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1Yc-0007h4-68
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=b8DrLsjyHNsZXeg+k49cXtNTGzGkv0JmyZlRczsLYVM=; 
 b=2ITBvzjjjzOdhofyL3SEwSK/AWtCz1uaR9PsVSQ67/ca5bjVjItr28GfzavG+9DZYfkCUZn07xz9Iore9os5CRqxnsRJOd7+tqMQOlXrtWMjM4c+LFKBJ6kRyRZcJW7wn3oASVcKj8o7i+J8vOFpwr9cM7HAQDy0wMVm0OiCBYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gd1YN-0001hU-W2; Sat, 29 Dec 2018 00:28:32 +0100
Date: Sat, 29 Dec 2018 00:28:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: Re: [RFC] phylink: support for devices with MAC sharing SFP cage &
 PHY (e.g. Turris Omnia)?
Message-ID: <20181228232831.GA6117@lunn.ch>
References: <252d7259-057d-d312-f440-612360703708@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <252d7259-057d-d312-f440-612360703708@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_152846_377291_66207631 
X-CRM114-Status: UNSURE (   7.27  )
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
Cc: Tomas Hlavacek <tmshlvck@gmail.com>, uwe@kleine-koenig.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 12:14:55PM +0100, Klaus Kudielka wrote:
> Hello,

Hi Klaus

This is a networking issue, not an ARM issue. Please discuss this on
the netdev list, and Cc: the phylib and phylink maintainers.

     Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
