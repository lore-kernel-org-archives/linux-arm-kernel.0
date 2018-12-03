Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEF42082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpH6yHly";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d2ZxDrIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEF42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NVaWwn2VTFZ4SVOI2tfP5XxGBp+9ITuUVKtdY4WeqO0=; b=TpH6yHlyxiU1IA
	5yi8lwrL6TrLRzhOeISgnBHgf9cXwtDw/BOLwf+83S51G7VWGPfCcrIgsnY6uR9QL630BHj68/76G
	TRDBdyskuGVlhzkeZslUURmMbY0jKlTyLQmIS+7mrLn0iD7ixEwBu9yZuR08E39dtP7tR1yCKgASb
	jlxwT9FrGlWvyBGcPRdhqYPPf5hdZrHalHmqy4hGIV+EZwN9jT1MATVXvXlgl4tWNwiPyaZdiPuhJ
	QzvPKauicNVEDaCjIWEa/Ue99JPIbKPb8od3pqH7oXnOg6Hqbpglkmd3rdlbbjeOr4G4mOeeGo/wY
	sjYWhOOVPiYVJ7ZQBSOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToaP-00072r-CR; Mon, 03 Dec 2018 13:48:33 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToaL-0006vU-Uy
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=9yxsFlXY5EARcEf+3IDbJitDBkRbTtpKl039mzjVRpw=; 
 b=d2ZxDrIMAb/2pQvPiDy06G9ZSWyGaFlq0GVP/tqUe0DmSCzSaR38RIeB54Hl3pwJj4WKVOJsHQde9rXEWlMfbhPzEWMpmN2cK5l0skdRg/Umq9/VrBHNf8noIW21+6c7KRRzuH701frnf5mqKZ7iZXCB8i8pKl/rqqOPY6qBc4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gToa7-0000HI-Ae; Mon, 03 Dec 2018 14:48:15 +0100
Date: Mon, 3 Dec 2018 14:48:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Roman Rozman <rozmanro@gmail.com>
Subject: Re: Sfp PRESENT driver indication to user space
Message-ID: <20181203134815.GE31655@lunn.ch>
References: <CAEHvULkCgpHd-BKKbpqB=TPnOGX9i6OfgBO5kHPvt3PAeqZ5sw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEHvULkCgpHd-BKKbpqB=TPnOGX9i6OfgBO5kHPvt3PAeqZ5sw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_054830_146276_98329D00 
X-CRM114-Status: UNSURE (   8.22  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 11:59:21AM +0200, Roman Rozman wrote:
> Hi all,
> 
> Would like to ask what is the best way to receive an indication in
> user space upon SFP module INSERT/PRESENT.

Hi Roman

The proper way to do this is via some sort of netlink notification,
for insert/remove. The SFP driver can send them in its state machine.

What are you interested in doing? Maybe there is a simpler way which
does not require adding new code.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
