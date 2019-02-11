Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15592C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D802D20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBP6zBuk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHUuqiOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D802D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8+/MBNAMBl/ikNYQDhdWNbKICnaryeVz9LJF7zQxjxE=; b=LBP6zBuksJUJw/
	N1UUtN0cJpPpUCodJAWqC8PnblFyTp7vHD560F6yqVYaskljI5oqp5rCB1SO9oGDHqsn8OwvJO0IO
	HAjcSUMtF8iIta0mwWYZMVybViPpVBQ/iVOhTOHqiw5FHTr054ulN0cDw+4q3ZBbp0pvF9UEpGyv6
	mSd1BtQybsfOHCNudJyz1VYGRPeKtXnACdEn0VhFX8TEmMXSDpB6mr5F7F+Ev9hTAajqeK5G2XN6O
	sYkvU2ccuPICk46sQovY8XgePtjJK3eaFsuYi/zOZrolD+asy00taNoFZjCuRHH3Bog1wGVpgEuKD
	bXbo9CFM6Pcw4WBCEoSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtA6E-0006L2-Hq; Mon, 11 Feb 2019 11:50:10 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtA6B-0005jx-I0
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:50:08 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so5145408pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XU49PgCv4RL4RMGCazRuBER6V4Ggwit8dUrBrWUroqw=;
 b=HHUuqiOoeKfoeVO8hnOkhpT2F59MwVnqpiM0JPJqy0sQSc1oh42kbDF8hYsYrUiBtB
 XeQCa3FVpxXLYDvsCVjSSDMK30H9q44SfaZjkv+Vkw1AcV1KsUPaLC5Ag1Dfwh/k5San
 whtnTjPHtudE6bfNBbIx0wULGYNx/qbf7yk5C8XviNl69N00lArSfEOR9BdgpZrXtix6
 zEGT27c5wYbexzHGULnj1yKeE9QPJWO9KniqBU+0PC7jnZjeNFJPR2nbzipjGmVnq6Cd
 iifuHgUWB9LL8nRJIe1RPCKhmzxcHwXgo+Auxg6EPo8kfRaM5nUgf8mFLeRwyBQ78e/Q
 6FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XU49PgCv4RL4RMGCazRuBER6V4Ggwit8dUrBrWUroqw=;
 b=G2UPlh6UILK0G5rluUQDa3dYJRwhc+yWxzxU48KbWShdTs95fHwiWkoOOYjoiJkh3x
 oe/+OpzFBM2YTkUHpgXJdbFrquub7gimme8suFb+Jwo4ihWKW/gowv7M622ZMaSEMzZs
 vq8rcDyfKadRB1HD0SPziDLKCCzvOCpWbxUmpAUxmyYCjc4jD8AW/BR6dIclTXiyrVZI
 gfpIUWpGCPyWoztqymMVcCayoUVr515gwnUBgh+MeVemeDxl3UTeFu/hHdrDnkaqgpGN
 zUNwE/FDa3PcoanS4LYiN1bMfaxc8Jk1qv5njDkhIkxe+/QAAD1aOUsiYjg23mW/qj7N
 2R2A==
X-Gm-Message-State: AHQUAuad2Cac75CiPGYOe2cxG2UzQnYGoAn/Ha4rWURdfgw08yxbJDJv
 fb73T+ljxEwTdl+Hi+22mQ/zAGNgYBT/sMHA388=
X-Google-Smtp-Source: AHgI3Ia6ajnFnMVIOuZweBtgscHaivYNLDJxZeSjYG5wtTZaM9lvactiu9hk+HNCEQeXuJfaFx+dhqHw3ig2QRQQNh4=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr35994658pfb.232.1549885806138; 
 Mon, 11 Feb 2019 03:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
In-Reply-To: <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Feb 2019 13:49:55 +0200
Message-ID: <CAHp75VdUCxx=Hybv8nyd9nTUJ4+8FLeaRM3bCxezAFvdSN0EkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_035007_626490_702DC4A2 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 1:46 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> Hello Andy & Darren,
>
> I'm wondering if there's anything more I need to do in order for the
> patches 01-07 to be queued for 5.1? I believe I addressed the issues
> that were pointed out and I believe the patch set is already in a good
> shape.

I remember Darren did some review and according to patch work he is in charge.

I dunno what Darren's plans are, but if I need to look at this series,
it will require some time and may miss v5.1.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
