Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D251C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03A520866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q0IBa5n9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="doFVyhOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03A520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Jo/gnbteSKuBozZeDWuOFk+/3j6dae+jhjLqSzXi+KY=; b=Q0IBa5n9cOFdHD91nuWQDXymKz
	IzwFE4MC0mu/S/oR7pGx2ppJ77Z17Kg0zGsTIeCUKKbMZ0v3hVbvV/1BorhbSv+pXUdYHCMH6TpUx
	uLGmp7pH4OlS10QAyJNfkPyDHCPRCWrxyO/WGI8FbO9YaQP30YLQkx1OSHUTq6FJkLu8S0fJk2vSo
	FDKXqEIiIo8Xbyvi/fLtbClnYRrGMWf0bRtytqN1TmPrHGybjLd3Coc6bFctiNLr2w8JbZX3mxX2O
	a2DquBxAIpAf4ji7U+WFdRlAliIWOHjRpR3sa3hLkNVeku+dfwesevpZ4pD4c/5BSlO+q1FFqy+yy
	BJEjjxXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgxq-0003Tg-Ss; Wed, 16 Jan 2019 08:54:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgxn-0003TI-6d
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:54:20 +0000
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82C582086D
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547628858;
 bh=TT6Wuhial05lhUPWMlvLkr+62xVH1euGBPzYe+N3bCw=;
 h=References:In-Reply-To:From:Date:Subject:To:From;
 b=doFVyhOEIYZEq46cMmEGvlFX7ksGoATSrUWl7o3xjrod/OBM9zYPvfogFRRReFD/i
 DJUE6oHmdfSWOvU7CuoLCrMnc1l1ZJVp4oZ2vSM4z4+D02YeJXZHdW1yRYNNq4C8fn
 QyWqH17v9ZKLGNgLVX7X4/pIWMRb7mVHFeUjQPAs=
Received: by mail-lj1-f170.google.com with SMTP id c19-v6so4753843lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 00:54:18 -0800 (PST)
X-Gm-Message-State: AJcUukfQMQp0pW7U5I6P7WTl6lnzFtfJPy1Peqdf0OM5L2pAvoEy9J0S
 4/KWixSCZJQoX82M0vCaezc5g4FnV2bb3KBFBLM=
X-Google-Smtp-Source: ALg8bN6zt7MPM1kJlXsi0rKVmvQRDLc7sqq1DsTGTnHa2dDNph68BPtukDavCtbrn3c3H1RWRFi49lye8Yc9j/losLI=
X-Received: by 2002:a2e:9cd2:: with SMTP id
 g18-v6mr6016495ljj.161.1547628856679; 
 Wed, 16 Jan 2019 00:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
In-Reply-To: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Jan 2019 09:54:05 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
Message-ID: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
Subject: Re: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount disk
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>, 
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_005419_263785_7FDA6CD5 
X-CRM114-Status: GOOD (  11.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> On today's next-20190116 I see a bug during boot:
> [ 6.843308] kernel BUG at ../block/bio.c:1833!
> [ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> ...
> [ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
> [ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
>
> (not much in the calltrace)
> On all my boards. Also QEMU-arm fails.
>

I forgot the bisect commit:

258cfdfaf7bd729e759a0a91fd00ac9794796ad3 is the first bad commit
commit 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Jan 11 19:01:15 2019 +0800

    block: use bio_for_each_bvec() to compute multi-page bvec count

:040000 040000 d79b2e71d308650df4764ff644f29d3a24dbab96
0a5d624843b805ee0c9fd9a7e2d5163f5b15b167 M block

BR,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
