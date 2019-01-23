Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63D321850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WfnBS2fc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kW1i0yEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63D321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DknPPIdX4RbI6usfL4D6Yk1RPDDlMx5o17BjzU+0rLE=; b=WfnBS2fcBYVxVb
	sms1EP3PUaJbvp8sf8CS3W8dYehGnz4KXDVrb8+A0HeJ7iuQJVDkVHqhDihpDiXYkB3G9RqLqJMse
	gNhapvsiIsBYRfCDpybMeoocjc5rcDdpvR9XpUuXaeZXJZWiE47uK/tCATa7eLQRZJWNBOONubCYn
	rdg+00d7f+eLZCJ2Ap7rdBHJnxjamWnt6N72EPVSmdxx7cI3jOKSJ27w45QZCYYblPeh+obvtotSF
	t6hDOv4Hlu+Pke+X448ehToQhhDbH6Lr7vrwYC/Jhc+dGfnnouEEGHkWdhL8Y156Yc5FWoUz5Qk+5
	JqaHkfyPg+sauVbC1yfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmK55-0007v6-BH; Wed, 23 Jan 2019 15:04:43 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmK51-0007uk-VB
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:04:41 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NExZFU109200;
 Wed, 23 Jan 2019 15:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wqvT8Wb+W0AmbwGKCCcaLqdACPOdE/nTR7hWf9yNQnA=;
 b=kW1i0yEg7/5XZxmKxsmebigFyBfig/VaSmJkqufYV8/AhDkZI7IVM7k9s79hol9TmuGV
 n7LQE+Sd+/IPFJ6fxKk+EgVxb48Z0jiqgDusozkFYJRWHU4KimO62xA+Y3M7PWk9T6DK
 iZemFqNOJ0xdcdm22vdquEsUpYC1tEuaSL6I0HEuKKGlTHesL2XHlylumYaAd2M9ZUhH
 3p736MsLh4xgVU6MAHu0cvt5hEE/RFNk9Tgxs1fWxWQI2zrRg5JQTNL5J3w7YCgs+e8c
 IbGshnhlJAbrGvWye57ct1cg15XtGg2ngG7rEa5+isdYshsRLZdFzGX7tdDu0u4eGV9W jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2q3vhrt8ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 15:04:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NF4Hm8000923
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 15:04:17 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NF4FQw028179;
 Wed, 23 Jan 2019 15:04:15 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 23 Jan 2019 07:04:15 -0800
Date: Wed, 23 Jan 2019 10:03:36 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v7 09/16] mm: add a user_virt_to_phys symbol
Message-ID: <20190123150248.GE19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <c9a409397fc608f7ae6297597d9ea3d21eeb3b38.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9a409397fc608f7ae6297597d9ea3d21eeb3b38.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_070440_138064_4EBC8E74 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: Tycho Andersen <tycho@docker.com>, kernel-hardening@lists.openwall.com,
 linux-mm@kvack.org, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, tycho@tycho.ws,
 ak@linux.intel.com, x86@kernel.org, hch@lst.de, kanth.ghatraju@oracle.com,
 jsteckli@amazon.de, pradeep.vincent@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, dwmw@amazon.co.uk, keescook@google.com,
 torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +EXPORT_SYMBOL(user_virt_to_phys);

Could it be _GPL? OTherwise looks OK to me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
