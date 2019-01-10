Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:53:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2162D21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dD8dRDYK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU5BpzlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2162D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eD5wIgW2JjKWPbhWZpaWQA1eIFVa2XVkumowtWkORMk=; b=dD8dRDYKEfZ/a7
	FELvur+24uW7p/sc4YPvtrunCBETpWP1SCkJ7LO989qDNjIauppwyfPN80azDjKZnP0NPHregJ1zK
	yj8tUP+wPtwXhm62AxR5NWHL3Vbw5T2ZkR4Ly45QJcFPillm45XCLLhcgrllu0hB5SuL/xjgLwod+
	0/04J4L8952kogXdDRK6WOKdPbX6A9SGvyT+pvlVyZ72PDUGG9YHsgnHfuTwkElLXcSIh+FN39x11
	9q9QqGxYOPkouZSgOYYXAn+m+cWDYHQBAKKTlDwWiTxkbNZuB1dmEcahp+fTAowbypsB7NEccQRRs
	R5Jg30tnp8P3mVoBZzmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghW5y-0006Hs-3T; Thu, 10 Jan 2019 08:53:46 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghW5u-0006HT-Bs
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:53:43 +0000
Received: by mail-pl1-x62f.google.com with SMTP id y1so4894262plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XfTn9+ut8GJ0U5x3YVMYmOCYYDA033x5ZT9FTfW1xCk=;
 b=UU5BpzlB+6gBTQQFPa+dH7MWAmmfB8WmTaBxDg27aFdbpWaSi8ur8dgHK2I3zIG0Fr
 BGZXD5HEDVVYKxD2oqFsTYNKUUYInp62IWqo48x2AfeVtuLI86I41zfyt5zqKiIEgOIp
 CnsBId9ENboGJKnc7qpETLxPVwIUOC6U9B7NPHe1nd9RJP7F6agLlIQbNYMFNDcuzTR/
 ZGuFtHTZI4xOq4u6rJeyaU5UFojxEHamQEs+0gRh9T/kfxi5PyrIhCfALLsGktdo7ntE
 4cLADt5pVg+kgmkH0dYT9CCVRuErd8VOlNuJlcM4hCOr7hpNqJZr/5QgF7DfIh9lsf+h
 QrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XfTn9+ut8GJ0U5x3YVMYmOCYYDA033x5ZT9FTfW1xCk=;
 b=MYKdGJqgvs7KiT3+uX6mZC8ScxZn3S3oqULh88rbCl/ouHAfzehNft/DfunksHfMQy
 GOau1HnW6sHutpTvEi74N28yxQE1CBFiTa/+lPy3RT23nfrWDk3RAKOfu1Qid+Rj7NIU
 3JF/SaCoQEAyeylDYkP+QDUIlJtwLSzoKiANU4Z8eL7pUvvL8UGH07chswXOHa4Zk3JO
 SAcD+fvFax/q5yLbeEEh4wIog9dIGlo1p1zMzIY+UVpZfLzXp9mmkuVILG6ZurY2JjFf
 FIry0eK2Ecbww4uQkcAkML4wCQNzlNygsooagSyBKrKkzccn5QISixyOPs2W3Mz/zCrg
 2pVA==
X-Gm-Message-State: AJcUukdoQwisoS3yQuFY1yQsGg/jXowjth0WK4row2mPDlVvG6N8yG37
 5iH0QkikYeIA2PDdRDHs7r9a/OWA9OGgSWj6xkQ=
X-Google-Smtp-Source: ALg8bN5PyrVXQWbb8Qxq07RvXW039VQVlYWUY2qQvgb+Zp3Mw6R5205rsy2mSfwVAl+Xf/ulkNx2VUAdS413eI45Rvo=
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr9356024plp.36.1547110420783; 
 Thu, 10 Jan 2019 00:53:40 -0800 (PST)
MIME-Version: 1.0
References: <CADUS3om=GzsVaVHvcAChivp1cTFYq-5YC_mQr-Yw3ANxbn4k+Q@mail.gmail.com>
 <a5660bda-c4b1-1907-93e4-d9ce9d6f84d5@arm.com>
In-Reply-To: <a5660bda-c4b1-1907-93e4-d9ce9d6f84d5@arm.com>
From: yoma sophian <sophian.yoma@gmail.com>
Date: Thu, 10 Jan 2019 16:53:29 +0800
Message-ID: <CADUS3onK0LVpnALtscHY=cLfJ-UA+08dhp9tH7QO93QVGhp1iQ@mail.gmail.com>
Subject: Re: arm64: some question about default_idle_call flow
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_005342_427515_7F85E270 
X-CRM114-Status: UNSURE (   7.29  )
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

hi Julien:
> A note in the same section adds:
> "WFI wake-up events are never disabled by EDSCR.INTdis, and are never
> masked by the PSTATE.{A, I, F} mask bits. If wake-up is invoked by an
> interrupt that is disabled or masked the interrupt is not taken."
I have one question:
a) if not only local_irq_disabled but also turn off GIC, the CPU will
not be waked up after run WFI, right?
(The PE will not receive any  SError interrupt, IRQ interrupt, or FIQ interrupt,
since GIC is turned off. And at this time, only legacy fiq/irq can wake up CPU)

Appreciate ur thoughtful explanation.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
