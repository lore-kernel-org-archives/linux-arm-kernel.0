Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D7C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798D9217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPFRRHo8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZQUiSzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798D9217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jyjvuw/nlNcJaEB78ZXg9lDxOfmv9BQkkQUg/EzTUSA=; b=bPFRRHo8/uZ89d
	jQk08h4+PX53rXdjbM3eL1AYnniNcc4RIL3+M/d3rGP/s9MWchv0pU8oLde9AmxRbnHVG0EGSI3rK
	JDFa78fRTvcCR+ma/LnZJn0JO+MI9mM2Hkg4/M/SY0dyovfMWwqTW1Bwb/QJz025QAv6cIjTj5Oxk
	yo8XFgldHCeTNVMQtiZ8CRM4YoSz6qdi4+4x2lqHLuWVZ1VV8SJhP9kehgGYuHr5E6J1mPef4Y2Jw
	OONEjokrDholbJbQ7A7xEtHh1wbGGjjjOxGibCfrnvGI4c7mm5jO74g90O/P61w2pr6QiSmyxphhH
	r0uBOppDKbJtcvrs+0gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZD9W-0002fp-Lc; Tue, 18 Dec 2018 11:03:06 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZD9O-0002dD-BL
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:03:04 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIAnOPg187667;
 Tue, 18 Dec 2018 11:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F8lqsMrDytiaH/ZEVRUBEd+G6Pm0T/HUYVD2Frwil+k=;
 b=YZQUiSzg/B/FewIVD3d94xh/khPuv3XmCIsMVtGBd84+PcE9t/VxmvN7UemE26U8eioi
 /kvWc636OMjC1LK6Iba0r+hSdZKLQAkQLwJZR+MfuNpP40aQP4bUX7Au3VWyyrrQ69+l
 Ep7lJsHMTytciWh+fXk7Vy2eY96oRwVlmmVmjnz9hGgV3J3JatRaqVTVKnVN0B7B9mMl
 584oa4Y/51hR5eSPblhDurXCRP4Edn68eIKolweethPK6aboPORII+9Rl/wv9HdU0LU3
 sLr2BKQDvPW6TxfCxKHDELpPqHvjlst4EXH8Iiam8XWGbe/cnrsQvR3h+7XJ4JiUxZHz OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2pct8qthet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 11:02:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB2epN003762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 11:02:40 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIB2eEl030373;
 Tue, 18 Dec 2018 11:02:40 GMT
Received: from kadam (/10.175.34.47) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Dec 2018 03:02:40 -0800
Date: Tue, 18 Dec 2018 14:02:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218110245.GH19692@kadam>
References: <20181218082329.GB440@kadam>
 <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_030258_478325_F58ED7DB 
X-CRM114-Status: GOOD (  19.85  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 08:54:36AM +0000, Leonard Crestez wrote:
> On Tue, 2018-12-18 at 11:23 +0300, Dan Carpenter wrote:
> > The device_link_add() function doesn't return error pointers, it returns
> > NULL if there is an error.
> > 
> > Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> I assume this was found with a static checker?

It's an unpublished Smatch check...  It complains about running IS_ERR()
on things which aren't an error pointer.  The problem is that that
happens all the time intentionally so i haven't published it.  I should
probably make a version which only complains if it is an assignment from
a function that returns NULL.

(Even then it's problematic because it can depend on the .config)

regards,
dan carpenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
