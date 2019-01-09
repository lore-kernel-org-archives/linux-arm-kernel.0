Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259BDC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:00:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C2C20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dj6OBU59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C2C20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Br3OlnDvc2GwrFnzw0p7VN466T/uot+Hh1vIGuvkbSI=; b=Dj6OBU59Dv56YK
	oCUaRJJ6ad7dCcHHuWLk53n1Kbspd1J+28np6QGMPg+XkDhTaln2n5jQknYq8xF3KvFJBueUjuRui
	L7PCLvx+48z3nXfVhgFYuXZFmIa44hWC8m5McIcHMta2VouTshE6FzfMoEmkohoJOmXjTcYfTJDzY
	7x9q/Av1C6JIZQtpBdFK5n3sPAjSsSMIqHp7WO7X/D6V/My8a4LxVWxizsrDFR5nK88/iEZ8GJ8TT
	OaliMy/LdOX5Y4PlyPscKXnDgFQ4unIc7OtLL4H7DJRhs3VgB1+OWltwWBSVelA3qmvnJhUFmSHjp
	NjQKNOXbMbk2NGdbaU8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJ5s-0006Rw-7u; Wed, 09 Jan 2019 19:00:48 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJ5o-0006RL-Sp; Wed, 09 Jan 2019 19:00:46 +0000
Received: from oxbsltgw03.schlund.de ([172.19.249.20]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdpG-1gsnov1vMc-00NmAx; Wed, 09 Jan 2019 20:00:15 +0100
Date: Wed, 9 Jan 2019 20:00:13 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>
Message-ID: <1966518233.54588.1547060413944@email.ionos.de>
In-Reply-To: <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
References: <20181212235150.6491-1-eric@anholt.net>
 <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
Subject: Re: [PATCH v4 0/5] BCM2835 PM driver
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:xe9R5NiMj5STj4jz1+DejXlRv4idZiMxmQwZyvUdKsCduF8oMsW
 A0Zi21xKcDqhGFwhkeneIdrV/aoL37XFrjVlQPj4BT628jYyEegl/tHTfZBimhqkUPo3EAM
 hg+8JeqTf3IeXL9Nna5s+jFTqFePa0sApA/B8wjJeBXAp3mju3EYSXt3IBK2oqdLZmpTmD4
 K5dSRPWaDgBs9cm0pN/Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEN39ddn6aI=:o3oBq9HYGiR1Fwm4iPZXAK
 +9nsslsvaCMFLziOrafwf0jKO8/klF9OJ809tks57L8n6nAQ4SXA7XBee43UqQ1i4Bi3Io8Vv
 i+gj++ILw9pbPSdrUcR1bIUHUxNwCB5aCORiPrPA8EQUpaB07uJHwvGC1vvRIua7kdej2Swyg
 NRGZbkBNdRllUTKNafx16keGEF8sm8AZjNzvwFRVTczgjWaDrShRABgPTM5Q0GiVwdgQ6Lq0R
 WVstAmsNClCUFVEcIreIRTXtyH1LoTvo0Hw6T9VjXll44oOB+3IA+RWhsG5+Ihe6XVOzKNyJV
 Liid4Zmlweii2A0TiLT0aw/EaOQpjtHZWM/K6RtIQCJEiPMkkNUxMDPXtuTDXHHiw96ypnN1S
 tGhF8uEOPTCkNUNlw4UlhtpH3D+J1ktqq/iZMIUlL13WVdjnkHbKIWnzg5EDZHEWNsU2+hN8m
 HX4gV4IZtrTudnZoe2t2wgl5Xqq2E6bHEtb+T3hILUkI6FgxK0lacHgB9nKVcFQ5P3J+l4cK9
 srQ0vjTgH2zsEYEVZ3nTsW4TLwDFtdidLNAk9bm5mBvMcWTOWtXc8kH1uJ7x4byAOMAylUMYE
 9spRqEJ1uAw/u/JzqqUGGFk3FYrXcHLsoki2xR0RyWAKZPEZX+NEWiLbR37giq2xHrcIjN0ny
 EuTlZGyGmdWTP0USt50kuh+j/wHBq4UPo/XZvPFQflxEdB74d5r1a58lS1TWuQnnfjBHhBdsK
 0mASgBbugV98sDt8flr6zoXHgTfViLcNh2BFCY+AyJLmOaRauij5ohFEFEc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_110045_234991_A19B18FD 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 3. Januar 2019 um 16:56 geschrieben:
> 
> 
> Hi Eric,
> 
> Am 13.12.2018 um 00:51 schrieb Eric Anholt:
> > v4 adds the system-power-controller node to the binding as requested
> > by Stefan.  No driver changes are added to make the power controller
> > behavior optional yet, since it's really unrelated to this series.
> >
> apologize for my late reply. This whole series is
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 

Applied to bcm2835-drivers-next / bcm2835-dt-next

Thanks
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
