Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FA4C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:19:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6D92084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FW0+Lvm9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="N6O4McOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6D92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0GUUmCEXC11br19EyltWb0FHAZGznf+/87VsIz36g3Q=; b=FW0+Lvm93hvbYUY8RUOBJMlIY
	iv3xCzCG1jDzSA0oDb201f3fbdxjcnirEMot9sCe7cjA/XJc8a9psTVHAjSA4MI6BonrlyNHms05a
	xMCdvgv5mk53DgiefTDSwkA3NbnND5BGj3WEJs5sjdblSyVesw17+V+S3+GTh9d1hIhxCA3vCv3iH
	+KbSHpD5KVJYL4r81k2JL3mfxiu7To7Nho9QESd7dLCCiKT9dJqdvyhA839TWuzOAj0KQ7cWCglrq
	Iodt+/Cg6+AC9wyB7XYwJi2xaMWXV9BvNjg6ad8eKlUCcv67eAo9pjgmXxJz/lbA5SxjkoNty1ySP
	hjyeg7EZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkqXP-0004yX-SO; Sat, 19 Jan 2019 13:19:51 +0000
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkqXL-0004wj-Qo
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 13:19:50 +0000
Received: from uwhbsf01.unlimitedwebhosting.co.uk
 (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
 by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id A03716046C51
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 13:18:58 +0000 (GMT)
X-ASG-Debug-ID: 1547903937-0554135974284fe0001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id
 rVUXnoe8ji2iU2Br (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
 verify=NO) for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 13:18:57 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KK/nm8qlolgtyPfVa1duixwaxfI3jCY0YzBZYMtaqSo=; b=N6O4McODhz6WLFfrNyzy+BC/yZ
 l8aWfhfexyfwJPU56vko19mKg9eGwGBou70V8A+a1ufhXXk1SwKUigVpimlkuci/s422QKDSf+e6j
 8l5mhzfOJSxSbuOFPLVN2Su/ITNskYIHE3VrGzJc0iU0/33X1gaJ1uqG7hTtozT1fbN8SGHp97CBb
 kf6JoXO/lGR6om7sLP/xt11JWigqWlAMoKCQRk6lE1m8Y8CbSnyLT6MyRIMoDY5zx2JRKs6gA4A6v
 V6N5L6/0gb8g5Rxc6AZKJ6piHLMLbKWj8l8NU0fj2Ke7ieDV/X35h3b44uFWzpEQroUGfk1K+dmlm
 +yLk2lLA==;
Received: from [87.112.215.184] (port=55780 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gkqWX-000Ta4-Bu; Sat, 19 Jan 2019 13:18:57 +0000
Subject: Re: [PATCHv2] Patch to add the realtek bluetooth device tree refs to
 the code
To: Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: [PATCHv2] Patch to add the realtek bluetooth device tree
 refs to the code
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
 <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
From: beagleboard@davidjohnsummers.uk
Message-ID: <4b098970-9644-12b4-c6f1-2e66ffbe24fa@davidjohnsummers.uk>
Date: Sat, 19 Jan 2019 13:18:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
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
X-Barracuda-Start-Time: 1547903937
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 2041
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO, NO_REAL_NAME
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65955
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.00 NO_REAL_NAME           From: does not include a real name
 0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_051948_291947_7D38E364 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marcel,

Yes have been having an email conversation with Rob on the device tree 
email list.

he wants minor changes to the naming, which i agree with. So have much 
of a revised patch set read to send in. Just need to check some things.

Hopefully be able to send later this weekend, and it will replace the 
patch below.

Thanks,

David.

On 18/01/2019 10:57, Marcel Holtmann wrote:
> Hi David,
>
>> This patch adds the necessary device tree hooks to the realtek
>> bluetooth driver for serial connections.
>>
>> The realtek devices that are listed btrtl.c are searched on the
>> realtek web site for the version that have serial connections.
>>
>> Most of these devices also have wi-fi connected via sdio, that is not
>> covered by the bluetooth driver - but as that interface will also be
>> needed in the device tree, the hocks here have "-bluetooth" added. The
>> exception to this is the rtl8761atv, which only has a serial
>> bluetooth.
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>> drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>> index 8eede1197cd2..2fec7ff2ce7c 100644
>> --- a/drivers/bluetooth/hci_h5.c
>> +++ b/drivers/bluetooth/hci_h5.c
>> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
>> };
>> #endif
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id h5_of_match[] = {
>> +#ifdef CONFIG_BT_HCIUART_RTL
>> +       { .compatible = "realtek,rtl8723as-bluetooth"},
>> +       { .compatible = "realtek,rtl8723bs-bluetooth"},
>> +       { .compatible = "realtek,rtl8723ds-bluetooth"},
>> +       { .compatible = "realtek,rtl8761atv"},
>> +       { .compatible = "realtek,rtl8821as-bluetooth"},
>> +       { .compatible = "realtek,rtl8821cs-bluetooth"},
>> +       { .compatible = "realtek,rtl8822bs-bluetooth"},
>> +#endif
> I really need an Ack from Rob on the naming here.
>
> Regards
>
> Marcel
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
