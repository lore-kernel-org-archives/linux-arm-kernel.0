Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DFC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3002084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WACNPv6G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GdtVAcZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3002084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hilbert.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:From:To:
	Subject:Content-Description:MIME-Version:Cc:Content-ID:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/E2VJSRRAJaV7+jpmx84f3OCWBF64bfYcT62P9QbOWM=; b=WAC
	NPv6Gu+q/OdaAjf4AMHzPptkPQ9jvB2alZMVuT6hYiy6cxx0O49gujbuaYfNnnNjzeJnRp7ZL6iyM
	G3yK4YOjtwk2r8DppQBzMVw5tyDAU4kEXksbjKXvoGYqqRaAbjbkOjsWg5OOt+QthYbY2hLMg/nMc
	NTgFzvkSUuMss+OQpty1a3RnUvwH+FJ7Nkn/fdC1OJdEf2TOxc+npM2EX7ZJDKPJDtK7l+D1JgmpD
	29YwB+jIQMI6vw1EuswyI14bdk8Ua/msBI1y+dsqCUfxc9xti7nOO0S/aUhLbS/Y6kNZGxZ2q/O3C
	y4Mk2Ec6Sx6aIx+TYwsoMmRhCoggVEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrlT-00011g-Ck; Tue, 11 Dec 2018 23:48:35 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrlR-0000s5-K0
 for linux-arm-kernel@bombadil.infradead.org; Tue, 11 Dec 2018 23:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Reply-To:Date:From:To:
 Subject:Content-Description:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Cc:Content-ID:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EDDYqyosTwTLJerESIrtQ4CY7salTPZk2T6PtT4r73I=; b=GdtVAcZjRFrRCZl41tNOw1q62
 QxHN9TFsBnriNVPzflXJlAmLZn+ITBvFAtiXvxzh09olvI2p/dZoNG2UN5oh9cD/bz+sfzmzKUviT
 uPF0RIzKFD2OlPlgrvD5irs4plYvqoeotf/4vXadig0UO+IQnEPrnrjcHB1IXK6UfpAbs6cIlwOdj
 dURhVvoMuumVx+sxEyhDgMbH+OQAiCzM5YhkS8rr8lIniTs9OKNGuAoFLXctP3/rmLGoAy0UQjKD+
 Rs6ER4fIzmziwoH9aRRGUnYX4U9r7y/j5qEyDRjGuW25Mv0XU0YM45ObU77okyfwSJSbBxxxCUrL6
 n7tHtFitg==;
Received: from r179-27-109-195.static.adinet.com.uy ([179.27.109.195]
 helo=mail.dinacia.gub.uy)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrZf-00080c-8G
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:36:26 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.dinacia.gub.uy (Postfix) with ESMTP id BB1168E51DC
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 21:32:42 -0200 (UYST)
Received: from mail.dinacia.gub.uy ([127.0.0.1])
 by localhost (mail.dinacia.gub.uy [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id oiPyymbTPfos for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 21:32:42 -0200 (UYST)
Received: from localhost (localhost [127.0.0.1])
 by mail.dinacia.gub.uy (Postfix) with ESMTP id BF1B98E349F
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 21:29:44 -0200 (UYST)
X-Virus-Scanned: amavisd-new at dinacia.gub.uy
Received: from mail.dinacia.gub.uy ([127.0.0.1])
 by localhost (mail.dinacia.gub.uy [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id eQIKxElk6-cX for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 21:29:44 -0200 (UYST)
Received: from [192.168.8.101] (unknown [129.205.114.24])
 by mail.dinacia.gub.uy (Postfix) with ESMTPSA id 4EA938E4434
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 21:27:19 -0200 (UYST)
MIME-Version: 1.0
Content-Description: Mail message body
Subject: Estimado usuario
To: linux-arm-kernel@lists.infradead.org
From: "Web-Mail" <aweaver@hilbert.edu>
Date: Wed, 12 Dec 2018 00:27:13 +0100
Message-Id: <20181211232726.4EA938E4434@mail.dinacia.gub.uy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_233623_539282_C0B17000 
X-CRM114-Status: UNSURE (  -2.74  )
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
Reply-To: kennyjames.kjbuch@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Estimado usuario

Su buz=F3n ha excedido el l=EDmite de almacenamiento de 20 GB establecido p=
or el administrador, actualmente se ejecuta en 20.9 GB, no puede enviar ni =
recibir mensajes nuevos hasta que verifique su buz=F3n. Vuelva a validar su=
 cuenta por correo, complete la siguiente informaci=F3n a continuaci=F3n y =
env=EDela Para que podamos verificar y actualizar su cuenta:

(1) Correo electr=F3nico:   =

(2) Dominio / Nombre de usuario:  =

(3) Contrase=F1a: =

(4) Confirmar contrase=F1a: =


Gracias
Administrador del sistema

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
