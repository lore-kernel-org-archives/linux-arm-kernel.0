Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:35:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BFD20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O2BBp+Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VDkHJ9pNkTswHjJq8UXPEHVsdxr5vtC0nPBkeWWmN3M=; b=O2BBp+YqPXnIhD
	bwfBnazWffAAgb+e70M+BK4qZOyMBy2izNa8D6yt7APYXhT9nSYKLhoJGh8oxaaaiAiZqFkK+YZC9
	RxhazRg6Do9/djtLbgXMfgsw71ZcmjZZmofIBR4sJpaXGxLHcxL1iF1K36Rgk7SXbiNAJBUTSC7DY
	ITS46cQD3ULu6eek20+NU72g8/NmYKn4j+lydE+bAz5cKKhuM3DQ7wyqBV4H4Nbeavq0pCPd9D+tR
	c6w95bnjE3mvxB+tGDV/dBD231Y2KPDcEUHMDrq25EzxO1AhZMsITL8ynXbCVJU5APL0xVhukb0Gs
	t+fIDNCpaROpNeYioUqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYt39-0006NR-72; Mon, 17 Dec 2018 13:35:11 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYt36-00056U-9y
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:35:09 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 0AEAE68DD3; Mon, 17 Dec 2018 14:34:52 +0100 (CET)
Date: Mon, 17 Dec 2018 14:34:52 +0100
From: Torsten Duwe <duwe@lst.de>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181217133450.GB5774@lst.de>
References: <20181130162015.83FE767357@newverein.lst.de>
 <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de>
 <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
 <20181215134144.6b0cc45b@blackhole.lan>
 <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_053508_497620_68181ED7 
X-CRM114-Status: UNSURE (   7.64  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, julien.thierry@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, takahiro.akashi@linaro.org,
 mingo@redhat.com, jpoimboe@redhat.com, live-patching@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 09:52:04AM +0530, Amit Daniel Kachhap wrote:
> There is no error message or crash but no useful output like below,
> 
> /sys/kernel/tracing # echo wake_up_process > set_graph_function
> /sys/kernel/tracing # echo function_graph > current_tracer
> /sys/kernel/tracing # cat trace
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |

Confirmed. The graph tracer self-test passes, but when used, there is no
output.

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
