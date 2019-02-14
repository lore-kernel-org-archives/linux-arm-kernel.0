Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D364C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAFA2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="udWGIZe8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dz2KSoaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAFA2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kb5wiodslWxfd8bP+QSOOF69Vk9W9KKoc0HfWf/NPxc=; b=udWGIZe8BrZJQQ
	iM+JU16NEh38kFwLLy67st7WJ8zjamKa7qxuACYsjZ6/Gwoc6IlpCyMQbUay3cMK5Bn5W0eWC4Jje
	VJIpzurNpQWzua+Fu9+rPTkNOEvYcQ2d2vfhvZ0P7AZfq4yGkNdGYHZLpFfRLTbSEd7ufCIYRRZ+/
	U54M6P4VeiSOjOPaEfN1z6+xpzdwdz0pkhXTI+/o5fXnby6tavlg3arLnuOVqRT2YiKuUG8wgxcyU
	rcVDy5tJcCVS6aAzWp+EbchmUx71aB9qBpCNsFuWckEEZAx8RhDGUf0XtXUUhnktl/QczDTX89rMm
	pJUyDTxsOwY2GNJa2TXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guNAO-0001wl-UV; Thu, 14 Feb 2019 19:59:28 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNAL-0001vW-7w
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:59:27 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EJrseS067506;
 Thu, 14 Feb 2019 19:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UodKr1fXU4B03KwJD9SdR+UIiFpP5cWdJfx+zOBFFho=;
 b=dz2KSoaSHx5EwTIfMkUMYh75KBTt6+5VYapY90JnPP3YN45gOftu/wFTxrsPeGsbmK5h
 +visaHIEiAvue4Xd+4bGNgYt7lbfc+zYfOXEQzRMHKJUFxnV1tG6g65+q5tfG6aA3BpA
 D8TtR155ODag8FBNXzn3S6DTZiyWB6F0pJdzRGEzuSmzl9Rz9LQqmIfzNKYzbRnN9bc/
 lBRUIM6Y5Oq6+T6oN6RGvDzO6uL4zNKXvnmZ+PsB2H2eDIOrR+gKGarWeP2ch5DMY2ik
 Od+aJaE2jMhXzYO/HAqzB74XTf11f9opBt+Bj0bQDOut39OrK+J4N+QoAE3ahIa8FFHa fg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2130.oracle.com with ESMTP id 2qhrekt4hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:58:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJwus2011554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:58:56 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1EJwuSJ018915;
 Thu, 14 Feb 2019 19:58:56 GMT
Received: from [192.168.1.16] (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Feb 2019 19:58:56 +0000
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
To: Peter Zijlstra <peterz@infradead.org>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
 <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
 <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
 <20190214190803.GQ32477@hirez.programming.kicks-ass.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <3b55fb25-9571-2208-4e04-052cd6dd4fee@oracle.com>
Date: Thu, 14 Feb 2019 12:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214190803.GQ32477@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_115925_364395_6D66DDD1 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: mhocko@suse.com, kernel-hardening@lists.openwall.com,
 catalin.marinas@arm.com, will.deacon@arm.com, dave.hansen@intel.com,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, x86@kernel.org, jmorris@namei.org, hch@lst.de,
 kanth.ghatraju@oracle.com, jsteckli@amazon.de, labbott@redhat.com,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, Marco Benatto <marco.antonio.780@gmail.com>,
 linux-mm@kvack.org, juergh@gmail.com, andrew.cooper3@citrix.com,
 linux-kernel@vger.kernel.org, tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>,
 kirill.shutemov@linux.intel.com, keescook@google.com,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 12:08 PM, Peter Zijlstra wrote:
> On Thu, Feb 14, 2019 at 10:13:54AM -0700, Khalid Aziz wrote:
> 
>> Patch 11 ("xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION") cleans
>> all this up. If the original authors of these two patches, Juerg
>> Haefliger and Julian Stecklina, are ok with it, I would like to combine
>> the two patches in one.
> 
> Don't preserve broken patches because of different authorship or
> whatever.
> 
> If you care you can say things like:
> 
>  Based-on-code-from:
>  Co-developed-by:
>  Originally-from:
> 
> or whatever other things there are. But individual patches should be
> correct and complete.
> 

That sounds reasonable. I will merge these two patches in the next version.

Thanks,
Khalid


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
