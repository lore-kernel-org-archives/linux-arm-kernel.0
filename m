Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAAEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:30:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756BE222E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ad5MDbz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756BE222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oFYGTNvcZuYVqj2psX5rGc4WhWFetj+p5WaHcOR1oRQ=; b=ad5MDbz4y/e9NX
	kx2MFmrhlqa2pSCTuYvToL0QfDa41/mu+sp1LSnkR7veefT086lHGfBh35s38rbH+Ncv5RYOo3Xo3
	dqMUef6ERB5+xQUVu/mW/vn8byiMcf3bg1algyVL6T8EwFDYBkYl19308WyKx1Pcw2SSNkC+Kcsfy
	7nYOzTl8Emami+wT2cJvK/aG28OVdnxR4R3jUzT8CZVs7XCQjiOJ8ltY3fWG3fDLseYYntbcM14Gy
	DIk6+HL/7hqxIl+ttKjsLkYxKP6uoPGaQlIsnkHCeacS9HbDFpA5fyqCioIt8+NOgYn4YoCYlVGO9
	EO1RjZibay6mtusafg6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv5fg-0002H7-S9; Sat, 16 Feb 2019 19:30:44 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv5fc-0002Gp-Qd
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 19:30:42 +0000
Received: by mail-qt1-f193.google.com with SMTP id w4so14926863qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 11:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HvmStWjuxdtKjG+YOiJdftV3HmKB2lSv8/+8hV3rz8E=;
 b=TCCfXuLfuXdxQgrpWh1DWecJVuVuhD4WA6nqrcTqE7N+OboxT5rLlZO8EkIQnBjEn/
 BEALxGCWWWqRRKu5jGUb6SisT09rA/L8jm9uSWd0TVDMONQQJxq9UqzAfQpcKI8fpVPE
 nCuQW2vksj5uIm0ZNsufNhzAGTFLGHCtXmRhimRIW5GRpQlBUiGRYylqrEIcZVxFaHXj
 amBS98HUtia+l/nT1WQ6BjwZHSQYC3Sf/Ve4xt+1k3MxDEi1M2d9xM/OPqKvJ5+0qn7B
 6FTqhLmOiLlMLIOWoEYbXqhJbHL/sREI1Y1DOjScStGOz6mNj5YqPJrn77eWIRkJ5HRm
 jAlA==
X-Gm-Message-State: AHQUAubKxXfbdgaLpH//uw5jsodyqqNyuecePKtlfX8RuNT9LBInl8fJ
 yr6G0AXVjRMmbwaalbJ3iRPTFg6UlAywsYCRzVI=
X-Google-Smtp-Source: AHgI3IamrwGnAXkIl1vqznwpe9bVotrFJvavh4br+3nIXjKO5C3BQzmqQb1ToVnqNRVyafDOdH76dXTNFXgXtDYpDr0=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr11870265qvi.40.1550345438997; 
 Sat, 16 Feb 2019 11:30:38 -0800 (PST)
MIME-Version: 1.0
References: <1550290848-26169-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1550290848-26169-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Feb 2019 20:30:21 +0100
Message-ID: <CAK8P3a3mTsqkyHOyBsn3KPS66FKgEUGqw52XdDGqed8PzbeDWw@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 5.1 - Part 3
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_113040_863000_40DBA127 
X-CRM114-Status: UNSURE (   8.74  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 16, 2019 at 5:20 AM Andy Gross <andy.gross@linaro.org> wrote:
>
> Arnd, Kevin, Olof,
>
> This patch fixes up the typos in the previous pull request.  I had fixed the
> 'If' errors in the original patch but ended up dropping the fix before creating
> the pull request.  My apologies.

Pull this in as well now, so it should be find for Monday's linux-next release,
thanks for the update!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
