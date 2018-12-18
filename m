Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35335C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:44:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7147217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dliKQRnj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="RkygvoLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7147217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ISR1Qn3iBcy1xSWyy1yz2nRQN8pgtCO4gTTdtpJ6gKU=; b=dliKQRnjS2l+/0
	CH3WtYqqbFr2yy7DWk3FzkYp0lvsqOFFjiuaxM4CsAKmkyKPf5kPIfnsb1gEkgzY7P3JkHBel3F6k
	rDHZ/5W44XXk8vBnIu/7j5u2K8EUzqBEf9ufoyvu11h5J3iSh3TLXuMZdXGDB/ni4iIarCxXtuLUE
	9xmQOIbmoaafQa4Zcxt5IMG/0Zhgotw/mk6M4vR+U0DSxEukToBqMp3qz2duJvY72moCnhog+XkNM
	w9zBujkJ74ORpfl3f52gvFW+qqH1cxyLdyWG6+E3RdlyloF6vTyFeBFZ5O+jxc125nI5qljJoNYm3
	CFMNok3Qw9XgYcdXVfRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAz2-0002lv-1X; Tue, 18 Dec 2018 08:44:08 +0000
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAyy-0002kw-LK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1545122628;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=jtm+tEqSskImUcAoezRxF7sXvjQpC+PLmEiGDpUSkP0=;
 b=RkygvoLCPtgBJR+QmrE55PWEcoPHP1Eo2MNR+Ijwa68efhD8984sLJu95B9Zx5+waj
 bgfQbnSpB4iMrTIZtH2vtV99qsjJBqC/f2JlAcOjvnYc6TccjdRLM0ExGQ0T/+58Kvyn
 7Tykwm39KGo9nCigYb9QkHRhgEm1jGwrJzF1npkMjSE3UhlRe6PNqX+c1iqn8hj1Z3Iu
 pGEsaHQPYJjsSja/DspZz7VooRkSEGnKAhYaJukuW8+sEYJ+QOEdk08pAcVGZ7TV3J71
 7p9KXABU06HCI7M/XgzOzTGN17MuSxpLo4pLwDqdDytTEtg0F1kT116LFlsKezeo4me4
 ezuA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-03.back.ox.d0m.de by smtp-ox.front (RZmta 44.8 AUTH)
 with ESMTPSA id 60186auBI8hlEM5
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Tue, 18 Dec 2018 09:43:47 +0100 (CET)
Date: Tue, 18 Dec 2018 09:43:47 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Simon Horman <horms+renesas@verge.net.au>,
 linux-renesas-soc@vger.kernel.org
Message-ID: <1923069837.495488.1545122627493@webmail.strato.com>
In-Reply-To: <20181217131052.18790-1-horms+renesas@verge.net.au>
References: <20181217131052.18790-1-horms+renesas@verge.net.au>
Subject: Re: [PATCH/RFC] arm64: dts: renesas: sort subnodes of root node in
 board files
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-IP: 85.212.91.246
X-Originating-Client: open-xchange-appsuite
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_004405_290034_D06B4AFE 
X-CRM114-Status: UNSURE (   6.81  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> On December 17, 2018 at 2:10 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> 
> 
> Sort subnodes of root node in board files alphabetically by node
> names. This aims to provide a simple rule for consistent
> node placement to reduce maintenance burden.
> 
> This should not have any run-time effect.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
