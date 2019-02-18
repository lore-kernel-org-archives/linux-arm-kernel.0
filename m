Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D6A217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uhSshVAY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="juWoYrLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D6A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KB/Su/NN9hwQ2P/3l7tU3x1mQ3N70MFS18bs8n9dhnU=; b=uhSshVAYdmtDui
	jl7iXaMlFv4gB3Qd1zCZh5JHIf3+dM14/BIXkXJFDsd4QrEF5rvgJeawox/3OJbgWeLElrx9YXS64
	HbWKaMsHi9oepzUDJCx+lGkWOP3W3yniDs7o+SBTO64j+wIJC/k23N5cEMG7ZJkqnfQ2SUVYtDwxc
	k2Z59AeG2F3s9P/7ExMdGxsCFzgddNHAOvNd5UB459ECG59KBUIllyEnkA7MAZbRBcYfL4erVkD0B
	Mm+9Oo6p/eAowy5rYn62tSaM1If4c70abfsqf3z5rq+LXU1YKs1HYn+KomAXsTl8kAdCXCWF9KDhk
	D81JXAFh4yWtyMb/bbUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjQ1-0002GF-NE; Mon, 18 Feb 2019 13:57:13 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjPw-0002Ej-NP
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:57:11 +0000
Received: by mail-it1-x141.google.com with SMTP id l15so28316230iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 05:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gf3o/I+S+xJQcN0X0LGq2ttIKjg9CziePIgUCCjzxhM=;
 b=juWoYrLkoK/Mb9y/KNrujPyKbST1L8/urFVTxjjWmaY2YbOCbzBJSMU0L71OZqOarG
 O9PMHVc4s/h7BwyRljUWzlWqBqY4nUS5Owgxc9vaqurQ63YBOn7/GgqFtExobvZebXsK
 6uI+Lt1n77+UmZKWdyLWqPTHLrTnsA5DKkGunTLUuTS66t8w5IjIfNnOMrlIce1tvx2G
 YKsI9lIdDCQ4as6NhPrYdoBdA1+K8EsYLw0YFohQjAeqwcC3cl4yYMk7zXtTz60suOhg
 GWbUbWX2uM89+xIMpoBkBPzb1Xa8Du1Pu+JUa1WKqxSEHE8GIMWOmYGU+gWC0vYNUDI6
 ULBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gf3o/I+S+xJQcN0X0LGq2ttIKjg9CziePIgUCCjzxhM=;
 b=PQ/o2jI4vW0jZdn59lFtSOgrADxL8CBkx2m49yBRHv+y3KsRQLg2nYcmiluNlvSEC0
 /IE+9NKs+VTfYJVObv3yjf59bWAyit7LQGlP0+ZMtVn9s+b/y9D3jmhq1aJ8nfJn+db7
 NJY40gTzL3NHq6ICBnY40j1MQO940XuMpyJLlsEbudOoPAdE/0SJViJi0NEG3MowFJLD
 oiFcCfvX4gpItGvjie6+Fz6fXVA9zd30ooIUut5/no1jDB4k8t01uLhgoPUL3haneCsI
 dzqsculd7/+TrCPsG9TwGhKid2iIGg9dghcaktn51uJ6llBaLodAUFnWRytc3FuI2wJJ
 SSww==
X-Gm-Message-State: AHQUAuaOJGp8XdjdvwJLiV/wSom4yfej9V5/USryVJw173dV4AbcVkT3
 aw3ua+RRI2thjFVhmW50BCuK72QqeG5TDhid3PL8wg==
X-Google-Smtp-Source: AHgI3Ia1Q9On+Gpycn/gcZBY079e/dDDeKyJhlr1h2nvQhRqA+hWg1jLy6jUxHRKW6X9Uy3STzw5+vqEKPdBzPrJVmc=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr13474614ior.11.1550498220361; 
 Mon, 18 Feb 2019 05:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
 <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
 <ec947849-5743-d48b-e2fc-acb90bbe6559@lca.pw>
