Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D54C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0E420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmF9dlfV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS3jVl+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0E420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vuZw5Clfd/fb/7eC4sfL/gmdLFPp37gZOCGEr6EaQYI=; b=hmF9dlfVSATPVG
	unDmm828iP24XVJo/L6mFvaOpuynnxHqv7gbRhBIEdN2iP8brOdeJ1+qQUq+i0Xa53J2WbfipYA5I
	MBa9apMf7d7cAW42qqfREDcendGnzVQ0X+gPNFLbIgcyMNrpCnLHopffQBiNkahU7lI9173gdhAwr
	IXSUMl5GrQbib6g7JuTuI1P65fRBV2URAbUgx1NFFM4wKhNBoPv21ZMJ0gwrKOZsZh0UWd2Ibk1gg
	hBa7zt/ZNU4PpIVlgAlWkP4BW5I0s2vyf4841QdT5OVk08V3HpPhZVZrtmLqc2+jy6LICsE8dI3OE
	spkSMI2oC3qEv6Ph9Rrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsBE-0007Nh-O1; Tue, 22 Jan 2019 09:17:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsBC-0007NM-5o; Tue, 22 Jan 2019 09:17:11 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F3BC20823;
 Tue, 22 Jan 2019 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548148629;
 bh=riPfo+PaYom+qfXiEE/IofcK17wWSJ7PkzfeJ/8x54c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YS3jVl+v6tyxmwrUIIY6Oh8XaRLakz5CrUCT3W4H1Wjd9XPd/L3wR7QkF8LD4XMCp
 Yipwj1SWWLu6ICaBZNrrErXsWRosFsoyi2tsv5/pzXFicJT27+1bQU6rRWipUzaZg5
 khTD9423TYFBpJEiRGhxKpQHIsUHSlSEy+8/UYH8=
Date: Tue, 22 Jan 2019 10:16:58 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Message-ID: <20190122101658.6bb89d54@bbrezillon>
In-Reply-To: <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
 <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_011710_231782_95B1FA84 
X-CRM114-Status: UNSURE (   6.99  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 09:00:14 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Rob / Shawn,
> 
> Can you please apply patches [1] [2].

No, DT bindings should go through Mark's tree. Just wait a bit please.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
