Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C178C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:25:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E8B20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RXJXUui8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qMhuxFZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E8B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aKMBTDqXR0o5kXU6DYmEt+JGD5/vloJkNqVLdsvYXik=; b=RXJXUui8dTC4tpH6zJtUK9lKi
	wWm2PepRhY31GrASB2UgKNl5WgRGBmZkd7J84uEkelC5FXpFg8L3wh6cuQ4LeScKO4y+HtIHedQNa
	bfU3OiCskD+J0IWWkIkKZec6aVjKIfMM+XQDWvVhYhsh6tPpBMYARyyeCavb62+j+cycRWMffH6BW
	hHUt4pbly8QFBveS1afwXE7urfoiKbksBrocW+GUKT6a4fzJypUohfUTNIoprF1nAWskxINpPrY16
	aMaLz4YCCN6CF3CrGxRwXAoEBIntBlrAszKZ3lGab7du+60OZtNnjRXwFg0bpHGu53k5elBjX26nf
	6ipPuNR7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKos-0002Js-OS; Fri, 07 Dec 2018 18:25:46 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKop-0002HC-D7
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:25:44 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7IItsv091233;
 Fri, 7 Dec 2018 18:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Jxl3NJGm1hYg2NuAJJ6z28WhG/wv9u1QCvEhDFUuPD8=;
 b=qMhuxFZ/KH9cPbPVJ7wqagDqJ+ECEX3/RWr26CSoLQ+cjqPFmXKo91rXkDFKbEE67YVi
 cYfTMNvVY8YWBzWh7i5ktqaoyQgR2O4BUTQEoZqY6rJMH6LTyylI59Fc/J4SyyGuFShv
 GH6PNyYfYUbOEirVVvHudEPYJYV0viybBDqA+ILnPGtesWfVXaTFFqwULlS9ea0OViAU
 LQ0TWoUzOeOa1AEvyv2MeSyh2dMQLaC+C2gLBP1BQ2Fy7HiY0WHn8lTk83A6ml49aIIo
 N1zjXs3eYRO25MSGOUAPmTZMNCPnTacZ7uyxit30Zl97rsKnQht+dbMXlZR8dO8DfY0a gg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2p3jxry7nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Dec 2018 18:25:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7IPLCc006308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Dec 2018 18:25:21 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7IPKdn022887;
 Fri, 7 Dec 2018 18:25:20 GMT
Received: from Santoshs-MacBook-Pro.local (/10.11.38.116)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Dec 2018 18:25:20 +0000
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
To: Tony Lindgren <tony@atomide.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
 <20181207171642.GR6707@atomide.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <f46f71a9-258a-9f0d-f4bb-b08bf97a93f0@oracle.com>
Date: Fri, 7 Dec 2018 10:25:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181207171642.GR6707@atomide.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_102543_575966_28B06221 
X-CRM114-Status: GOOD (  19.39  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 9:16 AM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [181207 13:58]:

[...]

>>> The 20ms you are seeing confirms this setup.
>>
>> Thanks for the confirmation and information.  The Blaze schematics
>> are also unavailable afaics.
> 
> Thanks applying into omap-for-v4.20/fixes with updated notes
> from Peter for the wiring.
> 
Thanks Tony !!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
