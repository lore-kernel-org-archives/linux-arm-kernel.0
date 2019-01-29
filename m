Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F55C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027B22080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9bd0BoH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y1X2bi7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027B22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FVLnhvqXMof7gg0BCR+4vBRTWBo8Z9GjOeneYfGRh60=; b=m9bd0BoHdGCkd9kOqkMX97BmL
	LGErdiErc5C88zlFZsWSRVxTe3GinixgHg7r4C2/6iakbbeaBqrOMeMsn0nTqsvOSyYQU7CsooLTy
	JFWIh327KrV0R+MIFvn8PLVQVhGf8gLXkq4kiPNXXRiAM4Wgqvg1iZIj42LPROSyj3cptaL5XgOT0
	I3nTXBtHaeKuDpARkY3hqoKbUWHx7Zom1uxdOEcGdLqcPIJkfzp+a6+OeffWXDApyWuxsLifIQ3n4
	tl2gLYAhtXWi6tbTPIUtVyJalr/H2RQtv2Bsr4WcXaiqYykpN7Hc0HDHeClHKFIQSIHw3hH+lJmTW
	++xhuFsqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYDe-0008WE-9Y; Tue, 29 Jan 2019 18:34:46 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYDZ-0008VA-V6
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:34:43 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0TIYD8L133387;
 Tue, 29 Jan 2019 18:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ypH7IrrNSWOceZlUho1WTRsdQ0nuKO44mMungza/3/A=;
 b=y1X2bi7nnXUjeIWIjUSzEVgsrcIT92rw30GieotdgqpFwtJaIOTEm2ZegvstNJwbrNSu
 cbeFf9WWZLbJnlUho6RCSKlcNEPLSMAYlU6vVl7ELkDm0vAZmgp7gLEeYK5CXQvY+P86
 idvn1WICvXOy6CkFdMo6R/qbZYY2k5jGWHQxTeSxxgljIcoKgx6C4flhPwrtUOR+OKd+
 5nAMZDVzJFv1dBKDbhivXpMF1ZoZxg2XWJbXcf9W38JBOi1TDVzAOdH4UNUeDsXmJcvy
 seZdzqSLQzM035hTrUpUcYoZ96t47xlEbG0UhnVJyU7qjDIRIL7jIaH6ib6Ao8t3sKWe Ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2q8g6r64y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jan 2019 18:34:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0TIYXVX004572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jan 2019 18:34:33 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0TIYWsr014197;
 Tue, 29 Jan 2019 18:34:33 GMT
Received: from [10.209.243.127] (/10.209.243.127)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 29 Jan 2019 10:34:32 -0800
Subject: Re: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
To: Nathan Chancellor <natechancellor@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>
References: <20181211004114.28029-1-natechancellor@gmail.com>
 <20190126191115.GA25003@archlinux-ryzen>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <d7057508-8800-8998-f9fb-1db5659d182d@oracle.com>
Date: Tue, 29 Jan 2019 10:35:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126191115.GA25003@archlinux-ryzen>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_103442_088466_82EA1053 
X-CRM114-Status: GOOD (  21.42  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/26/2019 11:11 AM, Nathan Chancellor wrote:
> On Mon, Dec 10, 2018 at 05:41:14PM -0700, Nathan Chancellor wrote:
>> Clang warns when one enumerated type is implicitly converted to another:
>>
>> drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
>> enumeration type 'enum dma_data_direction' to different enumeration type
>> 'enum dma_transfer_direction' [-Wenum-conversion]
>>          chan->direction = DMA_NONE;
>>                          ~ ^~~~~~~~
>> 1 warning generated.
>>
>> While DMA_NONE and DMA_TRANS_NONE have different values, there is no
>> functional change because direction is never checked against DMA_NONE,
>> only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.
>>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>   drivers/soc/ti/knav_dma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
>> index e05ab16d9a9e..6285cd8efb21 100644
>> --- a/drivers/soc/ti/knav_dma.c
>> +++ b/drivers/soc/ti/knav_dma.c
>> @@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
>>   
>>   	INIT_LIST_HEAD(&chan->list);
>>   	chan->dma	= dma;
>> -	chan->direction	= DMA_NONE;
>> +	chan->direction	= DMA_TRANS_NONE;
>>   	atomic_set(&chan->ref_count, 0);
>>   	spin_lock_init(&chan->lock);
>>   
>> -- 
>> 2.20.0
>>
> 
> Ping?
>I have marked this to picked up. Thanks !!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
