Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98989C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653D720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ri1pDYOL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1HVICU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653D720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jXFd4n+6qzKTyja1IWYtFt4LE1dBEWO67B97/iPkeo=; b=Ri1pDYOLEWKcTt
	4bpWrcnVtKbq216NxPrd4xVn7nteUMKBjuHIcIcaQomfsU931SWRpsqnzAWJK3wWvDL+1c5eHpU3/
	tyOrledJPLdllvRZlNzkz7HLx1JpSj534zCotXp891qEdjjr9G3LKstlCIKjwmPbdHKUJwU8ft5Xh
	vHrCPfS0wLBPy8LcsJxEx49ZZUOaHnknvfhB1Q5zaZrMCjnYIb7lpL86C42R74XNv2GuWtwdEIpGV
	xO0rvxDR8M4UW3RnGjfOB+YiTEei5Di7IhOjrliTrirx+fcXKTIWKu2NTJgPh40xB97Olef3CrNy8
	V4sY76Hk+ASs2zQNeeLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV9WT-0000o9-HA; Fri, 07 Dec 2018 06:22:01 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV9WQ-0000ne-Ay
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 06:21:59 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB76IRKn111252;
 Fri, 7 Dec 2018 06:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GNuOUmuoBrkYhLumwHk+4G8qCJHUl+fsa45ndJnt0I0=;
 b=D1HVICU+1yEFOzSNHi2juYgJJxdfZ/t1zvzYcC8Pq2XW1aWyc18tAR4q5cE05j5Z9LPf
 XiV/JKrjg39TjSUCs5FMvkTDFdPaw/K1OLaHeYAeD8g0T67DczvWHO+DahTJZtyWC8pA
 dnz6v84pfxPKC1Vq/EiaCn7WyS0TuEOsESkHTB+CMUzUZVdrn9RT9wQtYosuAbO5FwMd
 8pCs/o3qq9rMm/J90VNibY3nZZbV2N4n79h8wvoFNxu1gUhoHKeGB8jZJCyAYutF9sGs
 qm5fL694oLte93NygPPFF5HX/8EEVSvDsuTuttcpY4ylci2jJqS8DdvGaeOZTDI1YBnU 1Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2120.oracle.com with ESMTP id 2p3jxrv0mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Dec 2018 06:21:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB76Lchp031782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Dec 2018 06:21:38 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB76LZqE025035;
 Fri, 7 Dec 2018 06:21:36 GMT
Received: from unbuntlaptop (/197.157.0.47)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 06 Dec 2018 22:21:35 -0800
Date: Fri, 7 Dec 2018 09:21:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 00/10] staging: vc04_services: Improve driver load/unload
Message-ID: <20181207062124.GI3095@unbuntlaptop>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=555
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_222158_511317_50C80201 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: devel@driverdev.osuosl.org, Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This looks really nice.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
