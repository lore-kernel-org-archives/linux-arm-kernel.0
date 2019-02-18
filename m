Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:27:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0179C2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Edys8+th";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xcy8C994"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0179C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nu17Hlrr1nde+GLrw4biVeo7ohC9HlK6uyjqHeMo3Tg=; b=Edys8+thTkJ0ZR
	IvKi3Z+PnTAoi7iQU/5cj79MGv3sUnroMQ+no46HbndcjXrm04yns8ZG6S6E75yixDFvZ8O99Q0RY
	upNcdm56ttpKR+0ezdPTq4/mAG0GmWMufNTJKTDhfFivpLa8toQvYXLwA7Mkg2ARlX5NN6NC68d/b
	5PixLmNKhZ06hgsSX04ss9FHKW5eh0luzw79QmU/u+lDbJMRLe//sE3cwvwk+7YoAeRIQJHP04B7T
	KK4LMvG5qE+9KVKijooo26SkqvnZZC2L334eFz3PxQ/Mo8EKt0gQLq7plZecNhwb717hMMk4ep74b
	ef1QZjTBzILzCV9faScw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvix1-0006sw-BT; Mon, 18 Feb 2019 13:27:15 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviwx-0006rd-Ms
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:27:14 +0000
Received: by mail-qt1-x842.google.com with SMTP id a48so19110246qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9pqJkdvZ884+PQJwH2QlsUHZ3YncZio+fokGzIt8zu4=;
 b=Xcy8C9948pRZLUIdr3qBi7/deNoSADEi7pTnjEWKRURSkx/pUGuaejNDGeCov9V+o2
 eUvA4wxjrSWqDo3amy09bnBXIbm5qPhOSIhQ+5Omj352UIlJB6M1AdddUDQg/Hm5kH/p
 GMdMxT0otrlm/qQ549EoI6zJdYG4jVhjTJblJKpuyg6z3XcIaAi9rsbvYEl5w1ccDlKx
 fBYnQhcKKEGF3MIjt0HnARgXdMrrEkKCrfbRjK4GyC9xJyvwon3Xlf4ii4VsdQwmAs2/
 P02C+LGZKHeOoJfvR408SfBn8mxs/B/EShg+c7eWhsiApsFQ1eGKXf/BUoI05VQ01WSC
 MfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9pqJkdvZ884+PQJwH2QlsUHZ3YncZio+fokGzIt8zu4=;
 b=WEfomrlmtEXuGntaMBSM76XADQ9lxhyVq2IN+3XYoqheW5PMukX20kh0w84iZqL6mJ
 oHw2rcGBizyE5nJLM2N/zsQPumepVTocvZ9RZGoBGVmpy/6kEzJcDqP1+nA0vuFh48EF
 uLTM2cvSntg1wveCTfwgzqZX3Q08mbbxDK/8dDEW0qTIl2Tc602l3vlfP2EuDcdIOAnA
 doOH7NSZ7Vf0pQyQC/t6tyx5GXloRB8T3PDDuR+cSdRV6p17Rar6Gcifr44iN6gCulWf
 uev1t/zvzkB9BfGarZ1IQlqEMEP7ZcXeTe+tcsxFIG6DkPwAYrTXlJ0pqicgzq6t2W4C
 bCqg==
X-Gm-Message-State: AHQUAuauKgBRxH+r9tEZWIYF5W615h1kzgJX2bEVfaaxI6k2uA6+Xqgd
 8Hcz5ucdVyS/2kCGFiACYG5MAw==
X-Google-Smtp-Source: AHgI3IYEF4npncQM412GJlMOzNbxmB1j6UGZy/OgErQdagG3nSP9SHPVCnQ+6kDV6oqhR60eb91Jaw==
X-Received: by 2002:a0c:c906:: with SMTP id r6mr17300696qvj.121.1550496429728; 
 Mon, 18 Feb 2019 05:27:09 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id a185sm8021894qkb.1.2019.02.18.05.27.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 05:27:08 -0800 (PST)
Subject: Re: [PATCH] trace: skip hwasan
To: Dmitry Vyukov <dvyukov@google.com>
References: <20190217043434.46233-1-cai@lca.pw>
 <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <ec947849-5743-d48b-e2fc-acb90bbe6559@lca.pw>
Date: Mon, 18 Feb 2019 08:27:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_052711_807566_C12CABE2 
X-CRM114-Status: GOOD (  16.15  )
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



