Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C4C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DDC2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LX65WWIO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RDWXZBGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DDC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zny6hi4x4hP9FwFVFKIhz2UNjgxaxMDzkVLXwDC+qIc=; b=LX65WWIO6CkmEL
	hdjx4Ce2RvizMxMN6UVUCSjlam2vbHFbja/7QurNrpAlDxLm3IGojjmdGNPml67H1u/a2lrKe6Djm
	D0rwFE7HQNJA+XN0gia1WW2eGvBTdEMKxuYswn7Hm3pGMQp+CYKZgYMynXVdCPlgVXrcY6B1jS0EH
	kq0EXRosGPA+pE+3k7GStbrlAVH0p3htOgVNpSKAgVvItC1QJf0ni/nWQo7QssbbhIifu3IQVP7J8
	MdDYsRQUjsRwGhZ0IkDPs+wuY+tQiElR5MIxFalDXlEAVSqUXoVLVAxRSV9Be7sWLlcyU23Rotm0r
	GnV/6CVBJm9RZ/Ixn5hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVf5Y-00013l-ET; Sat, 08 Dec 2018 16:04:20 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVf5U-00013H-Tw
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 16:04:18 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB8G459w027393;
 Sat, 8 Dec 2018 10:04:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544285045;
 bh=Ia7ipjQGbGv0wQiqMBWcm45wmGjtcsVODAoKcWAnnQo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RDWXZBGffk7ZYW8R9rKUMQwwmZ7oX21t6ACs6nAw8HFqWZfzeTK2hcArpytt/xNZT
 7hd/veqWsZy5QKAbT4gXM/3dbYXuON1DjBSDqtc7SmCyzN5WZrKaKNGrriiCMnMUo0
 Ay0A0JzgI2dTfcGvczsz+i4841yFzbV9KgFXF4U8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB8G4581115190
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 8 Dec 2018 10:04:05 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 8
 Dec 2018 10:04:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 8 Dec 2018 10:04:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB8G449c023256;
 Sat, 8 Dec 2018 10:04:04 -0600
Date: Sat, 8 Dec 2018 10:04:04 -0600
From: Nishanth Menon <nm@ti.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Message-ID: <20181208160404.h7cuuq6jvafoxa32@akan>
References: <20181122140519.25166-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181122140519.25166-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_080417_045975_64E6FC38 
X-CRM114-Status: UNSURE (   8.72  )
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
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ssantosh@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09:05-20181122, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Thanks for the same and sorry for responding so late.

[...]

Santosh,
could you pick this up? maybe for next rev or so?

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
