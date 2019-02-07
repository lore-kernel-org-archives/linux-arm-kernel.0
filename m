Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91AC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F0C2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0P+98Ed";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILYdGyWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F0C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AkjsE9fnqQmfZp09m+ZHbXZ0QVu/I1HBvVBJOi6XrMY=; b=p0P+98EdBUN5gm
	X1ozZe8qma7HLQ+x/LnGJhDutJTXRNKz39vGXG0+EV5dcue89XODHTfl5370ugicEQQihghwf5PcA
	hF4feZcT2xOVgXUm5jcJFUlXOGGIH/hM1bdi754CVFjOPaXztvmEQ32CyUjSmAV3FwgoetxKkHxs2
	aSem5FLCIA1sOjw6C6Qx7CTskhfypP9MseYI1lzQnp+cYfuMxyLnM16gw+83T5wEtyzBbCWU/t7xF
	rpvdOMrDRyzPTKAkZ1XAGph1Zi00dSIdamn7Av486GhflCwKweIF2/lI2ssgA68EN4bl2FhH0BAns
	bQ9C1zguuHbrkC7BjVRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1groIl-0004N7-4w; Thu, 07 Feb 2019 18:21:31 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1groIi-0004Mh-7l
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 18:21:29 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so4999004wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/4eJDqA94YOxwyYuAVdf957HOJ8fq4Zyj/OTXBZpY6I=;
 b=ILYdGyWPNg7Jmf1YFNeQGePEKg+FrwekjejZqKtS9yU7tOMdyQ8ufIkKMrFgybpdbM
 f3jRIxtavTtAFtYIWzX2ccgII23Um94o291GNE6tlxUwXT4H0B6CEspm+7IJMTT2zqo0
 YKl59MrarKO9vRmdFQ7y76D1xcIRpLVn48fZlkN1jDx2fzoZWjbogdhE/euz7uXi0ZpE
 MzMKaqJtOfEhDQZC8JfQ01u+5Hm9eDwQXvmnfTpZ3rPmnS2GpRhJ01PBgEd1Y8uZo2Pg
 n2Mxd2EOPQBQwiPTQ6os6G0YYwktIoJXGZe6ltZ7Zbx7kblJz4/Ca2F9KiqhdbcEeJBz
 6r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/4eJDqA94YOxwyYuAVdf957HOJ8fq4Zyj/OTXBZpY6I=;
 b=gDruuBuC//oOJfcu+dXYBA+j9DOKQQwvNrsb+CymxX5+07NTtNlUKG5vfjGXBA4Kz5
 kuM4NsTtqX/oFexx+prtvElkKv3Cz4an4MXRwyb9bt9ZA2zllNwFrsUTAv0NUcdRozDH
 hr/R4nI3FCxyBd+NC9+FYEM7opUE3mIwglM2YVAeiOmKwfKeC2uJK6X7udz3Eic8m8h3
 hIWfkqgHftWvcqVf1wJAwtstme/J1Hj0YZf20yDwOuN12T69RR0qQ1924oFubW2n2N8+
 npGYcKUFmGEMA8KfrLGCZf4pXU6RXe5MHvIeyvRpuYm13fj7hUaofchbvRI3jnuRYTQy
 NB1g==
X-Gm-Message-State: AHQUAubrzuTFcnGCJytaR3W//HGWTMVcI4Gm+NMGZFL5G4P1OcEOSvP3
 gIQVS+O1l41FSnMqLfw3X9A=
X-Google-Smtp-Source: AHgI3Ib61XOgR122rX9iEEeLLHS77YKwedYL6f5PQA0Rjajzw0x+7aByR5DGXYCSOOiI0ne6eMcbjw==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr8704335wmd.67.1549563685141; 
 Thu, 07 Feb 2019 10:21:25 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:a906:e81:1a0f:97bd?
 (p200300EA8BF1E200A9060E811A0F97BD.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:a906:e81:1a0f:97bd])
 by smtp.googlemail.com with ESMTPSA id b14sm33043657wrx.36.2019.02.07.10.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 10:21:24 -0800 (PST)
Subject: Re: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after
 config_init
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-2-maxime.chevallier@bootlin.com>
 <20190207134807.GD23970@lunn.ch> <20190207145517.08bb8975@bootlin.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <349385df-3de6-63e0-f1bb-6085c50b9840@gmail.com>
Date: Thu, 7 Feb 2019 19:21:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207145517.08bb8975@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_102128_284663_7459C2C9 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07.02.2019 14:55, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Thu, 7 Feb 2019 14:48:07 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> On Thu, Feb 07, 2019 at 10:49:30AM +0100, Maxime Chevallier wrote:
>>> We want to be able to update a PHY's supported list in the config_init
>>> callback, so move the Pause parameters settings from phydrv->features
>>> after calling config_init to make sure these  parameters aren't
>>> overwritten.  
>>
>> Hi Maxime
>>
>> I have a patch which makes some core changes to support PHY doing
>> runtime feature detection. I would prefer to use them, than this.
>>
>> Either I or Heiner will post them soon.
> 
> Sure, no problem, thanks for doing this. I'll be happy to review and
> test that on my side.
> 
The second version of the patch set comes in time because I was just
about to submit parts of it on Maxime's behalf. We may have some
dependencies between adding the get_features callback in phy_driver
and this patch set. Maybe the patch set needs to be splitted.
I think tomorrow or the day after I can have a closer look at this.

> As I said, I lack the big picture view on that part so my approach was
> pretty naive, I'm glad you can take care of this :)
> 
Don't be so self-effacing, it's good work :)

> Thanks,
> 
> Maxime
> 
Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