On 2/17/19 2:30 AM, Dmitry Vyukov wrote:
> On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>>
>> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
>> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
>> because there is a burst of too much pointer access, and then KASAN will
>> dereference each byte of the shadow address for the tag checking which
>> will kill all the CPUs.
> 
> Hi Qian,
> 
> Could you please elaborate what exactly happens and who/why kills
> CPUs? Number of memory accesses should not make any difference.
> With hardware support (MTE) it won't be possible to disable
> instrumentation (loads and stores check tags themselves), so it would
> be useful to keep track of exact reasons we disable instrumentation to
> know how to deal with them with hardware support.
> It would be useful to keep this info in the comment in the Makefile.

It turns out sometimes it will trigger a hardware error.

# echo function > /sys/kernel/debug/tracing/current_trace

RAS CONTROLLER: Fatal unrecoverable error detected

	*** NBU BAR Error ***


  MPIDR= 0x81000000
  CTX_X0= ffff10001032eb9c
  CTX_X1= ffff100010205f08
  CTX_X2= 0
  CTX_X3= ffff100010205efc
  CTX_X4= 8
  CTX_X5= 40
  CTX_X6= 3f
  CTX_X7= 0
  CTX_X8= ff
  CTX_X9= ffff0808ba65ab46
  CTX_X10= ffff0808ba65ab45
  CTX_X11= da
  CTX_X12= 10071651
  CTX_X13= fff60658
  CTX_X14= ffff1000140d5000
  CTX_X15= ffff100013855578
  CTX_X16= 804b004a
  CTX_X17= 1000100
  CTX_X18= 0
  CTX_X19= ffff100010205f08
  CTX_X20= ffff100012531cd0
  CTX_X21= ffff100010205f08
  CTX_X22= ffff10001032eb9c
  CTX_X23= 0
  CTX_X24= ffff100012531cc0
  CTX_X25= 12af
  CTX_X26= fffdba05
  CTX_X27= daff808ba65ab460
  CTX_X28= ffff100012531cc0
  CTX_X29= ffff808a2c617320
  CTX_X30= ffff10001009b5a4
  CTX_X31= ffff100012531cc0
  CTX_SCR_EL3= 735
  CTX_RUNTIME_SP= 6e545c0
  CTX_SPSR_EL3= 604003c9
  CTX_ELR_EL3= ffff100010205ecc
 Node 0 NBU 0 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff00
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011ff00

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 1 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff40
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011ff40

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 2 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ff80
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011ff80

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 3 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011ffc0
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011ffc0

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 4 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe00
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fe00

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 5 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe40
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fe40

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 6 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fe80
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fe80

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 7 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fee0
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fee0

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 8 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd30
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fd30

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 9 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fd60
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fd60

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 10 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fda0
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fda0

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 11 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fdc0
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fdc0

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 12 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc00
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fc00

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 13 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc40
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fc40

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 14 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fc80
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fc80

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back
 Node 0 NBU 15 Error report :
 NBU BAR Error
      NBU_REG_BAR_ADDRESS_ERROR_REG0 : 0x0040554c
      NBU_REG_BAR_ADDRESS_ERROR_REG1 : 0x0011fcc0
      NBU_REG_BAR_ADDRESS_ERROR_REG2 : 0x00000004
      Physical Address : 0x40011fcc0

NBU BAR Error : Decoded info :
        Agent info : CPU
            Core ID : 21
            Thread ID : 1
        Requ: type : 4 : Write Back

Current NBU DRAM BAR setting:
Node0 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
Node0 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
Node0 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
Node0 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
Node0 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
Node0 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
Node0 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
Node0 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node0 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR0 Base 00004000 Limit 00007FFC chan_xlation 00004008 node_xlation 00000000
Node1 BAR1 Base 00080001 Limit 000FEFFC chan_xlation 0007C008 node_xlation 00000000
Node1 BAR2 Base 00880001 Limit 00FFCFFC chan_xlation 007FD008 node_xlation 00000000
Node1 BAR3 Base 00FFD001 Limit 00FFFFDF chan_xlation 00FFD000 node_xlation 00000000
Node1 BAR4 Base 08800001 Limit 08BFCFDF chan_xlation 087FD000 node_xlation 00000000
Node1 BAR5 Base 08BFD001 Limit 093FCFEE chan_xlation 08BFD008 node_xlation 00000002
Node1 BAR6 Base 093FD001 Limit 097FCFDF chan_xlation 093FD000 node_xlation 00000002
Node1 BAR7 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR8 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR9 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR10 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR11 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR12 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR13 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR14 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000
Node1 BAR15 Base FFFFF000 Limit 00000000 chan_xlation 00000000 node_xlation 00000000