In-Reply-To: <ec947849-5743-d48b-e2fc-acb90bbe6559@lca.pw>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 18 Feb 2019 14:56:47 +0100
Message-ID: <CACT4Y+a=d3G06tjLU0qEz8RWthFybeiJZ_sAAt2ybi+-JEDPZw@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_055708_796170_15DC8843 
X-CRM114-Status: GOOD (  18.31  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 2:27 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> On 2/17/19 2:30 AM, Dmitry Vyukov wrote:
> > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> >> because there is a burst of too much pointer access, and then KASAN will
> >> dereference each byte of the shadow address for the tag checking which
> >> will kill all the CPUs.
> >
> > Hi Qian,
> >
> > Could you please elaborate what exactly happens and who/why kills
> > CPUs? Number of memory accesses should not make any difference.
> > With hardware support (MTE) it won't be possible to disable
> > instrumentation (loads and stores check tags themselves), so it would
> > be useful to keep track of exact reasons we disable instrumentation to
> > know how to deal with them with hardware support.
> > It would be useful to keep this info in the comment in the Makefile.
>
> It turns out sometimes it will trigger a hardware error.

Please add this to the comment that there is that error, reason is
unknown, happens from time to time.
"Too much pointer access" is confusing and does not seem to be the
root cause (there are lots of source files that cause lots of pointer
accesses).


> # echo function > /sys/kernel/debug/tracing/current_trace
>
> RAS CONTROLLER: Fatal unrecoverable error detected
>
>         *** NBU BAR Error ***
>
>
>   MPIDR= 0x81000000
>   CTX_X0= ffff10001032eb9c
>   CTX_X1= ffff100010205f08
>   CTX_X2= 0
>   CTX_X3= ffff100010205efc
>   CTX_X4= 8
>   CTX_X5= 40
>   CTX_X6= 3f
>   CTX_X7= 0
>   CTX_X8= ff
>   CTX_X9= ffff0808ba65ab46
>   CTX_X10= ffff0808ba65ab45
>   CTX_X11= da
>   CTX_X12= 10071651
>   CTX_X13= fff60658
>   CTX_X14= ffff1000140d5000
>   CTX_X15= ffff100013855578
>   CTX_X16= 804b004a
>   CTX_X17= 1000100
>   CTX_X18= 0
>   CTX_X19= ffff100010205f08
>   CTX_X20= ffff100012531cd0
>   CTX_X21= ffff100010205f08
>   CTX_X22= ffff10001032eb9c
>   CTX_X23= 0
>   CTX_X24= ffff100012531cc0
>   CTX_X25= 12af
>   CTX_X26= fffdba05
>   CTX_X27= daff808ba65ab460
>   CTX_X28= ffff100012531cc0
>   CTX_X29= ffff808a2c617320
>   CTX_X30= ffff10001009b5a4
>   CTX_X31= ffff100012531cc0
>   CTX_SCR_EL3= 735
>   CTX_RUNTIME_SP= 6e545c0
>   CTX_SPSR_EL3= 604003c9
>   CTX_ELR_EL3= ffff100010205ecc
>  Node 0 NBU 0 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff00
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011ff00
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 1 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff40
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011ff40
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 2 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff80
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011ff80
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 3 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ffc0
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011ffc0
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 4 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe00
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fe00
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 5 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe40
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fe40
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 6 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe80
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fe80
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 7 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fee0
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fee0
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 8 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd30
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fd30
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 9 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd60
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fd60
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 10 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fda0
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fda0
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 11 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fdc0
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fdc0
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 12 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc00
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fc00
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 13 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc40
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fc40
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 14 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc80
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fc80
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>  Node 0 NBU 15 Error report :
>  NBU BAR Error
>       NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
>       NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fcc0
>       NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
>       Physical Address : 0x40011fcc0
>
> NBU BAR Error : Decoded info :
>         Agent info : CPU
>             Core ID : 21
>             Thread ID : 1
>         Requ: type : 4 : Write Back
>
> Current NBU DRAM BAR setting:
> Node0 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
> Node0 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
> Node0 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
> Node0 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
> Node0 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
> Node0 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
> Node0 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
> Node0 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node0 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
> Node1 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
> Node1 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
> Node1 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
> Node1 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
> Node1 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
> Node1 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
> Node1 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
> Node1 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
>
> 0.0.0:
>   00: AF00177D
>   04: 00100006
>   08: 06000000
>   0C: 00000010
>   10: 00000000
>   14: 00000000
>   18: 00000000
>   1C: 00000000
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 0000177D
>   30: 00000000
>   34: 00000090
>   38: 00000000
>   3C: 00000000
>
> 0.1.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00010100
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.2.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00020200
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.3.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00030300
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.4.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00040400
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.5.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00050500
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.6.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00060600
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.7.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00070700
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.8.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00080800
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.9.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00090900
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.a.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 000A0A00
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.b.0:
>   00: AF84177D
>   04: 00100106
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 000C0B00
>   1C: 20000000
>   20: 43104300
>   24: 03F10001
>   28: 00000100
>   2C: 00000100
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 000201FF
>
> 0.c.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 000D0D00
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.d.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 000E0E00
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 0.e.0:
>   00: AF84177D
>   04: 00100106
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00100F00
>   1C: 20000000
>   20: 42F04000
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 000201FF
>
> 0.f.0:
>   00: 902614E4
>   04: 00100406
>   08: 0C033000
>   0C: 00800010
>   10: 0400000C
>   14: 00000100
>   18: 0401000C
>   1C: 00000100
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 00000000
>
> 0.f.1:
>   00: 902614E4
>   04: 00100406
>   08: 0C033000
>   0C: 00800010
>   10: 0402000C
>   14: 00000100
>   18: 0403000C
>   1C: 00000100
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 00000000
>
> 0.10.0:
>   00: 902714E4
>   04: 00100406
>   08: 01060100
>   0C: 00800010
>   10: 00000000
>   14: 00000000
>   18: 0404000C
>   1C: 00000100
>   20: 00000000
>   24: 43200000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 000000FF
>
> 0.10.1:
>   00: 902714E4
>   04: 00100406
>   08: 01060100
>   0C: 00800010
>   10: 00000000
>   14: 00000000
>   18: 0405000C
>   1C: 00000100
>   20: 00000000
>   24: 43210000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 000000FF
>
> b.0.0:
>   00: 101515B3
>   04: 00100506
>   08: 02000000
>   0C: 00800000
>   10: 0000000C
>   14: 00000100
>   18: 00000000
>   1C: 00000000
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 028A1590
>   30: FFF00000
>   34: 00000060
>   38: 00000000
>   3C: 000001FF
>
> b.0.1:
>   00: 101515B3
>   04: 00100506
>   08: 02000000
>   0C: 00800000
>   10: 0200000C
>   14: 00000100
>   18: 00000000
>   1C: 00000000
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 028A1590
>   30: FFF00000
>   34: 00000060
>   38: 00000000
>   3C: 000002FF
>
> f.0.0:
>   00: 11501A03
>   04: 00100107
>   08: 06040004
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 0010100F
>   1C: 022001F1
>   20: 42F04000
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000050
>   38: 00000000
>   3C: 000201FF
>
> 10.0.0:
>   00: 20001A03
>   04: 02100102
>   08: 03000041
>   0C: 00000000
>   10: 40000000
>   14: 42000000
>   18: 00000001
>   1C: 00000000
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 20001A03
>   30: 00000000
>   34: 00000040
>   38: 00000000
>   3C: 000001FF
>
> 80.0.0:
>   00: AF00177D
>   04: 00100002
>   08: 06000000
>   0C: 00000010
>   10: 00000000
>   14: 00000000
>   18: 00000000
>   1C: 00000000
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 0000177D
>   30: 00000000
>   34: 00000090
>   38: 00000000
>   3C: 00000000
>
> 80.1.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00818180
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 80.9.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00828280
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 80.b.0:
>   00: AF84177D
>   04: 00100000
>   08: 06040000
>   0C: 00010000
>   10: 00000000
>   14: 00000000
>   18: 00838380
>   1C: 00000000
>   20: 0000FFF0
>   24: 0001FFF1
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000048
>   38: 00000000
>   3C: 00000100
>
> 80.f.0:
>   00: 902614E4
>   04: 00100406
>   08: 0C033000
>   0C: 00800010
>   10: 0000000C
>   14: 00000140
>   18: 0001000C
>   1C: 00000140
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 00000000
>
> 80.f.1:
>   00: 902614E4
>   04: 00100406
>   08: 0C033000
>   0C: 00800010
>   10: 0002000C
>   14: 00000140
>   18: 0003000C
>   1C: 00000140
>   20: 00000000
>   24: 00000000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 00000000
>
> 80.10.0:
>   00: 902714E4
>   04: 00100406
>   08: 01060100
>   0C: 00800010
>   10: 00000000
>   14: 00000000
>   18: 0004000C
>   1C: 00000140
>   20: 00000000
>   24: 60000000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 000000FF
>
> 80.10.1:
>   00: 902714E4
>   04: 00100406
>   08: 01060100
>   0C: 00800010
>   10: 00000000
>   14: 00000000
>   18: 0005000C
>   1C: 00000140
>   20: 00000000
>   24: 60010000
>   28: 00000000
>   2C: 00000000
>   30: 00000000
>   34: 00000080
>   38: 00000000
>   3C: 000000FF
> RAS CONTROLLER: SYSTEM HALTED...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
