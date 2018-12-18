Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23206217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tgNlzZRw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WpvaGUy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23206217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=VptmlQzahDuFYntmUbnuTmXSFE/KShmuq7T3wJ+jvGM=; b=tgNlzZRwhwx+/H
	11RHC5SjInOzYItkoBrBzf1HUKIrU9330i+Prfg+OqSXENViTZyMdfnqg3kfwgSlDd6jj6fm5EKWQ
	YKHNAOIGVw5UBHLMzJPXzEBtGxy7IRtSaqZuZKuNlNYMjghUE5Mi2/3b1d1eV0fLlP/K5wizlitPR
	plChLRuAJPvKEAGcCytD0d3HJKfyRxsONbjxR/FRXJu0WyAPkVkePglQAkDd520WN+ksffkE4wAoB
	oa+FBp9MDXn7ao8kWCswoYkbjTv286XqCWbQgcVsMjqPphclM6pheI7nX/AiX0Phg+RKgEvR/bi1k
	Z2nZTe21F7RjCmWYqvPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAs2-0008Hf-C7; Tue, 18 Dec 2018 08:36:54 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZArk-0007ff-Nz
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:36:41 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI8ZaZx063145;
 Tue, 18 Dec 2018 08:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=RsBm9eP89PoWXRWEMpOtmjaYUjfgq7qFHnXN8yBJSIA=;
 b=WpvaGUy+nkY3/Pg7aXNeiQmMERrhs/0x9G112S+UE/TeQBb8ROIL8dnS0cV1gW0AKeOB
 pDh5XM/RsmHTptx7DOLDLQRAQ9xAaQveYDH08VWTEymcej5JTsI/V0QuxbJu6tVruEXI
 celRprT/OqKtaoLhWp1AAMzrSkYery4X74xPz+T5cxnBMTBTiqW8kM6rULUoqwPaKOts
 A3iCzn2xdhxGycaWWJo54Q/Fc9ZkNApLlr08ZTesFlSK4A5OEkRmkYXVb6X33e7lr4h3
 rdO+W65EIS4L+7MecGyAKAB5odx85/C2PHUkXzrGXHR3lA3M8VLrsGHSPY6y1ZZ3CLFg Kg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2pcq4dsxqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 08:36:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8aJM1010840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 08:36:19 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8aIJ1021142;
 Tue, 18 Dec 2018 08:36:18 GMT
Received: from kadam (/197.157.0.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Dec 2018 00:36:16 -0800
Date: Tue, 18 Dec 2018 11:36:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wens@csie.org
Subject: [bug report] bus: sunxi-rsb: Add driver for Allwinner Reduced Serial
 Bus
Message-ID: <20181218083613.GD440@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218082800.GC440@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180077
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_003637_170783_429EBF3E 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: Olof Johansson <olof@lixom.net>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I totally don't understand the sunxi_rsb_device_create() function.  It's
basically a no-op.  There is a lot of code to deal with sunxi_rsb_device
devices but there is no function to create them so it seems like dead
code.

What am I missing?

drivers/bus/sunxi-rsb.c
   198  static struct sunxi_rsb_device *sunxi_rsb_device_create(struct sunxi_rsb *rsb,
   199                  struct device_node *node, u16 hwaddr, u8 rtaddr)
   200  {
   201          int err;
   202          struct sunxi_rsb_device *rdev;
   203  
   204          rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
   205          if (!rdev)
   206                  return ERR_PTR(-ENOMEM);
   207  
   208          rdev->rsb = rsb;
   209          rdev->hwaddr = hwaddr;
   210          rdev->rtaddr = rtaddr;
   211          rdev->dev.bus = &sunxi_rsb_bus;
   212          rdev->dev.parent = rsb->dev;
   213          rdev->dev.of_node = node;
   214          rdev->dev.release = sunxi_rsb_dev_release;
   215  
   216          dev_set_name(&rdev->dev, "%s-%x", RSB_CTRL_NAME, hwaddr);
   217  
   218          err = device_register(&rdev->dev);
   219          if (err < 0) {
   220                  dev_err(&rdev->dev, "Can't add %s, status %d\n",
   221                          dev_name(&rdev->dev), err);
   222                  goto err_device_add;
   223          }
   224  
   225          dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
   226  
   227  err_device_add:
   228          put_device(&rdev->dev);
   229  
   230          return ERR_PTR(err);

We call put_device() on the success path and return NULL.  The caller
checks to see if it is an error pointer, and prints an error message.
NULL isn't an error pointer so it doesn't cause any problems but it also
doesn't do anything.

The caller doesn't save the returned devices either so there seems to
be a bunch of code missing...

   231  }

regards,
dan carpenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
