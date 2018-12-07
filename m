Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:23:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC3020837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KCx3mx50";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MId2ouye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC3020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bcdAzrxsSJwXqoyVgiBODTcrLtZICx9xbw8S4nSauJM=; b=KCx3mx50ASJHHy
	DxZUk55wjJa76V6ArTIjULL9h9NVDcWttambWFZ27ZmkqHLZNIZMFLeXkUNB0VZ6rXcEpSAI5Wxw5
	nFYGCIYXzRn+XKA4JAx6+ZP00hA21vALW+JNb+zCX+JYyP5uWm8juLMwi+AaPRSqbX6dq5DngyN77
	e0Zfh9IzPQRIGxQzuOQ2DxLg+Uoiuf90a08VkbuYbLXXp9Pr/RqL9EaPfe9A/M5Rk4nKh78FW7XIi
	ZTZt90TrgScx0eFEZ3NBKL9TGlh87NIw3vwl9vJZjZlQ/N30drCrAMP19oQ9IzGgNOj7xWLd6zRwd
	INEjYbxZDzW+apDg3Dtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVG6b-0000YL-W6; Fri, 07 Dec 2018 13:23:46 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVG6Y-0000Lx-Td
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:23:44 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7AsBlK165069;
 Fri, 7 Dec 2018 13:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=v5A6Tuk4/q8ZCdIMJ7iQU7d4rraHEzqZD5t9Rk9xynY=;
 b=MId2ouyeQTscv3Om5GZ7bjrJzHAJEoMfO5lyuyDjAhcjhuoRijAp1/G5235FUzZA6fLX
 nVe7TheN9X4CF8nUWY9z9GNTGNLAdjIcC1epV9nUYRAdn0QywKrZ3lHgmYbu5noRQlcv
 8iMakrS6RyrGrxIZIQMegNtajuehPxasJEb+kdmUr+sUKnzPAKVkTWo8xpj/S+jEYKog
 x2BLT4eiNIOhb1kqJ6vSYJ1KGNbX7/pgO9moAcLO02oeYAYomQCx6zTbEIgCHY/xw7b2
 /Hejc5oUhVKoDtC1RFHVRV+4SsEj+ryVfXNTM1wykpdCH0MppCpKLdAvxs22Vt2uQ9FU pA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2130.oracle.com with ESMTP id 2p3hqudvpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Dec 2018 13:23:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB7DN4WN031697
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Dec 2018 13:23:04 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7DN4RL011458;
 Fri, 7 Dec 2018 13:23:04 GMT
Received: from unbuntlaptop (/197.157.0.47)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Dec 2018 05:23:03 -0800
Date: Fri, 7 Dec 2018 16:22:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] media: cedrus: don't initialize pointers with zero
Message-ID: <20181207132258.GJ3095@unbuntlaptop>
References: <dd25052db89ccf292f2a5e45b7e94e8e6d000c40.1544180158.git.mchehab+samsung@kernel.org>
 <ff5fe553-fee4-bc5c-d1e9-9dc4cc1319ba@xs4all.nl>
 <20181207093106.4f112d0b@coco.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207093106.4f112d0b@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_052343_084144_684A14A5 
X-CRM114-Status: GOOD (  24.87  )
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
Cc: devel@driverdev.osuosl.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:31:06AM -0200, Mauro Carvalho Chehab wrote:
> Em Fri, 7 Dec 2018 12:14:50 +0100
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> 
> > On 12/07/2018 11:56 AM, Mauro Carvalho Chehab wrote:
> > > A common mistake is to assume that initializing a var with:
> > > 	struct foo f = { 0 };
> > > 
> > > Would initialize a zeroed struct. Actually, what this does is
> > > to initialize the first element of the struct to zero.
> > > 
> > > According to C99 Standard 6.7.8.21:
> > > 
> > >     "If there are fewer initializers in a brace-enclosed
> > >      list than there are elements or members of an aggregate,
> > >      or fewer characters in a string literal used to initialize
> > >      an array of known size than there are elements in the array,
> > >      the remainder of the aggregate shall be initialized implicitly
> > >      the same as objects that have static storage duration."
> > > 
> > > So, in practice, it could zero the entire struct, but, if the
> > > first element is not an integer, it will produce warnings:
> > > 
> > > 	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
> > > 	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer
> > > 
> > > A proper way to initialize it with gcc is to use:
> > > 
> > > 	struct foo f = { };
> > > 
> > > But that seems to be a gcc extension. So, I decided to check upstream  
> > 
> > No, this is not a gcc extension. It's part of the latest C standard.
> 
> Sure? Where the C standard spec states that? I've been seeking for
> such info for a while, as '= {}' is also my personal preference.
> 
> I tried to build the Kernel with clang, just to be sure that this
> won't cause issues with the clang support

My test says that clang works with {}.

I support this in Smatch as well.

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
