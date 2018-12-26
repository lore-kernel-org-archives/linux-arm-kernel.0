Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9634C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7772220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mbPtQg+w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+ndPH/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7772220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ckKwA7vn/IRrREcYgdYspMIPcqx/2Wx6813RpkzlEbI=; b=mbPtQg+wq+fwWQ
	yiluVpaS9dTSWoDk/BKE1wf72+tmOOX95S5W7DMnfZLzi+lyuV2acm6Ma34Br3dKCucn7aJr38I0v
	CK2iFEmGEg3np5L/btmRQGnarrCJ5W72ixDp4/D//1IyBcOOzoEIfytvr6TITaWDNlXQPfPadvymp
	qsM66TR+wZEWb1PJNCiJaCOl+lT85cYqUCiZYbebw1xO8OyeRiFyU6MpHxvOGuISnJn4fXZibchn3
	UEHJ8JMz6j+/PejNWZISQWCpQMuMgNGN6KlalB40Kus/UOF/FJRhRBVuRaN1ap6ku3aOTSfYjMCKQ
	RqnNDoBVfzZ584CLmVEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcDK2-0000dX-Mq; Wed, 26 Dec 2018 17:50:22 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcDJz-0000HL-Ha
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 17:50:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so15010842wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NfWUGBtM9viN9C4UC/IjCRTQC8kLLjM37k48i3T85SE=;
 b=P+ndPH/CR+feCJX/hg0VK9NP5sYDKTetz6KcnB5YhDJ61roMNQ7GliTnNAfa5jHTTa
 Frz4qne6KrjiczPCyK5pAmUn+439MAVVFSn4lhLOyc04Twsr83YV0xAE3XGJC4QPgPWK
 RJjcAbHyQhQQxlHpoRCMt6raq3TTE7DjSRaPrGBvOC39mN7pZDqFe40Oung7uNhZM56E
 Tr979hgT+XKFuOel+f/0s8+GHD7CE+eCy2jjUI8OvIf3Y1Pi/3q8eodFVnBQRfbiHLtd
 K1CUd5lQWoIsyPdqYkw81NMsg84zV1aUcPiWN/U6vDL+uw0n4Y8Lfn/YYx1JwBwDWr3j
 1gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NfWUGBtM9viN9C4UC/IjCRTQC8kLLjM37k48i3T85SE=;
 b=RS54vJwR5eB5CSFLhfkJSpN6AuDfZmcQF/1Dyi/tUEqVaNuRUK/Z/neMpFSi3+MbZY
 KaOU11ckfkm2x9PSJYqSTnO0wFNWamQP2XfXNpNdFQm9DC35DJg9+MGndarJ4eBYeDj7
 If3hTUiK29jaFgiEiBLrw2+/PB96qYRjLnx4QOXxLI2vRc/gq24ru7QbfWAcGS1X3wsV
 MxvwEqxRC6do5i6MNV05YPVo1uQKv8hU8rv/QXy9nndaAxAw4vHsvEZ4OQLcGjU5XGxo
 cqC4mJ7Yab8jC3xUIoHBeVwq8ParnYsChpw3pzeXcr1rgW91EirYUmQC5EYq+W2QEdOi
 SfMw==
X-Gm-Message-State: AA+aEWZuTVNjWu7FzmVH+tsBfSdJ5Jz4jKR1eNhT88LQ5dtlfyYtUcCy
 NbDV56HbdzjrVgNntnb77nQ=
X-Google-Smtp-Source: ALg8bN4rAUtMEhYKzAoGCy2xI8GcVZe6CAQLRMwogB1vFRswE/AJv4Qc68SnxPl0bQMqsoDx9cEAJA==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr18340636wmd.126.1545846607515; 
 Wed, 26 Dec 2018 09:50:07 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e?
 (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de.
 [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
 by smtp.googlemail.com with ESMTPSA id
 z206sm27591314wmc.18.2018.12.26.09.50.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 09:50:06 -0800 (PST)
Subject: Re: [PATCH] net:phy: Add a return value check on bus write
To: Aditya Pakki <pakki001@umn.edu>
References: <20181226173717.7113-1-pakki001@umn.edu>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <07044950-bd40-11be-dced-5c880010088c@gmail.com>
Date: Wed, 26 Dec 2018 18:50:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226173717.7113-1-pakki001@umn.edu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_095019_621819_4BD67CAC 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, kjlu@umn.edu, Michal Simek <michal.simek@xilinx.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 26.12.2018 18:37, Aditya Pakki wrote:
> xgmiitorgmii_read_status() could fail when writing to the bus via
> mdiobus_write(). The fix adds a check and returns an error in case
> of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Two more things:
- subject should be: "net: phy: xgmiitorgmii: check bus write return value"
  See also git history of this file.
- patch needs to be properly annotated as "net" or "net-next".
  net-next is closed currently, please re-submit once it's open again in
  ~ 2-3 weeks.

Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
