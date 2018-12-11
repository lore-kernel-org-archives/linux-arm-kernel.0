Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC36C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB6120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tG6LvXcx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zDNqtc07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8Fq7mGZkq5+kvq+jpBn48t+/maBgIXd0CIFSUPoc40=; b=tG6LvXcxS2r0BX
	bfCwUY8QsbtfHu8PFacJoDyZwafzz8DAI7/j8vsYlvzwG4JGz+k9G/xzhGhieV1G9JmS5YMt58cw7
	e+sO079kOOlcVwscjoqw5JQxvZkUxT0mTnMr6a/zHVq6PR9Th1JC+yj29+cN/0EKtpj4F0ODru5u/
	zEjA6nS9CYIVOEvgYnmotcRqgbhPca6Mw1KPuIJROiQHjK5rpeKzXJHd3uMohhrgyZ4bSSDwCymMZ
	ij4+P9lguUHgSf+haUXjuOkxRGM/gpHVnN3muxVGySy76UHjn/GWo/TmYzaPbIth+LjoCjmEQg5LC
	fA3cxNoBIz6DazDW64XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWees-0004ra-5q; Tue, 11 Dec 2018 09:48:54 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeep-0004qU-21
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:48:52 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBB9i1hO009006;
 Tue, 11 Dec 2018 09:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XjFRVw8JIbcqD0DNsTFL7DcZxBNkKthVcwXo1XteKnE=;
 b=zDNqtc07zGygUcgky6YjVpWooaa2U/JOpw137Spq5QaP7BxJ9uQyioKRP9O0vtzUu4MQ
 y9uODH7iFxN7uBT0bVDofYp7QKx6I2z89V93/kPdaj8rQIxu+M0UbHHB0i1R7L79l/8q
 VgwQaTns+ABnTzzyEPsLOoNvJJpj0P80Wy5ajJ2vevRvbqrwEKfSZibeOFztrJbfhTF4
 2g41EzHV+b0EihwMxOUKEHq+HLMCsU0VKD7dtN+iV7PQDTReon0mHgljYKPzaesFqTGU
 kNYB1q2EoMv96kd+MgrVUkIK1LTNQX1rTfK2MWOYLPCYno834IZlkQYaggCp+3xe67hG DA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2p85cu2vpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 09:48:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBB9mRqL010124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 09:48:27 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBB9mPbs013418;
 Tue, 11 Dec 2018 09:48:26 GMT
Received: from kadam (/10.175.35.120) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Dec 2018 01:48:25 -0800
Date: Tue, 11 Dec 2018 12:48:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][clk-next] clk: imx: remove redundant initialization of
 ret to zero
Message-ID: <20181211094812.GB3116@kadam>
References: <20181209150832.9366-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209150832.9366-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=903
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_014851_180356_BE6EBB55 
X-CRM114-Status: GOOD (  17.24  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 03:08:32PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The initialization of ret is redundant as it is being re-assigned to
> the return value from the call to imx8m_clk_composite_compute_dividers.
> Clean this up by removing the initialization.
> 

Just curious, is there a static checker which complains about this as
dead code?

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
