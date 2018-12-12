Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D27F20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhJzX7VJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="T/On6EAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D27F20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6VA6Js5+uLfSsmN7z6ql/MhJ1xHsBpfL9qEwuyFXTw=; b=nhJzX7VJyf5C5f
	WXbIEdku3TnEqgkXT9yJLmSlv4OuDWU/9/UfSNNe6LJtgjKrKaPwmg5DKLpjnqD1TXh4no41Z+84w
	rLuMmU3raRcHTofoFNWQe5G3pxKLciAxh0GoT9MpP9LrhbaotI4w6Clt5Lf4mnwr2skzbFU6EIKk5
	p22IUMglgdIlqWoTjegFRkH7gZ1+jopkTjzw3FwFmmvyZBG58NsRCxTHVudcbM2Tyf5QtWxsWYK5S
	DplxYOFHPfcIJ/Oc38E36qnWkRsuQik6I6bz14TnP/Z/xgIpELmiNqsasNGCxE1zGd1drMIkfuw6K
	mJ4LVjs4Gpq3zYhwYx9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWwgv-0002m4-Go; Wed, 12 Dec 2018 05:04:13 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWwgt-0002kv-1r
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 05:04:12 +0000
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43F4Tm05yWz9s3Z; Wed, 12 Dec 2018 16:03:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544591036; bh=rhEosjEfZQzhO2bufzhDYXx13Ie6MQ63HUdwjJ0mvBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/On6EAJ8s/c3MCJUpyi0kf9eTf6ldoCznRPofkXLaxKgJyPQxhH9fJdLuTG7YgFS
 8MO6GzMJ3B7M0nAT+1jT/U3psl3Eqq8zIp8uWaTK+FjVvNTLN5/PlawFEOMHsibAi0
 ycC21g1yRthYEBTXQHmnGLzkR0mxghAfMYMRWNFU1XYZiuGvMwYrxtr7d5IIMRpg37
 vhA8lSSTfddQAEMd82tUYsNiViWUKYGvo+AUDkfuLQ881gC2J9eNZ1bRfyed/XJ2H2
 aOG4vMImeDe/8pM0mlwJD0MNgTps+a2EuB5w3+D5qRBrss3J1w9BaKZp5CRctDdfO7
 M8+jaPBfh+LQg==
Date: Wed, 12 Dec 2018 16:03:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: lantianyu1986@gmail.com
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
Message-ID: <20181212050353.GF22265@blackberry>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_210411_286677_060B029B 
X-CRM114-Status: UNSURE (   7.49  )
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The patch is to make kvm_set_spte_hva() return int and caller can
> check return value to determine flush tlb or not.

It would be helpful if the patch description told the reader which
return value(s) mean that the caller should flush the tlb.  I would
guess that non-zero means to do the flush, but you should make that
explicit.

> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

For the powerpc bits:

Acked-by: Paul Mackerras <paulus@ozlabs.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
