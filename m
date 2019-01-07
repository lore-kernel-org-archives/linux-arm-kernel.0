Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25621C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E8C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gz1FvKTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VffUrVQNWL4HGZ5uum6iiICQhPN5GEDH/R+xfR/2GcE=; b=gz1FvKTi9Ub4eJRz40Nd4r+zZ
	iRlNlkA2j4Cue1V79h13BSkQa+6ve89RbS95VY77Zgok0zk2uEjFPgG9x7y4mDk6qUnTCA5XzSzyD
	LqEmYcGStyTUQJ2aiKjswIOuS2T0GFtwsLdYDGoiqXKXvGGM+fM1wes0Hj21yZrm2xy/zk8FOWcfu
	egN8djQSGsFfYCiRqPoo7iw4jEeuTMnZAysu0txRUj7xgZcMyCYN+6TuEJS52/h6/dsOVNmd8g7ql
	nT7cTvJU5AlJbTEg1fpB9u+ZrPbNUplYPzZezSSarUzPNP1JMga7gV7rKIGA+mYRmuiIGZDqZeJFo
	O1Tfb6jVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggbZg-0003EH-Du; Mon, 07 Jan 2019 20:32:40 +0000
Received: from gateway21.websitewelcome.com ([192.185.45.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggbZc-0003DH-Mz
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 20:32:38 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id 0640B400C6E8B
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  7 Jan 2019 14:32:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id gbZPgd5Wz2PzOgbZPgI0IC; Mon, 07 Jan 2019 14:32:24 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=51050 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1ggbZO-00451U-Ll; Mon, 07 Jan 2019 14:32:22 -0600
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20190103201408.GA27754@embeddedor>
 <20190107194324.GC3313@kozik-lap>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1abcd26c-aa10-9481-ed53-3c3654842757@embeddedor.com>
Date: Mon, 7 Jan 2019 14:32:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107194324.GC3313@kozik-lap>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ggbZO-00451U-Ll
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:51050
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_123236_791290_68CBC79A 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: linux-samsung-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On 1/7/19 1:43 PM, Krzysztof Kozlowski wrote:
> On Thu, Jan 03, 2019 at 02:14:08PM -0600, Gustavo A. R. Silva wrote:
>> Fix boolean expressions by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
> 
> Thanks, applied with fixing up -Wparentheses warning. I think you should
> update your GCC.
> 

Thanks for that.

I wonder if you could take these too:

https://lore.kernel.org/lkml/418252fcd77472413ce15ac3df167e448a4defe9.1546667177.git.gustavo@embeddedor.com/
https://lore.kernel.org/lkml/2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com/

Thanks
--
Gustavo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
