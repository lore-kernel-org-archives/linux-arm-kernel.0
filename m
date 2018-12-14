Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF262086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tg7pehnP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8YEMqbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF262086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fgdznc4Bn5F9rG8EPFkZTo2g1GDma9xFIHVoVY4OnGE=; b=Tg7pehnPmbVbYGSP4vDzENbhT
	EYG1H7Zmy7jSVzDXni5jowNlJNtKw+tS88M4p+hxpzr95kF2Bg/emXduvjI7SRuQMB60HdDjTUf1J
	DsYmbmrFzUVd6F+Dh7+2y7SXSfFGCYt3PCVVGLexaFTVyQrrpH/DpXpoak4vIBNUZECW++PFVMhWk
	0kVGRBXybyjHEaNxb75Dhcel1OMVblAKijaGOcI9dA4vAkbmDFpc9FqYnNjYIxgQs4L3E3+3kD5Qm
	tHbGapcHJmT1ZXUyqUTxNIHZaZCRrN7hxVBKhqx0NDaE20pIP5STt/uLQFJ9Gvwova/NI4wADmFIc
	VOSrDjOnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuYh-0007Zm-Hx; Fri, 14 Dec 2018 20:59:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuYe-0007Ym-Pp
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 20:59:42 +0000
Received: from linux-8ccs (ip5f5adea1.dynamic.kabel-deutschland.de
 [95.90.222.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0399B2086D;
 Fri, 14 Dec 2018 20:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544821170;
 bh=QIyRYcDS8dvfL8d9WoHeQ5SoQird6ZVQTKa3VcZN68M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g8YEMqbYWYKeWuKqXyZQ8WixEa2VEPiQ4Z+TIj6eQRi13XxmpZEJKn9NpaYWgltNv
 3sqBnyhFDMNc6QRmAF0RmX7/t9byJgl1Z6aG7lRa7P9VQwYk4J8jXEVGJY2GzrkhrH
 rU+PLBE0xObwAKO6zoDrFGuIi9Te2vMbMgj6Qnvs=
Date: Fri, 14 Dec 2018 21:59:25 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v6 modules-next 1/2] module: Overwrite st_size instead of
 st_info
Message-ID: <20181214205925.GA9656@linux-8ccs>
References: <20181214160555.9980-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214160555.9980-1-vincent.whitchurch@axis.com>
X-OS: Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_125940_856926_CB3466EC 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: Vincent Whitchurch <rabinv@axis.com>, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, Miroslav Benes <mbenes@suse.cz>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+++ Vincent Whitchurch [14/12/18 17:05 +0100]:
>st_info is currently overwritten after relocation and used to store the
>elf_type().  However, we're going to need it fix kallsyms on ARM's
>Thumb-2 kernels, so preserve st_info and overwrite the st_size field
>instead.  st_size is neither used by the module core nor by any
>architecture.
>
>Reviewed-by: Miroslav Benes <mbenes@suse.cz>
>Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied both. (Thanks for rebasing!)

Thanks,

Jessica

>---
>v6: Add Miroslav Benes' Reviewed-by
>v5: Add Dave Martin's Reviewed-by
>v4: Split out to separate patch.  Use st_size instead of st_other.
>v1-v3: See PATCH 2/2
>
> kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 1b5edf78694c..b36ff8a3d562 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2684,7 +2684,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>
> 	/* Set types up while we still have access to sections. */
> 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
>-		mod->kallsyms->symtab[i].st_info
>+		mod->kallsyms->symtab[i].st_size
> 			= elf_type(&mod->kallsyms->symtab[i], info);
>
> 	/* Now populate the cut down core kallsyms for after init. */
>@@ -4070,7 +4070,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> 		kallsyms = rcu_dereference_sched(mod->kallsyms);
> 		if (symnum < kallsyms->num_symtab) {
> 			*value = kallsyms->symtab[symnum].st_value;
>-			*type = kallsyms->symtab[symnum].st_info;
>+			*type = kallsyms->symtab[symnum].st_size;
> 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
> 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> 			*exported = is_exported(name, *value, mod);
>-- 
>2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
