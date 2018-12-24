Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 04:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B5D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 04:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jBsHJ4vd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjMcAr/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B5D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.asiacob.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:
	Message-ID:To:From:Date:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1dYHOMSOvK2pneCL+6LUCpvI8LBEMYbUjUMm/96sQCg=; b=jBs
	HJ4vdKd4wlFFUe7kID0/N0ph3MLuE82o8aE+hGaRgKCV4jccsNpV3QGI9iproAs7PVBT5YMFQXdOe
	tc3MtDDiVOxOHa39Vp7SJQFtQ4Q/tNjKlOmmwkQLTGP2pyhptp9vtjF2+Ny7BucotOiiI1SOWCDB2
	s3M8hkMn1Y0CU2CS49QQejoC5rSFexL8qQa9isBRu9wwOmp2bvEEUS4jpJ7ng0B6CLESKShrl+zHW
	B6lxKjH33VeB90VRZgkJ9RYxgzHQ33Nux7U0mnWxW/3QSLFGXycWsOw1OIbR5BY2jrxECQdEGLTSL
	wt5WrQaZfLN7ZAIXvmbCNPtgwUhpZmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbHwV-0004KX-Ao; Mon, 24 Dec 2018 04:34:15 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbHwS-0004KK-SX
 for linux-arm-kernel@bombadil.infradead.org; Mon, 24 Dec 2018 04:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Message-ID:To:Reply-To:From:Date:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PACHUPhPa0bGIUqlay2A0RhyP/kGU6Txw3OlnUaK7c4=; b=mjMcAr/3CJ4eu+XGroN74qLlpk
 idLhsjpGSFzO214e8FMJo/NMY5875BRyV07FsfCsseEE8EQ2Ru54XIiiw2IRPIzHND7xNwXAaN8w2
 Z7KXOjLryNqY18GU7azn/nWmQAzV2bERkVqUH5YOzXqCaXrNvtd4ITIeDsBYQ1rHxaK5HJGGgnPEN
 ci1vNFRVhPlckBNA30MusIdS0U3HwaHiJ7vNTe2PbCCBLQnG2j/S0smOWEYTtbAUqFtAxZlmSODOl
 gsEMmwmG8jnRBSAggOknXPci1it25G1an3gCaRktKjTKn3zEaFQ2HVrq9S5FIFucmEw/m12SxeJxw
 8sxhV/jw==;
Received: from [195.22.13.238] (helo=mx.chimarrao.pt)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbHwP-00076Y-Lr
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 04:34:10 +0000
Received: from 192.168.1.3 (217.217.179.17.dyn.user.ono.com [217.217.179.17])
 (authenticated bits=0)
 by mx.chimarrao.pt (8.13.8/8.13.8) with ESMTP id wBO4XS3d021656
 for <linux-arm-kernel@lists.infradead.org>; Mon, 24 Dec 2018 04:33:30 GMT
Date: Mon, 24 Dec 2018 05:33:27 +0100 (CET)
From: Peter Wong <Peterwong@mail.asiacob.com>
To: linux-arm-kernel@lists.infradead.org
Message-ID: <22497222.180990.1545626008308.JavaMail.cash@195.22.13.238>
Subject: Investment opportunity
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_233409_996768_0941F168 
X-CRM114-Status: UNSURE (  -0.89  )
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
Reply-To: Peter Wong <pw178484@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Greetings, 
I am contacting you for a proffer to invest in any profitable business in your country. 
We offer a quick loan at low interest rate, if you are interested E-mail: mdpeterwonghk@naver.com Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
