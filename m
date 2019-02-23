Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:44:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED0D206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnHhhVZh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="KsDXP/ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED0D206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cz+lkprTPaTdMa3GwoU2SCpkzYuCYhVNr8xRD/IxkHU=; b=YnHhhVZhUHY95LwMYWAJLRsW/
	IlW8tO0yse9Wn8zm9lO0Xut+L07W9TDMgqjLHqlRqFx13BJ9tdCJth2D9LHQ9ugmI1Fo+qLv5RKoh
	UEcRusbNp2sNm1rq3twsBIdj17v4RYv5V1NFZL7BPWjuOBY2hadGDneMelv5M4wUTHuoVrPjQd6BF
	Dlj1KdFecoyv3tovJ0gPKYISlqED47jSR4QnG7b9Mpfon0oD2Y4wt7YB22mqgxfaoGN31Zb5/7S6B
	eqD/ly6n3mfu/M1xXs8sFx3wc5H9nS+/FKYYMxQKfSmVmrM+vORCjLqlX1B15aDfA+ahxGXYMZbmq
	wTVcWQSvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxdDD-0008Ei-OJ; Sat, 23 Feb 2019 19:43:51 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxdD9-0008Db-Mh
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 19:43:49 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id F05A360818DB
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 19:43:01 +0000 (GMT)
X-ASG-Debug-ID: 1550950981-05541312665c80d0001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id uG3Jb470TqlCfhzX
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 23 Feb 2019 19:43:01 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tESwWlKCVhSSfA//pW/ZgoiLKKEc2KGLp3xJWyVQBOs=; b=KsDXP/ZKdOSpxm0cWP6D1/gUdA
 Y3Ohy4xolpLETUqrujFQrD/TDoy3WlZEAoNp+pPgOtX7jTev9Ghr79t7fUZ4NdP02cwxbsy5CicaC
 sN29W4ArhcZmPLWZpKfdClsur6ItVv/MYEkVJs6pmznmOkwEB+4RZ1OP2PS0dm1cnqUqT8JF/dZVv
 /Sx2SbWcsaViIWwKdO4dQyi9RcZr4Xmrs+QY91b1FHKNM+Kbtnmoq79TBwrV2DNn4g3f4+9M8jI0h
 b+ZAqbbBWn0AdPr9SijM4I6NtSItNIUxaIN2B9x+zxS9UYNkVXJK5MukjP8piQJ532fA4rc7MeD+O
 8V+jXg1Q==;
Received: from [87.114.170.31] (port=36404 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gxdCO-000WfW-CJ; Sat, 23 Feb 2019 19:43:00 +0000
Subject: Re: [PATCH 0/3] ARM: dts: rk3288 Tinker Board (S) updates
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 0/3] ARM: dts: rk3288 Tinker Board (S) updates
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <50952b1a-4645-5648-2732-8051d6ed6af2@davidjohnsummers.uk>
Date: Sat, 23 Feb 2019 19:42:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
Content-Language: en-PH
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud706.unlimitedwebhosting.co.uk
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidjohnsummers.uk
X-Get-Message-Sender-Via: cloud706.unlimitedwebhosting.co.uk: authenticated_id:
 davidjoh/from_h
X-Authenticated-Sender: cloud706.unlimitedwebhosting.co.uk: beagleboard@davidjohnsummers.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Barracuda-Connect: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Start-Time: 1550950981
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 1104
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67779
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_114347_874496_EC7A6BE7 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/02/2019 12:15, David Summers wrote:
> Find in the following patches 3 sets of updates to the rk3288 ASUS
> Tinker Board (S) device tree. The patches consist of:
>
>         1) Changes to sd card, to remove error
>         2) Add WiFi to the device tree
>         3) Add an outline for Bluetooth to the device tree
>
> The patches have been developed by both Stefan and myself, and hence
> have both our sign off.
>
> The patches have been extensivly tested by TheSaint on ArchLinux Arm
> Forum, details:
>
> https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=90
>
> Each patch has more details on what is covered.
>
> David.
>
Oh yes - should note in this covering patch, that the 1st patch to 
correct sd card detection; has been updated to v2. Now as this was the 
first patch applied, it may affect the applying the second (and third 
patch). So if these need to be updated based on the v2 version of the 
first patch - just let me know. But whilst sill in the reviewing stage, 
might as well stick with the original post for wifi.

Regards,

David.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
