Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16521B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RTFKwAsO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owg2EAXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16521B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQ6AiAgWQPJ2CyExYPiUqMz/UVRcDkicQr5EgV6mzKk=; b=RTFKwAsOYFflu2
	HzkZnXI0I3KwCM2zrIE0N2TQ+DYfLgWtmgnX5mvrxwHKpKZf/WJUPDxypOFuCkq6EKwVkhYkuteot
	zOj5zdX/uKWrukFw0DaWKihGB9nIFb9X+6BxVKsXPCgB+TKf/dm0McmyeAHi1EJqkLGjbiDutv+Wx
	Km6VzZ3D/r5RsWyPp2/csxAC+rJ8Gv/xJ4yS4nrCqTAb29y+wz/c8xd4YV1dJ4bxg09EfqOFiEGgZ
	g6IGpd05Kcb3cVOmbhOjNpz/rsg8vycUz8a4RUGv98DUh9yNZRQZd9Tr9TFsTVmwDMwr57z5effgb
	BjMh62ZpjzqHAYNEXgVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guN97-0001bm-0i; Thu, 14 Feb 2019 19:58:09 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guN93-0001bT-NS
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:58:07 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EJsITk073232;
 Thu, 14 Feb 2019 19:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BdK7IaSpJfGdyre7bODL0VtCcEpshJ2Y4O0xLokGeZA=;
 b=owg2EAXP1djY4nOw3m8VNIzE98O8OriShbmSSMKZ1A19elg+OjugPa4ORsAae1iR/QG+
 Oo6TItCage0cFqLHvah7MyhhQEJRLw3heZpg0f9FxV8KjBacCmhDbU4A0xmkJ4AE0tW7
 7J9JF0zShtWDBE+r9ZN2h7CQ6evngnuEYCI2DcA3CDxWWAikNj2v6M/+F1z0RzJ8PftT
 w/OicGnyFF60fSAZPPiq1gNdWsq+Jc80DNuUYrKuzTkrqjKuKEtmKgryWLQec1RjtvWO
 whVfMYxFhwr12ksKkKKbj0LUcJjPeYPtDBVapSvKu0btUzQCxs69XCHlEjHQ3KEkgP2z tg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2qhreea5de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:57:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJvZQN015680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 19:57:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJvXGY021984;
 Thu, 14 Feb 2019 19:57:33 GMT
Received: from [192.168.1.16] (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Feb 2019 19:57:33 +0000
Subject: Re: [RFC PATCH v8 13/14] xpfo, mm: Defer TLB flushes for non-current
 CPUs (x86 only)
To: Dave Hansen <dave.hansen@intel.com>, juergh@gmail.com, tycho@tycho.ws,
 jsteckli@amazon.de, ak@linux.intel.com, torvalds@linux-foundation.org,
 liran.alon@oracle.com, keescook@google.com, akpm@linux-foundation.org,
 mhocko@suse.com, catalin.marinas@arm.com, will.deacon@arm.com,
 jmorris@namei.org, konrad.wilk@oracle.com
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <98134cb73e911b2f0b59ffb76243a7777963d218.1550088114.git.khalid.aziz@oracle.com>
 <a6510fa8-e96d-677b-78df-da9a19c4089b@intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <95fb62d4-1dbc-e420-74c1-ff929c5552e1@oracle.com>
Date: Thu, 14 Feb 2019 12:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a6510fa8-e96d-677b-78df-da9a19c4089b@intel.com>
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
X-CRM114-CacheID: sfid-20190214_115805_809742_11468E2C 
X-CRM114-Status: GOOD (  24.04  )
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
Cc: kernel-hardening@lists.openwall.com, peterz@infradead.org,
 linux-mm@kvack.org, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, x86@kernel.org,
 hch@lst.de, kanth.ghatraju@oracle.com, labbott@redhat.com,
 pradeep.vincent@oracle.com, jcm@redhat.com, luto@kernel.org,
 tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, dwmw@amazon.co.uk, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 10:42 AM, Dave Hansen wrote:
>>  #endif
>> +
>> +	/* If there is a pending TLB flush for this CPU due to XPFO
>> +	 * flush, do it now.
>> +	 */
> 
> Don't forget CodingStyle in all this, please.

Of course. I will fix that.

> 
>> +	if (cpumask_test_and_clear_cpu(cpu, &pending_xpfo_flush)) {
>> +		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
>> +		__flush_tlb_all();
>> +	}
> 
> This seems to exist in parallel with all of the cpu_tlbstate
> infrastructure.  Shouldn't it go in there?

That sounds like a good idea. On the other hand, pending flush needs to
be kept track of entirely within arch/x86/mm/tlb.c and using a local
variable with scope limited to just that file feels like a lighter
weight implementation. I could go either way.

> 
> Also, if we're doing full flushes like this, it seems a bit wasteful to
> then go and do later things like invalidate_user_asid() when we *know*
> that the asid would have been flushed by this operation.  I'm pretty
> sure this isn't the only __flush_tlb_all() callsite that does this, so
> it's not really criticism of this patch specifically.  It's more of a
> structural issue.
> 
> 

That is a good point. It is not just wasteful, it is bound to have
performance impact even if slight.

>> +void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>> +{
> 
> This is a bit lightly commented.  Please give this some good
> descriptions about the logic behind the implementation and the tradeoffs
> that are in play.
> 
> This is doing a local flush, but deferring the flushes on all other
> processors, right?  Can you explain the logic behind that in a comment
> here, please?  This also has to be called with preemption disabled, right?
> 
>> +	struct cpumask tmp_mask;
>> +
>> +	/* Balance as user space task's flush, a bit conservative */
>> +	if (end == TLB_FLUSH_ALL ||
>> +	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
>> +		do_flush_tlb_all(NULL);
>> +	} else {
>> +		struct flush_tlb_info info;
>> +
>> +		info.start = start;
>> +		info.end = end;
>> +		do_kernel_range_flush(&info);
>> +	}
>> +	cpumask_setall(&tmp_mask);
>> +	cpumask_clear_cpu(smp_processor_id(), &tmp_mask);
>> +	cpumask_or(&pending_xpfo_flush, &pending_xpfo_flush, &tmp_mask);
>> +}
> 
> Fun.  cpumask_setall() is non-atomic while cpumask_clear_cpu() and
> cpumask_or() *are* atomic.  The cpumask_clear_cpu() is operating on
> thread-local storage and doesn't need to be atomic.  Please make it
> __cpumask_clear_cpu().
> 

I will fix that. Thanks!

--
Khalid


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
