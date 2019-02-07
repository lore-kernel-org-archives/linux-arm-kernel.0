Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07408C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD8C21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uo1lsYjj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="U7zyFCgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD8C21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fk1ymJqjlVEtklkN9g4WfW193b4mROA68LxpG29ibdY=; b=Uo1lsYjjvdbRCL
	5EuEj5OSrbGwG/EBBCYGefGn6m2pP3Dy7xm8+mCSGRKfptzP64aRtuoyqgbX1oeuGwR98cjA3cRmX
	0VVwZ3lEb424ZkkgUoSQVsTRO8SkJM4+ztVSFbk8gC85luPe6KDaq1u1q7NVj8yDvnkBWoCjrWxWV
	jsCws1QPcCQuk2XmZmV2shEdjDgBmCsv+KR0jmLg1awEY9OHNLqBJW8iYTH+mVi0hAcSW9b3Hnt7q
	rP4Rnp3LoplfQ2UJ4nyVXcnBsAoCz4K7Q+cRVTBfgoMIFWVCpT4CySdlr0dT6lO6c5qEnNxty/eru
	D1HLHkE17l/lrmrxP8QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjib-0000y9-Vc; Thu, 07 Feb 2019 13:27:53 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjiY-0000xk-D5
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:27:51 +0000
Received: by mail-qt1-x842.google.com with SMTP id n32so11810929qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gVGRQAP8fycR5glSl7rC3QviX2H8rDZ6sJcRguQ7SeA=;
 b=U7zyFCgl8UsthAyJ6GJETaK6VjYO9R6hnAUbwum19EDn+UZ6JBvdfgXFYEo39DSMMt
 OCWrfeJgTO1AtlMsrjMplzGLIycHt/f9PV12yfmSy7kbh/IIpis694rqvKerN4Hc6BBb
 Ffb7P6FqZL+Ycy3JOclu/bQ6UT8dxNqnzynsNXZap9tJjZ+TXChEHDbYSjYQ3f+Y3sZ3
 J32i3W7pJedqxpJ/l2xGER3sO8xqAbdEoA9wOubbD/kJMsl98xHlip3vaYQbPztt90DS
 t71nhmXcqJViXU6tlKBzZbCZZQUqFSykuuuPATpq7SnH1zHPrhTE5YlzZKBo59p+wz36
 2ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gVGRQAP8fycR5glSl7rC3QviX2H8rDZ6sJcRguQ7SeA=;
 b=HK+X09rpCLFbfW2cbl9Ey+NI+bixlLFzZGyBXOtvMmyr0s4poKikcCw68DQI7z7p1+
 oHtsxz3sECdpzUC0ePeqi01CdG1zVK/95NXBd+3nhiFUQtQxQJB/hOTmy8O5h5lCbuWy
 02isQXGwRjDlhkjQQOJfL9hVzMw5xnhSgNTmekEsGYh0aEjeUdqkRBNuI7cogZJIcB8Q
 WWxYa3Xg39M1IsXC6ncwsFACacVH5uFO+fvCcZd8VfYd1Vt7To94s+pLNFiEqDNHyNX+
 2Tk9I2+Tba59TAg3g4deV6ahMkDix4PFivWDD4pjJ52+PblK2QGB+dAOKZUejXS7RAh5
 pjxg==
X-Gm-Message-State: AHQUAubxDIng9n/565JSkT8EvPoFCgNX1txm49/Zk2ejFe3tXO0Xf5Rb
 Cw1vWeQuiAj86CjDUHlhK0lHYQ==
X-Google-Smtp-Source: AHgI3IZR2HVv+LZzBwlj0ZZiVIyTcwCHtDmzwE7pmqMazDqxl7fzx8CrNp0p9bykmTGq3BJqrR0cxg==
X-Received: by 2002:a0c:eaca:: with SMTP id y10mr11754387qvp.176.1549546069278; 
 Thu, 07 Feb 2019 05:27:49 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id d67sm8223865qkf.76.2019.02.07.05.27.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 05:27:48 -0800 (PST)
Subject: Re: CONFIG_KASAN_SW_TAGS=y NULL pointer dereference at
 freelist_dereference()
To: Andrey Konovalov <andreyknvl@google.com>
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
Date: Thu, 7 Feb 2019 08:27:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_052750_483884_A5A9ACC5 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/7/19 7:58 AM, Andrey Konovalov wrote:
> On Thu, Feb 7, 2019 at 5:04 AM Qian Cai <cai@lca.pw> wrote:
>>
>> The kernel was compiled by clang-7.0.1 on a ThunderX2 server, and it fails to
>> boot. CONFIG_KASAN_GENERIC=y works fine.
> 
> Hi Qian,
> 
> Could you share the kernel commit id and .config that you use?

v5.0-rc5

https://git.sr.ht/~cai/linux-debug/tree/master/config

# cat /proc/cmdline
page_poison=on crashkernel=768M earlycon page_owner=on numa_balancing=enable
slub_debug=-

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
