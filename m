Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48617C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BDA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aFxzShCE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Cxpj2mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BDA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pyhJI6qA16JtQaSnkw8DJ/P3couBfDeq9engtrtO6Ek=; b=aFxzShCEi2GxU9
	OAKjMzKszcxOFrgcJwxQUlrz7fZJ6IOXOZ9h1A6MiYEN9z+c12xlzAZJPYCVJy8fK/pX/ipegCgMj
	S+skro13j9dtormNaDKsQbeWU49aAtWhebwsllSoDIkspq6HQbLMRHQLpVs3cq92E0z+/RpCnYzOQ
	rNFWyBF1F4RH7uCazipldF0am4OmvrvoJKk6+Z+VtYhfh+k2pCc3W9/liM4JA6OixZobsrr7pXoPi
	c3WgXcnNX4ZZ1pg1c5OKnNEnSbKO1y8i1BJniips5i2eGU8tLfR4nnrNjy6pMwbMi9v7+wZHsU2Gp
	QaAVH4HXsP6yHzf1q6IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWexc-0004An-KM; Tue, 11 Dec 2018 10:08:16 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWexU-00049h-V4; Tue, 11 Dec 2018 10:08:14 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBA3fep187673;
 Tue, 11 Dec 2018 10:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xcfh6X1iCfgCIOM5TA1lbZ+h6nUBiMBhdmWu9whNHn8=;
 b=3Cxpj2mklIxyFEdp+01BAfDwnqtq0xOZ2gNzCfthciaFbN8MJzR1qKX3eMPaKmBBuo20
 5/QyQ3iXJUjdznVZi5QphWKcwGpj+8U/4VABcvqYczNq2A9XAJ0H2cKolnZLwsipSq/b
 6p8yWceMC9JmaPjGj9APDcvTKo0zEC2oMHHLafc9pA/dDFosrSPwHi2l+6TZM7I8iehT
 N8rx6ZVcUMXWo0Ou8850U81orQb0CbkjgQ8adKIkLDEbKOvJKkWFbNJY3UHTywCwzmVQ
 EJGTSIC3hrUVcNv3W3dzxfU08AF3RlmdP2Av6ZF9x20ZMhAtqgXS19as+jSAG3D10nQX xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2p86kqtx6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 10:07:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBBA7eNj001895
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 10:07:41 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBBA7du2024301;
 Tue, 11 Dec 2018 10:07:39 GMT
Received: from kadam (/10.175.35.120) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Dec 2018 02:07:38 -0800
Date: Tue, 11 Dec 2018 13:07:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
Message-ID: <20181211100728.GC3116@kadam>
References: <20181210211231.4084251-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210211231.4084251-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020809_131889_AD8D130A 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tara Null <tn@fastmail.net>,
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> Note that I'm changing it back to 'killable' after the previous patch
> changed 'killable' to 'interruptible', apparently based on a misunderstanding
> of the subtle down_interruptible() macro override in vchiq_killable.h.

Oh wow...  The non standard down_interruptible() macro is ugly.

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
