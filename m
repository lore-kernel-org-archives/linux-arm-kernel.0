Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:45:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JdGLBtO0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ESerqXi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n7hbfRikYZVhHX13Vn7WjLI2BDkz+TBD0pmQPaOu5XU=; b=JdGLBtO0khyFtI
	7ZRNtvpwpQIKnuOkdPoyR/7DgYL55X+xEsE3ctfCJ31FwlkXId6CeAOjtuWTjXdytQcAyix0u/Uba
	6cO+SQDh3ha1KfKlLhOcWWf2hEeLpwh0m999OueHSxec8G0ZFONnlH/xL3Qpx2ij4347STc7L4v6C
	3HaLZtB89oYOHWwx7tfqDonMZ3ovhn9l1AjBC/RnkZwojO5cm1wRvAmPUesrfGW5m9vmjx7GBzmnJ
	O0HMVz0dgyHRMQkLiEqrjf/g7FSSe5khtMU5wRW7xEJ3WFZMNJGZDlG0uLzlDgLj6aIdv59JW9dHZ
	D0ySJakm8xTCaDcJBb0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWm5p-0002nY-6J; Tue, 11 Dec 2018 17:45:13 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWm5m-0001WS-0Z
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:45:11 +0000
Received: from zn.tnic (p200300EC2BCD2B003506E5B42EFA948B.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:2b00:3506:e5b4:2efa:948b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AE471EC0432;
 Tue, 11 Dec 2018 18:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544550298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=SE+YdiHz6r8Sy5K3pOits8b75DPsy1LHusKIM96m+N4=;
 b=ESerqXi6daUudHXgLiz70I3ODuqmRVm/zemvyR31ZY7FOrKhX2QE+5HVrdr+ty2qVkEUDQ
 OBnwSKewFwxWtAmTTDqeZ+abVakieqZcUQS2NdrFwqLsFkV0PksjS0OeRVPuOpxgYdOEWb
 FKw6+FDW7Ys7f61GyaAfmcPoaeqSIVw=
Date: Tue, 11 Dec 2018 18:44:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 09/25] ACPI / APEI: Generalise the estatus queue's
 notify code
Message-ID: <20181211174449.GM27375@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-10-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-10-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_094510_214197_E38275BC 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:05:57PM +0000, James Morse wrote:
> Refactor the estatus queue's pool notification routine from
> NOTIFY_NMI's handlers. This will allow another notification
> method to use the estatus queue without duplicating this code.
> 
> This patch adds rcu_read_lock()/rcu_read_unlock() around the list

s/This patch adds/Add/

> list_for_each_entry_rcu() walker. These aren't strictly necessary as
> the whole nmi_enter/nmi_exit() window is a spooky RCU read-side
> critical section.
> 
> _in_nmi_notify_one() is separate from the rcu-list walker for a later
> caller that doesn't need to walk a list.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> ---
> Changes since v6:
>  * Removed pool grow/remove code as this is no longer necessary.
> 
> Changes since v3:
>  * Removed duplicate or redundant paragraphs in commit message.
>  * Fixed the style of a zero check.
> Changes since v1:
>    * Tidied up _in_nmi_notify_one().
> ---
>  drivers/acpi/apei/ghes.c | 63 ++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 22 deletions(-)

...

> +static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
> +{
> +	int ret = NMI_DONE;
> +
> +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> +		return ret;
> +
> +	if (!ghes_estatus_queue_notified(&ghes_nmi))
> +		ret = NMI_HANDLED;

So this reads kinda the other way around, at least to me:

	"if the queue was *not* notified, the NMI was handled."

Maybe rename to this:

	err = process_queue(&ghes_nmi);
	if (!err)
		ret = NMI_HANDLED;

to make it clearer...

And yeah, all those static functions having "ghes_" prefix is just
encumbering readability for no good reason.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
