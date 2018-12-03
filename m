Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:52:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE45D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOcqI+w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE45D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x6ZugWrzsswo9289/6pGw9cSVD1KWQjJG5XU3p4Ocn4=; b=jOcqI+w0NxjNiR
	yE5+nrrwYgXiGzqv0ZC9AohGr0s8WRZ0NvfhyRsT8XPEChXEsZWzCaByXY8hutuw78XmpGzs3gwkQ
	cjqh2++Uha9TRzHfRueyrIXFEfjZlxchVqSDaAHKbuFigce1cxxUYCve+Scy6tsSNpm7qFZ1WriQc
	oprwZx90l3euXtAonNnRmazaU+uaT8spqXtaE7+40uSDseHYNM326uPb0Zlz+kCW79tsXf6pKYjkY
	1ZQ8S4iuGjEhW37ygAWZ5xHPRAzzmLUgJIRtTviRJpk8yotfUfdU69NPnt8N6WZ5fOeTIXtB/iDjE
	/hkazzkm1C8uDSKKhPVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTw8e-0007g7-5D; Mon, 03 Dec 2018 21:52:24 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTw8a-0007fQ-Sg
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:52:22 +0000
Received: by mail-qt1-f193.google.com with SMTP id d18so15695610qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wz3G1K0Wqct2QY1g8HOnYswKaEU/I5gQsQNRf+imps4=;
 b=OTPZH2UMFvLGvxmktev49OmTPjovzCV32cdFa+nTGOKtxZflSLgyu/4jJ0nyylfhwS
 YGjTbWaDRAVmI1UFxnGl3LBlP7bg08HA81zdiZyER5zdYkkHTO2RtCOqMmj5XPxCfhkb
 6MFDKgrqza6LpkEA4Xdcx5EaRMgqGPU0JjDTWeeSlyhRY27G1kbCjswAqAII6XMSOVoG
 oFFt8/N7ctkvs+M+jf3S0XiC8nS1MYv6h6oizLmeI36SHG4f60NWmjLoBh2LnFLf3DxH
 ZECMZRVJjl0TjUK5axWWe4YJvpp7aqrCU0R3DkQbqbZ/giZE7cySWm1wQPAO+LCGDKpR
 fGAA==
X-Gm-Message-State: AA+aEWa5tMWdLLaRGMmixL1ZKxpGQoHtB08X0VSaxct3OV+LZWSL7kur
 Napn1CMJbl4GjVXK31KjsRWOcN4oefkrEGhAo/E=
X-Google-Smtp-Source: AFSGD/VZG2VieAMQM8L8JLVwrZC2CJU9F3fdxhqwMdhMSgQv79tym8p9rpuV1A7/MFQXfKzsGg0QxctbqsJi4keAHHw=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr16754405qtr.319.1543873929119; 
 Mon, 03 Dec 2018 13:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
In-Reply-To: <20181203192228.GC29028@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 3 Dec 2018 22:51:52 +0100
Message-ID: <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_135220_925873_4EB9D5C1 
X-CRM114-Status: GOOD (  23.10  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Kees Cook <keescook@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 8:22 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Anders,
>
> On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:
> > Both of those functions end up calling ftrace_modify_code(), which is
> > expensive because it changes the page tables and flush caches.
> > Microseconds add up because this is called in a loop for each dyn_ftrace
> > record, and this triggers the softlockup watchdog unless we let it sleep
> > occasionally.
> > Rework so that we call cond_resched() before going into the
> > ftrace_modify_code() function.
> >
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>
> It sounds like you're running into issues with the existing code, but I'd
> like to understand a bit more about exactly what you're seeing. Which part
> of the ftrace patching is proving to be expensive?
>
> The page table manipulation only happens once per module when using PLTs,
> and the cache maintenance is just a single line per patch site without an
> IPI.
>
> Is it the loop in ftrace_replace_code() that is causing the hassle?

Yes: with an allmodconfig kernel, the ftrace selftest calls ftrace_replace_code
to look >40000 through ftrace_make_call/ftrace_make_nop, and these
end up calling

static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
{
        void *waddr = addr;
        unsigned long flags = 0;
        int ret;

        raw_spin_lock_irqsave(&patch_lock, flags);
        waddr = patch_map(addr, FIX_TEXT_POKE0);

        ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);

        patch_unmap(FIX_TEXT_POKE0);
        raw_spin_unlock_irqrestore(&patch_lock, flags);

        return ret;
}
int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
{
        u32 *tp = addr;
        int ret;

        /* A64 instructions must be word aligned */
        if ((uintptr_t)tp & 0x3)
                return -EINVAL;

        ret = aarch64_insn_write(tp, insn);
        if (ret == 0)
                __flush_icache_range((uintptr_t)tp,
                                     (uintptr_t)tp + AARCH64_INSN_SIZE);

        return ret;
}

which seems to be where the main cost is. This is with inside of
qemu, and with lots of debugging options (in particular
kcov and ubsan) enabled, that make each function call
more expensive.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
