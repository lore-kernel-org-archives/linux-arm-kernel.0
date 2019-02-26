Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:00:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5BF2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nttCJm+n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJj1haDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5BF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=57dv6JDCmoS0LIRzfdETi0j/Q3R9wo3hJlncedCdYzI=; b=nttCJm+nRRlaK3
	zhHkbdQfuwxhwI09WzjVIa5J7w5nWVKBz209SYCxVO5rePH9MymltwTrhosnqPsSt2vR9HGYNCKm1
	OEkubyt/7iBubhjB56MVMtf9kj2rwsoRemW9AExBMLQFWz9YXk3sSYRWqKJS0AVTEnrDLS9X9BqP2
	g6HqbJLpGg2w/oHR8ffA+VYHMtdjsAk9bph7rRpr/+826YQCv72rpKwmgQ6GIALkxgEUWjUzNjf+T
	CF6EWsmNqbUfk4GEmHnwLmgbIdZvG2ieueuixdbbRlZ9XGeMhsHRjamgT5cZ4kaMS4qA0koNw1qOh
	GsHUfHeuP8baFlj/LIcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycLM-0005IK-Tq; Tue, 26 Feb 2019 13:00:20 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycLH-000542-0w
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:00:18 +0000
Received: by mail-pl1-x643.google.com with SMTP id c17so3044854plz.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
 b=iJj1haDeQ/N4knB6ZkfPIbBBikEijc4XMQEhvso+uGw3Gzonlx2LMHbxDNhxdOsLO5
 9/RC7drvjRuaIn9F0S3cLM0+Nf2VDOHoOBcPVpE04JoO4DDFvYHnfNhs3GM3TDepBHHL
 x3uKoOE/K+vdpA+YGX5nfTLL8rGudeiuruGtiPzknZPEsi1M+w74lrRcVnhePEkZKzSm
 hnJ+9/urf6gLp/t3HOljNrg3FSXuSCHaFrniZmdn16YbkBYxmGnUX+M73aEZGT3um4Zl
 RvuLmLpg/dPuOkvCJnfMcBVQMFa+KO/Cdp+mtyFhSiUVeuti7z0gGmnmt7LRbfq0Bfzj
 OJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
 b=Zh3pnzqXnm/LH5twjMSr5xPn8OUOhT+8ETtufNemxFfBLaB0j8HUoq1+3va2Bn5cxq
 Wg6V6lLpH+y2lHj9T6iFrWV70v02E7EpqWmwbwnOqP7oyCbAwBdMSpQ6/e7Uobi721gU
 f2JGwFr7Allw+pfXo6PFmJa/bTYS76h00bxg6gk3QrLx6zn8H7M7EUzd4EvjwoGuoncI
 c9RBrUEB2Ea4vSxrlMhJpzq6oZc/WmFvdYHxcwe77rCiNTy72Eylfg018P+GNw0xeVDn
 WWh2C4fH3M1D6pIS/tbmfSkMVytRcDYpYvlK49nCtjc+O17JsTaXYXCqBDFV0RfDlLhY
 F3HA==
X-Gm-Message-State: AHQUAubY+HErm8VlA1Z584bj0rCLy/1B3WwQ86hboh4C0SRdtdWqyA5W
 iQIuEAG75DM8NkNcGGHFNnnA+FtTTsOcbd8EAqo=
X-Google-Smtp-Source: AHgI3IaS1g7D372cnowLzJym/B9Y1K14HF4sJbQbbdphhYleutKi1EM8iKYA0AgMOkK+w28JpCc2kA1tVi6yaSNleEo=
X-Received: by 2002:a17:902:8b8b:: with SMTP id
 ay11mr26134560plb.162.1551186014272; 
 Tue, 26 Feb 2019 05:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
 <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Tue, 26 Feb 2019 21:00:03 +0800
Message-ID: <CAOLK0pzVwH-1pObn3FjmLorc_pjLu2q0Q_EG4iYm3yb2aXL7PQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
To: Stephen Hemminger <sthemmin@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_050015_092747_68521C43 
X-CRM114-Status: UNSURE (   9.92  )
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@ozlabs.org" <paulus@ozlabs.org>, "hpa@zytor.com" <hpa@zytor.com>,
 KY Srinivasan <kys@microsoft.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "jhogan@kernel.org" <jhogan@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Michael Kelley <mikelley@microsoft.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, vkuznets <vkuznets@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen:
               Thanks for your review.
On Sat, Feb 23, 2019 at 1:08 AM Stephen Hemminger
<sthemmin@microsoft.com> wrote:
>
> int hyperv_fill_flush_guest_mapping_list(
>                 struct hv_guest_mapping_flush_list *flush,
> -               u64 start_gfn, u64 pages)
> +               int offset, u64 start_gfn, u64 pages)
>  {
>         u64 cur = start_gfn;
>         u64 additional_pages;
> -       int gpa_n = 0;
> +       int gpa_n = offset;
>
>         do {
>                 /*
>
> Do you mean to support negative offsets here? Maybe unsigned would be better?

Yes, this makes sense. Will update. Thanks.

-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
