Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D227E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o0KPkPnA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EsAtrZ//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D227E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hznM1gz1cKJYWIlUspnfZR+VI62ohlr3OUaDn1lAz/c=; b=o0KPkPnANBINd2
	N0Bl9ytpN9X4QgfFIzmpqocsCl1xuilSO+42sCIuHKdBCXF3vxH+83M5A2rg6HJolOkS97J5aS+iU
	6YHeTYviSsB36YtmulIIszzrWNNXU58ReKUnDo8SnFM6t110iuOR6hNZGnFytc1TxcfmvOrERtDyQ
	IgB59vdf/8iJ/t39l6a31FaDypQqPMyjuHPknBWqXrv4OWRnQfOrVnTNQxI7JmbncdD9CndKVH+0A
	QzSKmC+VE3XtAcJkfIiUlGvSi7KkxDEKHHQDnZR3szzwyHClRBrJdhKywX5O5GU4Y8oE2ybpLM5FG
	RT7Hm8j8YArBKz/sxRDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvv14-0003Hb-9R; Tue, 19 Feb 2019 02:20:14 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvv10-0003HE-Pd
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 02:20:12 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so9324228pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9dEGfOdaZR9UmprPukicFRnBioLR7q9r/00bep9K4pw=;
 b=EsAtrZ//e/1T7N4Bghm7Uoy58cCNQKqgsTCgI+fuvA7ypKSXAYBPbMzqOwxjmEy588
 cyt9/BeL2f6s69J11qZt0bLU4qvlryNr8phBSpmsBl3PQ9fhMnk5S9femWlqb942IeqR
 KtluLfsQTYLwkyGQpZuf3HDdMETmQ1sHjtEDlIF9ZruD3bhe/XbBtGh4z801pPqpfYvL
 v807Sa/Ycj1rl/N9bqZ6znibwyBJ+D+FjdezmKXCxwFut1pHwZN15yUiAfDjZoxcAEd3
 Qno5sa1LJdVc6NtAXHEPsySHQA8qb1+HfrKXSUsd627+Zlc9IzKjG/sF7LUEKPovdvJB
 HOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9dEGfOdaZR9UmprPukicFRnBioLR7q9r/00bep9K4pw=;
 b=i3OyGE6XwQ74P0FeO+PvABEkrJGzTJnTHGjSewWvmTV19AGqllWWFrvMzY8AF7D24h
 fDTjihRHiV8FTg5jHdy4Axb5nr7DeBp6xUiKQb8G9AQkPnHwye53dS9CWASdC+3SIAxg
 jZirIq3/dO3KfuMmVTpeuQUr63+1MOrzqVv9gDCl+6ufsd3IFcumZJ/6TLoZ0I5mBbnq
 iguKRsc9LmfM/LUH4HHN+uxehXq1MBitMXtNZP8lb+6ArSfQHaSLkWFtjtLqXiGnpedj
 GY4rtsRHx9yFXWXljDxlQqXEqROeRgP8Bj/Z+4iUHz+4O2ilplcmVDpkJ+aaJiJdQjy3
 VkKw==
X-Gm-Message-State: AHQUAubsHPzZ3tfHG8k5LSJpTsAlC4N5e4o7Quk/FYZoarL8SJcRkIZH
 vdFQ1vAjVLYHPJw66637jlqpKw==
X-Google-Smtp-Source: AHgI3IZrR9G/yTFJgm9MA9PQNptFapkxMSRL3GofSv38CE9+MatSTVBTiHMPBQ8q98QIezLXHj3u8Q==
X-Received: by 2002:a65:500c:: with SMTP id f12mr21322119pgo.226.1550542809497; 
 Mon, 18 Feb 2019 18:20:09 -0800 (PST)
Received: from ?IPv6:2600:1010:b009:23ae:dc4e:d4db:1aa:7738?
 ([2600:1010:b009:23ae:dc4e:d4db:1aa:7738])
 by smtp.gmail.com with ESMTPSA id l12sm6222094pgn.83.2019.02.18.18.20.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 18:20:08 -0800 (PST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Date: Mon, 18 Feb 2019 18:20:07 -0800
Message-Id: <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_182010_896679_EEAC7ACB 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIEZlYiAxOCwgMjAxOSwgYXQgNDoyNCBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiAKPj4gT24gTW9uLCBGZWIgMTgsIDIwMTkg
YXQgMjozMSBQTSBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4gd3JvdGU6Cj4+IAo+PiBU
aGUgcXVlc3Rpb24gaXMgd2hhdCAiZml4IGl0IiBtZWFucy4gSSdtIHJlYWxseSBjb25jZXJuZWQg
YWJvdXQgQUMgZXNjYXBlcywKPj4gYW5kIGV2ZXJ5b25lIGVsc2Ugc2hvdWxkIGJlLCB0b28uCj4g
Cj4gSSBkbyB0aGluayB0aGF0IGl0IG1pZ2h0IGJlIHRoZSByaWdodCB0aGluZyB0byBkbyB0byBh
ZGQgc29tZSBraW5kIG9mCj4gV0FSTl9PTl9PTkNFKCkgZm9yIEFDIGJlaW5nIHNldCBpbiB2YXJp
b3VzIGNhbi1yZXNjaGVkdWxlIHNpdHVhdGlvbnMuCj4gCj4gV2UnZCBqdXN0IGhhdmUgdG8gYWJz
dHJhY3QgaXQgc2FuZWx5LiBJJ20gc3VyZSBhcm02NCBoYXMgdGhlIGV4YWN0Cj4gc2FtZSBpc3N1
ZSB3aXRoIFBBTiAtIG1heWJlIGl0IHNhdmVzIHByb3Blcmx5LCBidXQgdGhlIHNhbWUgIndlCj4g
d291bGRuJ3Qgd2FudCB0byBnbyB0aHJvdWdoIHRoZSBzY2hlZHVsZXIgd2l0aCBQQU4gY2xlYXIi
Lgo+IAo+IE9uIHg4Niwgd2UgbWlnaHQgYXMgd2VsbCBjaGVjayBERiBhdCB0aGUgc2FtZSB0aW1l
IGFzIEFDLgo+IAo+IAoKaHBhIGlzIHJpZ2h0LCB0aG91Z2gg4oCUIGNhbGxpbmcgaW50byB0cmFj
aW5nIGNvZGUgd2l0aCBBQyBzZXQgaXMgbm90IHJlYWxseSBzbyBnb29kLiAgQW5kIGNhbGxpbmcg
c2NoZWR1bGUoKSAodmlhIHByZWVtcHRfZW5hYmxlKCkgb3Igd2hhdGV2ZXIpIGlzIGFsc28gYmFk
IGJlY2F1c2UgaXQgcnVucyBhbGwgdGhlIHNjaGVkdWxlciBjb2RlIHdpdGggQUMgb24uICBBZG1p
dHRlZGx5LCB0aGUgc2NoZWR1bGVyIGlzIG5vdCAqdGhhdCogaW50ZXJlc3Rpbmcgb2YgYW4gYXR0
YWNrIHN1cmZhY2UuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
