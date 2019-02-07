Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA11C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:05:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1097E2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F0SLW5TA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nK9wO4n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1097E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EekoUelVJZDc7uE/dejPEhnejTIDQXUofzWHoKiqpus=; b=F0SLW5TAz56a+k
	RHeUZ3LsunqpIm+UBlytW8SSBwWaB/BodysdbsfslpicKKUQDKgISLitA01PSjy5+/eWy/aNsAcnm
	z4LGchrziqDEsuGlwPoMImYLRv6DkdS0JkuwXvIlsG0HWjkOMEITdl7fmrMUtaHBSHD9Pepxdfp9q
	EExjsejqQhBFOAC9UQdBgK+BYvvfBu7tRWfHbn2nSIN63ilpmIbnUQ6ToDMbMvYUNp5QVf0jAOmlt
	km9SKnXmTpVKPVj1w3csWQhQgzgyV4Wp+GyEGn71YHmkTIg03ySj5SqbFuKSP7XaiIBDeFcOagJGb
	9wU7JJpfdezPBfGWjAXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gravq-0006tm-Kd; Thu, 07 Feb 2019 04:04:58 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gravm-0006tL-JW
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 04:04:56 +0000
Received: by mail-qk1-x743.google.com with SMTP id m17so5721866qki.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 20:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=uqDFmLu9eRIl2FkZ8iL2rbGAF9xtpoxPtooDYLXchCs=;
 b=nK9wO4n9hul5JU8GgFYVhCNibSqu8CPms8VeFjFWNeQqvNTmfXf9JESFrxG59YupEe
 K0l2jH2cTExPDh0+4gWTP4L9ZJqpzeKA06RLmYDiRvkzM0/Hd3KP7yRyIlnjWNEUdEse
 OY55oZgBQFn0if+EfbRQ0p8GVLZgGgN2TBsHGdwexzvxz+vIjXgxP0lYdb4bBeCKUwKS
 oDtnCNWlHM1S+M+KAsYzoiVlbVPa8i4DV6zkrlv2RsnCeQE/58LpyOvgh4cnst6jgNA9
 UdQ8iljhl8Rs30CbX3TseIxW7A3782V/YrLusStdCKXKNtER4ao0fyFq767lpmG5wVcg
 NmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=uqDFmLu9eRIl2FkZ8iL2rbGAF9xtpoxPtooDYLXchCs=;
 b=YDDsaigRij0xi0CSFlEa/Dg4A7IIQ1bTiG70y55GCB7letOi9AAtXrvw88VgMVhCSf
 V3vaJrK3jGLH96KGx4+ui49dnrwEH2tGI794i1pn+aRhomo6YXXKdorclD2uNmwknweo
 7sAF41mzdQFtsi/UVvZOZSPc7zqaY3zZOdOUqepdwdCkp4eHGHJ+bl+gi3g2+Py0W/fY
 baF5t8IlA5/q1MVq44NG/OA570GM8JacPDPFwckOrR964Ojr/hNW3whK1fhlhiCQI/3o
 QO74uAnFlmQWimQFlPK80s4NWW9ko0PuvqaQoHLseiNrMShom43I1/3396AdCRNn9YII
 fbkw==
X-Gm-Message-State: AHQUAuZkSISElzfSEpWA2NlA+c3y+qp7BWR+l2bW7SZBl+MiHsHUEnjn
 W+kzqFFGQCE8eyXkIzRlTErRsw==
X-Google-Smtp-Source: AHgI3IaCyqeuRDN8q9M2toLl+/2h6YXJ0F4f/uX5cv8rQLS/UtG939rlqX0VEtLEXDfeNC0vYo4x1Q==
X-Received: by 2002:a37:498a:: with SMTP id w132mr10349837qka.92.1549512290900; 
 Wed, 06 Feb 2019 20:04:50 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b6sm14515948qtq.29.2019.02.06.20.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 20:04:50 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Subject: CONFIG_KASAN_SW_TAGS=y NULL pointer dereference at
 freelist_dereference()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
Date: Wed, 6 Feb 2019 23:04:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_200454_689308_E9C2F172 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Cc: Linux-MM <linux-mm@kvack.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The kernel was compiled by clang-7.0.1 on a ThunderX2 server, and it fails to
boot. CONFIG_KASAN_GENERIC=y works fine.

deactivate_slab+0x84/0x6ac:
freelist_dereference at mm/slub.c:262
(inlined by) get_freepointer at mm/slub.c:268
(inlined by) deactivate_slab at mm/slub.c:2056

/* Returns the freelist pointer recorded at location ptr_addr. */
static inline void *freelist_dereference(const struct kmem_cache *s,
                                         void *ptr_addr)
{
        return freelist_ptr(s, (void *)*(unsigned long *)(ptr_addr),
                            (unsigned long)ptr_addr);
}

[    0.000000] Memory: 3259968K/100594752K available (15548K kernel code, 12360K
rwdata, 4096K rodata, 25536K init, 27244K bss, 7444672K reserved, 0K cma-reserved)
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000078
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000005
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000005
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000078] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000005 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc5+ #6
[    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
[    0.000000] pc : deactivate_slab+0x84/0x6ac
[    0.000000] lr : deactivate_slab+0x1cc/0x6ac
[    0.000000] sp : ffff100012cf7be0
[    0.000000] x29: ffff100012cf7cc0 x28: ffff1000114e4f00
[    0.000000] x27: ffff1000114e4f20 x26: ffff1000114e4f08
[    0.000000] x25: ffff1000114e5078 x24: fb00000000000000
[    0.000000] x23: ffff7fe002080008 x22: ffff808abb5b72d0
[    0.000000] x21: ffff7fe002080020 x20: ffff7fe002080028
[    0.000000] x19: ffff7fe002080000 x18: ffff1000148a5538
[    0.000000] x17: 000000000000001b x16: 0000000000000000
[    0.000000] x15: 007ffffffc000201 x14: 04ff80082000fa80
[    0.000000] x13: 0000000080660002 x12: 0000000080660003
[    0.000000] x11: 4582a03bdc147ab9 x10: ffff100012d31c90
[    0.000000] x9 : fb00000000000078 x8 : ffff100012d31c80
[    0.000000] x7 : cccccccccccccccc x6 : ffff1000105d8db8
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : ffff808abb5b72d0 x2 : 04ff800820000580
[    0.000000] x1 : ffff7fe002080000 x0 : ffff1000114e4f00
[    0.000000] Process swapper (pid: 0, stack limit = 0x(____ptrval____))
[    0.000000] Call trace:
[    0.000000]  deactivate_slab+0x84/0x6ac
[    0.000000]  ___slab_alloc+0x648/0x6fc
[    0.000000]  kmem_cache_alloc_node+0x408/0x538
[    0.000000]  __kmem_cache_create+0x20c/0x6a8
[    0.000000]  create_boot_cache+0x68/0xac
[    0.000000]  kmem_cache_init+0xb0/0x19c
[    0.000000]  start_kernel+0x4b4/0xac4
[    0.000000] Code: 14000057 b9400369 f940032b 8b090309 (f940012a)
[    0.000000] ---[ end trace 54ad7e55e4749a96 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception
[    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
