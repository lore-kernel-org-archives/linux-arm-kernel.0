Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E909C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:19:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3D421A4A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6Skom1O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="TPXgVrLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3D421A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e5gAi46hNZYVmYrE/QdKWXgyS4ifpkIlln8COfY+z4w=; b=D6Skom1OtimKXVBKwxLRjTTQz
	kWMXjHOh2emffjnPyn3mnJNxVlIzMvcE+QxOW5mo51wD7U+hgInlaKB3X3lutg5MOANb0/HaRY/0y
	vuhiqNlTGbv9aQcIvSLm1vHNdD46TUuKn7IJCoQpB92zbb269ZOQjmIObN4W+JJzWFJa0erD9Bzhk
	ivqyKyLeWooY9C835BedLLRDfKXbqH5YbKw4brNNfo05iXl954RKZOp4e+PhTzeLynUu8R6/rM0To
	mEKahXWilWVbUk81CTWlh+82MfFGpBxlSZ79GgTYTmKdOGIKx3k4xpbpPj4x4zVlHswNX1s3oW2Ky
	RF2qU7MPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvOEN-00070y-Hy; Sun, 17 Feb 2019 15:19:47 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvOEJ-00070Q-WB
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 15:19:46 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 2B9D162C677F
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 15:19:41 +0000 (GMT)
X-ASG-Debug-ID: 1550416780-055413126614db90001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id e1mqO9Zrm9odPo6P
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 17 Feb 2019 15:19:40 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=58g9Qe2798tfcjzZxIJ24983wnB0PhziXfRYn9tmllI=; b=TPXgVrLNuujBtDSGEA5srOlRKG
 YM/RNnFfmSMfc6SRyfkG5aPS9YHWPeXHJkb7Ak4JpJ9Gm/Egb3ZR1zqvRTvhbiftr1duTshIstEHB
 EApKZuRobQc6/3HGa/AEKbdcCwr5nLEUFzrT9/Hch1N87B1N/UeQ1m8nEBbnJgy3NAGhQVWCpAzr0
 Eb++BTUc/3FUHRuWJI4Ti8LBhiFWviTtJw1crYNzy/hFuOrOZC7h9xOvyULSTLCKtJuEOgp+gbEcQ
 Wf7vwdGYG9ArhbGo/7seSyTG17Ie93l5CzkwMiryFZrtm2pn616HTwwwnQCT4XmwthkOOJv8r1SOq
 s4Z/NW+w==;
Received: from [87.114.170.31] (port=56694 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvOEF-000I9B-Oy; Sun, 17 Feb 2019 15:19:39 +0000
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
To: Robin Murphy <robin.murphy@arm.com>,
 David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard
 changes
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
 <e83b0404-bd32-a5d5-2e32-e0f49b122b95@arm.com>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <2d8ac4e6-b825-dca7-d3cb-57cb32b3230b@davidjohnsummers.uk>
Date: Sun, 17 Feb 2019 15:19:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e83b0404-bd32-a5d5-2e32-e0f49b122b95@arm.com>
Content-Language: en-US
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
X-Barracuda-Start-Time: 1550416780
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 2052
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67484
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_071944_312199_63B745AB 
X-CRM114-Status: GOOD (  18.08  )
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

On 17/02/2019 14:00, Robin Murphy wrote:
> Hi David,
>
> On 2019-02-17 12:15 pm, David Summers wrote:
>> This patch makes some minor changes to how the sd card is
>> described in the device tree for the ASUS Tinker Board (S). In
>> particular on the Tinker Board S, when booted from the eMMC, and with
>> no card in the sd slot, and the log has endless messages about not
>> being able to detect the card.
>>
>> Several methods to remove this error have been tried, the only one
>> that works is the broken-cd and so that is what is applied here.
>
> I don't have a Tinker Board, but the symptom sounds instantly familiar 
> from hacking on another RK3288 box; have you tried adding 
> "regulator-always-on" to the vccio_sd regulator?
>
> With the reference design (which I would assume the Tinker Board has 
> no reason to deviate from in this area), the CD pin is either wired 
> directly to the SoC with no external pull-up, or explicitly pulled up 
> to VCCIO_SD. Either way, when the dwmmc driver probes and discovers 
> there is no card present, it sets the currently-unnecessary 
> vqmmc-supply as inactive, and thus the regulator core turns off 
> VCCIO_SD entirely. Unfortunately, this removes the voltage from the 
> entire I/O domain including the internal pull-up, which ends up 
> leaving the CD pin floating and generating spurious events.
>
> Robin.

Hi Robin,

An interesting suggestion - no it hasn't been tried to always set the 
vccio_sd regulator on. Will give it a go on ArchLinux Arm.

I guess this would explain why the Tinker Board booting from sd doesn't 
see the error, as its enabled probably in uboot and then keeps working.

IIRC though, if booting the TBS from eMMC, then inserting an sd card and 
the errors stop. I guess this wouldn't happen if the power wasn't applied?

I guess also that "regulator-always-on" is a quick test - but that for 
submission to kernel it would be better done via "mmc-pwrseq-simple"?

Anyway I set up a test - so we can confirm this.

David.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