0.0.0:
  00: AF00177D
  04: 00100006
  08: 06000000
  0C: 00000010
  10: 00000000
  14: 00000000
  18: 00000000
  1C: 00000000
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 0000177D
  30: 00000000
  34: 00000090
  38: 00000000
  3C: 00000000

0.1.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00010100
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.2.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00020200
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.3.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00030300
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.4.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00040400
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.5.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00050500
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.6.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00060600
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.7.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00070700
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.8.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00080800
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.9.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00090900
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.a.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 000A0A00
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.b.0:
  00: AF84177D
  04: 00100106
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 000C0B00
  1C: 20000000
  20: 43104300
  24: 03F10001
  28: 00000100
  2C: 00000100
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 000201FF

0.c.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 000D0D00
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.d.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 000E0E00
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

0.e.0:
  00: AF84177D
  04: 00100106
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00100F00
  1C: 20000000
  20: 42F04000
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 000201FF

0.f.0:
  00: 902614E4
  04: 00100406
  08: 0C033000
  0C: 00800010
  10: 0400000C
  14: 00000100
  18: 0401000C
  1C: 00000100
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 00000000

0.f.1:
  00: 902614E4
  04: 00100406
  08: 0C033000
  0C: 00800010
  10: 0402000C
  14: 00000100
  18: 0403000C
  1C: 00000100
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 00000000

0.10.0:
  00: 902714E4
  04: 00100406
  08: 01060100
  0C: 00800010
  10: 00000000
  14: 00000000
  18: 0404000C
  1C: 00000100
  20: 00000000
  24: 43200000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 000000FF

0.10.1:
  00: 902714E4
  04: 00100406
  08: 01060100
  0C: 00800010
  10: 00000000
  14: 00000000
  18: 0405000C
  1C: 00000100
  20: 00000000
  24: 43210000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 000000FF

b.0.0:
  00: 101515B3
  04: 00100506
  08: 02000000
  0C: 00800000
  10: 0000000C
  14: 00000100
  18: 00000000
  1C: 00000000
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 028A1590
  30: FFF00000
  34: 00000060
  38: 00000000
  3C: 000001FF

b.0.1:
  00: 101515B3
  04: 00100506
  08: 02000000
  0C: 00800000
  10: 0200000C
  14: 00000100
  18: 00000000
  1C: 00000000
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 028A1590
  30: FFF00000
  34: 00000060
  38: 00000000
  3C: 000002FF

f.0.0:
  00: 11501A03
  04: 00100107
  08: 06040004
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 0010100F
  1C: 022001F1
  20: 42F04000
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000050
  38: 00000000
  3C: 000201FF

10.0.0:
  00: 20001A03
  04: 02100102
  08: 03000041
  0C: 00000000
  10: 40000000
  14: 42000000
  18: 00000001
  1C: 00000000
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 20001A03
  30: 00000000
  34: 00000040
  38: 00000000
  3C: 000001FF

80.0.0:
  00: AF00177D
  04: 00100002
  08: 06000000
  0C: 00000010
  10: 00000000
  14: 00000000
  18: 00000000
  1C: 00000000
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 0000177D
  30: 00000000
  34: 00000090
  38: 00000000
  3C: 00000000

80.1.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00818180
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

80.9.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00828280
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

80.b.0:
  00: AF84177D
  04: 00100000
  08: 06040000
  0C: 00010000
  10: 00000000
  14: 00000000
  18: 00838380
  1C: 00000000
  20: 0000FFF0
  24: 0001FFF1
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000048
  38: 00000000
  3C: 00000100

80.f.0:
  00: 902614E4
  04: 00100406
  08: 0C033000
  0C: 00800010
  10: 0000000C
  14: 00000140
  18: 0001000C
  1C: 00000140
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 00000000

80.f.1:
  00: 902614E4
  04: 00100406
  08: 0C033000
  0C: 00800010
  10: 0002000C
  14: 00000140
  18: 0003000C
  1C: 00000140
  20: 00000000
  24: 00000000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 00000000

80.10.0:
  00: 902714E4
  04: 00100406
  08: 01060100
  0C: 00800010
  10: 00000000
  14: 00000000
  18: 0004000C
  1C: 00000140
  20: 00000000
  24: 60000000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 000000FF

80.10.1:
  00: 902714E4
  04: 00100406
  08: 01060100
  0C: 00800010
  10: 00000000
  14: 00000000
  18: 0005000C
  1C: 00000140
  20: 00000000
  24: 60010000
  28: 00000000
  2C: 00000000
  30: 00000000
  34: 00000080
  38: 00000000
  3C: 000000FF
RAS CONTROLLER: SYSTEM HALTED...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
