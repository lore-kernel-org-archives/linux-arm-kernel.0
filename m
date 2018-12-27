Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D13C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F2220882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RENJ1r3v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pLpLlsu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F2220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbKfAQm6TBKpb7s4lrhVIpGAdl5Jt/goYvvPNxTc8s4=; b=RENJ1r3vebwp27
	zJfH02JGlbOqsuWJxTM9XL3XJFCDPRHaju4Dd9l/H2xKSZGYlCVV3DZJBgonv3Z28YE7tAzNMDRTa
	YdgLSkAq+RAHVtSRIN2c81CBeyI1GHaFEsxuR7WbAtoytM6BM9eWW2f7hCmCE4lAq9+C1gp70tarH
	/GadQ9omQxzCWndxUdCX3Z6CryiA4pe8lw1jW7+00iwU+hdrcgqTtvPvDK/kGR4MoW5uDJRmkSTiB
	+3HBE7ajNqXsgROEapveiL70VeYjH4AJUbiph53UnNAOpxvZmMB2wcCLVze4Y5fB1vA439xqgoSLe
	mU9RQCJePzWmGQJc6nsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcW0F-0002yc-Bo; Thu, 27 Dec 2018 13:47:11 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcW0B-0002y1-0D
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 13:47:08 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBRDd30u050865;
 Thu, 27 Dec 2018 13:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wWhlKvi6DYO/+w7JYjA/SNhf/XJAF2jtuIRmY0IuZj4=;
 b=pLpLlsu7wAnzIkELBQItlkruOcNnB9iJ3uXpebHwioUiJxQ1DDDMwth+uHf2+MF+A5We
 nj9KTNHdA7E7/qdaioAPmfta88TiY/cWfqhbU+DqbdpuJBW6S0K8hs2NQpBW22TGLNjP
 w+zkwr/gNluxEunFCkDABo/dN0Y4BZy8IYv+8ba3xrIebAAjT1Lnpfa5/d1MoXelqmNG
 xJuOEkpVEa+6ca8MhwaWsPcEHzCb6CFq7Zmsote4JmrENcGPgE0N6dMwO9XLwGU4vAM3
 vAXCHmSqLps+zZ/QWYuOuWOI9e9epAlBxvpHKm+v2eU2o3vS2FuiRBOF5k1+a6dE4ANo Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp2130.oracle.com with ESMTP id 2phasdwfjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Dec 2018 13:41:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBRDfAD1032512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Dec 2018 13:41:10 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBRDf940020543;
 Thu, 27 Dec 2018 13:41:09 GMT
Received: from kadam (/197.157.34.167) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Dec 2018 05:41:08 -0800
Date: Thu, 27 Dec 2018 16:40:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Tom Psyborg <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 00/20] drop useless LIST_HEAD
Message-ID: <20181227134055.GA2272@kadam>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
 <alpine.DEB.2.21.1812232304130.2940@hadrien>
 <CAKR_QVLeZBL43W4x1mzcfcakSZyyh9L81vgUMxfnSccKawEfdg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKR_QVLeZBL43W4x1mzcfcakSZyyh9L81vgUMxfnSccKawEfdg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9118
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=656
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812270124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_054707_136001_8D7241A3 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 linux-btrfs@vger.kernel.org, dmaengine@vger.kernel.org,
 xen-devel@lists.xenproject.org, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 25, 2018 at 11:12:20PM +0100, Tom Psyborg wrote:
> there was discussion about this just some days ago. CC 4-5 lists is
> more than enough
> 

I don't know who you were discussing this with...

You should CC the 0th patch to all the mailinglists.  That much is a
clear rule.

For the rest, Julia's position is the more conservative one.  I was in
a conversation in RL and they were like, "CC everyone for all the
patches".  It depends on the context, of course.  If the patches are
dependent on each other then you *have* to CC everyone for everything.

If we really have other clear rules, then it should be encoded into
get_maintainer.pl so that it's automatic.

My other question is why do the linux-arm-kernel@lists.infradead.org
people feel like they need to be CC'd about every driver???  I always
remove them from the CC list unless it's an arch/arm issue.

regards,
dan carpenter

PS:  Please, no more top posting.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
