Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40244C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E0120645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WfFaDlqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E0120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gRyqcW09OhO7+mgcktbVw84O/GO1Bn9k+SA4qt4EdpI=; b=WfFaDlqbgmyt+e
	ukL3Nz0adA58A46WwGP60KNshu1HmAJQDFU4ETnxfZlfKIX7cDgl8j0pk0aniRiPfPDjbQT2XsZAM
	x8clrMRteW/Jrpi5Pd7ZyvwhUnww2TevCG+fx6wkPXnxWtfwbI/ByG6Xbq88oQqcbqJ3gj21wLXP9
	g/WqfGKEtwwLNYclPBnqzV/Ys8GgXytxTusR1yVloglJFQGv9qkXgsyG5khLCHpNIPgPvi+KUBmXH
	N437Zp9H7vPfUG2KYXd11jBY7t2APMMV29hSfoLlhkNlBUvAN62+W02H54obuvMFYONga8A2phbMZ
	KM+I4eWry2OONlHXuwXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkQJ-0000Se-Tf; Mon, 17 Dec 2018 04:22:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYkQH-0000Rg-5b
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:22:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D6015BE
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 20:22:16 -0800 (PST)
Received: from mail-it1-f170.google.com (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79AC43F93D
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 20:22:16 -0800 (PST)
Received: by mail-it1-f170.google.com with SMTP id o19so16968930itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 20:22:16 -0800 (PST)
X-Gm-Message-State: AA+aEWZgbPMUgv6OlO532l9uMN5VLYt85mR9Igg+DImbXHl8eMtjUB04
 pE3QhS2i4AfGmXafsQv/62XiyuQHUFNK8C+E8zM=
X-Google-Smtp-Source: AFSGD/XKg5uBlKIWqj15XjELxxRPwvqmd+Z296ddkHjfPgdc4KEAicMP6QRESc0rMLwJXayFn+wvVdvzqUw249dV4fM=
X-Received: by 2002:a02:4c55:: with SMTP id a82mr10896248jab.29.1545020535693; 
 Sun, 16 Dec 2018 20:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20181130162015.83FE767357@newverein.lst.de>
 <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de>
 <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
 <20181215134144.6b0cc45b@blackhole.lan>
In-Reply-To: <20181215134144.6b0cc45b@blackhole.lan>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Mon, 17 Dec 2018 09:52:04 +0530
X-Gmail-Original-Message-ID: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
Message-ID: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
To: duwe@lst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_202229_216805_1C22EDE4 
X-CRM114-Status: GOOD (  14.88  )
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

Hi,
On Sat, Dec 15, 2018 at 6:14 PM Torsten Duwe <duwe@lst.de> wrote:
>
> On Fri, 14 Dec 2018 21:45:03 +0530
> Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:
>
> > Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
> > all the above 8 extra patches
> > mentioned by you.
>
> So that should be fine.
ok thanks.
>
> > I read your change description in v3 patchset. You had mentioned there
> > that graph caller
> > is broken.
>
> No, actually I thought I had fixed that for v4. Would you care to show
> us an actual error message or some symptom?
There is no error message or crash but no useful output like below,

/sys/kernel/tracing # echo wake_up_process > set_graph_function
/sys/kernel/tracing # echo function_graph > current_tracer
/sys/kernel/tracing # cat trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |

//Amit
>
>         Torsten

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
