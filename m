Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C2EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C40120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pojf9JDc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IUKwr0au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C40120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MB7TMv5dBToR1m6x47uqYCHFSrOCFry52kf9ug6Xc5o=; b=Pojf9JDc0LImds
	BqiyGZgtzkcQFJyhu46jiv65V1ccs2MyA5wqVzlEXplKagTbaRavcEZ3ejAUJk5fQCnNzXqwDCUgj
	y17BLMa4P3l1s1+3QowZXXvLwdZ8vqVL7HEorhBHUWX6AiRPtuk5+ZBUJKJeHKYJacGJWk7Xi340i
	n4kFW/rG346YF+YvI0c++QQAXujUFQCofQoGj2CyJYzYUkk/AhlneyCWgogJNYzZfSkWrpzcBwLk0
	PmVexaVNinPl3yC+uC+JCNCCsrQp+DTHSrnxAP5CJwdNtuSOyHMeiZKm/Fmbvn2+Vq/gTMGnVGTxY
	7jlWva/5DAf1c5TXHvPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBrH-00076w-Mi; Wed, 12 Dec 2018 21:15:55 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqR-00050c-Tm
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:07 +0000
Received: by mail-lf1-x144.google.com with SMTP id z13so14643768lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pC+QMC7hAIGjKkrxtYFXjKyVY5RNezbXCKWRha8Z1pc=;
 b=IUKwr0auTqcep4PR/N2tIt6tYkQtUF781nEzU0ZkKE9j4nnVbEtNCA00PYVT5N9iQe
 hliQQsvkgl9ZeL9S10zv4ewQW8ym8vwjgyNXkxIP8RtrBNsRGLBddUhUEDr9LFf/7yCR
 xrd72D1nSta+6rxXIbJWOiI7cnkmURQOpe80VsVS7WzNN60RarebhOhaLPz0A1b7xzsM
 ttIrrKQG6o8WvEel+NDdODj4TWsKpnbLTU4h2WVvemEOLzvR5Yv8WFTyX9nvKQdgp6p2
 RzQMbRA6fAtfwWYyx23LpJIPZNAjla3kMpVRungcp68lJNRTeNmFGI4+VK2ab3KBvK/K
 Ex1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pC+QMC7hAIGjKkrxtYFXjKyVY5RNezbXCKWRha8Z1pc=;
 b=FsoW2oLFK8ka9jsmGuhyQ6xXaUILFXlweCk3VlLEXqPn+oA5tB3veyXyDldzFYdI3m
 VV9Z2cQrpGcd6bbP1PJUfDYUWnfn5NEa3YYM5kglaDGvSMccmRYK/XG+kuRB1t44Te6Z
 oDvGxsQzwVG+vhHoKBKGbXDVhUJQyu4A0kUgISM/n/NmMn2LRM+517LVemIBmfGBnlw1
 cbOLjJe4AFDhYsqS3OsxHFOM5RojUn7QA02Nm8n/E+oEq9ibsk+ELNghGFf62v8g8snq
 yC/LQuwqHYPFDndaslO0wIDgTdpkPv2T9s4sjX8EN3tjRU/gmi40WAFoZU7G4XUJwpyF
 ZyLw==
X-Gm-Message-State: AA+aEWbNb0C8wz0/CfZHSz2byMgl/RqVaYMuoeh88+nWefYiq47/UUJa
 F17h14YYlL3LuJl7MPx5HwdVIg==
X-Google-Smtp-Source: AFSGD/XpgSVPhYPANrgg7sAvnlfdzRbuDnxjcx2sC0ob5helTMJa8fLDXXBzvKpDb/kSR/0Wy33C3w==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr12002789lfj.12.1544649291834; 
 Wed, 12 Dec 2018 13:14:51 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id o25sm3330517lfd.29.2018.12.12.13.14.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:50 -0800 (PST)
Date: Wed, 12 Dec 2018 12:52:05 -0800
From: Olof Johansson <olof@lixom.net>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt64 for v4.21 (#1)
Message-ID: <20181212205205.ouz4jklgchh7sfrn@localhost>
References: <87d0qcv1tp.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d0qcv1tp.fsf@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131504_430488_CCEC037A 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 09:51:14AM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt64 for mvebu for v4.21.
> 
> I'd like to do a second pull request early next week because I saw
> some other patches wich were part of driver series that could go in
> 4.21.
> 
> Gregory
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.21-1
> 
> for you to fetch changes up to dfc1259a3f7a116b96e23e3467607c713c38a383:
> 
>   arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB (2018-12-08 09:26:51 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt64 for 4.21 (part 1)
> 
>  - complete the description of the clearfog-gt-8k board (Armada 8040
>    based board)
>  - declare eMMC on espressobin (Armada 3720 based board) which still
>    need to be enable by the bootloader as it is not present on all the
>    board.
>  - add a new version of the Macchiatobin (Armada 8040 based board): the
>    Single Shot (without the 10G 3310 PHYs).

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
