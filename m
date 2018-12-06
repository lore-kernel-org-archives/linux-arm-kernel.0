Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB01C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB3720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mcvy3HGF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2RaiNM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB3720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qEdhxRQVbh0ZWMJJzvb7fwxHyFQuLI8iDSrUyvSGy9w=; b=mcvy3HGFJc2IV6ZTCZKycSXwZ
	ygVi8mZXWECNR0jFrmMNaN5dQSOA6nnyjq/W7aM+yoUBdQs00oClW4jKf/tPOSrmy08/xKcn1cbwZ
	Wz9KlCtvjGv/JlOyZAO+b44hZ0GMZLHvkV6afXNFHqcJhUyTOq1g4Lh1lA6tkbN4do1mdKahAEqZN
	567up2gaehWF48iIvYVSObD3owH3r9ut8wGSWgccEMhQ9IXrrqWtzaXuJkMH1G636COVrbjWQDpiH
	DNIAxWayyi7gYlypnx+C+pexxeCYYM0u2FAzH2NlmR1dmfCfka+X1GUWcDM5bmqMAoIPf7MhhUNY9
	TP9f6mMEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxT1-0006co-K7; Thu, 06 Dec 2018 17:29:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxSx-0006c0-TC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:29:37 +0000
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2BE220850;
 Thu,  6 Dec 2018 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544117365;
 bh=TUvRntZk1OcEvqIqupsVSWgZe0g8MxaGp598uvL5RBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L2RaiNM8HGRox3/Y4EKlUTsQR8fbSnzuEpZ9+Qq2I8+Q1cpLTbP8OCE9QXt+PA0hr
 1Yd5jurWdC5UcMdYVBB3jRkGDvwszi9Jvt2qeJTtqxih0eRO48iZ+Z+smFccdWckEr
 zTHdWFNNxLJKaXPP5jYZi68crnBMRYYgz8NN6Bsc=
Date: Thu, 6 Dec 2018 18:29:20 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v5 2/2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181206172920.GA2728@linux-8ccs>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
 <20181204141415.969-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204141415.969-2-vincent.whitchurch@axis.com>
X-OS: Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_092935_973438_330A68B0 
X-CRM114-Status: GOOD (  23.46  )
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
Cc: linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 dave.martin@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+++ Vincent Whitchurch [04/12/18 15:14 +0100]:
>Thumb-2 functions have the lowest bit set in the symbol value in the
>symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
>generated from the output of nm, and nm clears the lowest bit.
>
> $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
>  95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
> $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
> 8015dc88 T show_interrupts
> $ cat /proc/kallsyms | grep show_interrupts
> 8015dc88 T show_interrupts
>
>However, for modules, the kallsyms uses the values in the symbol table
>without modification, so for functions in modules, the lowest bit is set
>in kallsyms.
>
> $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
>    333: 00002d4d    36 FUNC    GLOBAL DEFAULT    1 tun_get_socket
> $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
> 00002d4c T tun_get_socket
> $ cat /proc/kallsyms | grep tun_get_socket
> 7f802d4d t tun_get_socket      [tun]
>
>Because of this, the symbol+offset of the crashing instruction shown in
>oopses is incorrect when the crash is in a module.  For example, given a
>tun_get_socket which starts like this,
>
> 00002d4c <tun_get_socket>:
>     2d4c:       6943            ldr     r3, [r0, #20]
>     2d4e:       4a07            ldr     r2, [pc, #28]
>     2d50:       4293            cmp     r3, r2
>
>a crash when tun_get_socket is called with NULL results in:
>
> PC is at tun_xdp+0xa3/0xa4 [tun]
> pc : [<7f802d4c>]
>
>As can be seen, the "PC is at" line reports the wrong symbol name, and
>the symbol+offset will point to the wrong source line if it is passed to
>gdb.
>
>To solve this, add a way for archs to fixup the reading of these module
>kallsyms values, and use that to clear the lowest bit for function
>symbols on Thumb-2.
>
>After the fix:
>
> # cat /proc/kallsyms | grep tun_get_socket
> 7f802d4c t tun_get_socket       [tun]
>
> PC is at tun_get_socket+0x0/0x24 [tun]
> pc : [<7f802d4c>]
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Looks good, could I get an ACK from an ARM maintainer? (Russell?)

Also, do you mind if I drop the module_ prefix from
module_kallsyms_symbol_value()? I recently submitted some internal
module kallsyms cleanups [1] and there we have the newly renamed
kallsyms_symbol_name(), so I think it'd be nice if we kept the naming
scheme consistent with just kallsyms_symbol_value(). I could just do
this myself if you don't want to respin a v6.

Thanks!

Jessica

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/commit/?h=modules-next&id=2d25bc55235314d869459c574be14e8faa73aca3

>---
>v5: Use/move local variables to reduce calls and keep lines short.  Use const arg.
>v4: Split out st_value overwrite change.  Add HAVE* macro to avoid function call.
>v3: Do not overwrite st_value
>v2: Fix build warning with !MODULES
>
> arch/arm/include/asm/module.h | 11 +++++++++++
> include/linux/module.h        |  7 +++++++
> kernel/module.c               | 45 +++++++++++++++++++++++++++----------------
> 3 files changed, 46 insertions(+), 17 deletions(-)
>
>diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
>index 9e81b7c498d8..c7bcf0347801 100644
>--- a/arch/arm/include/asm/module.h
>+++ b/arch/arm/include/asm/module.h
>@@ -61,4 +61,15 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
> 	MODULE_ARCH_VERMAGIC_ARMTHUMB \
> 	MODULE_ARCH_VERMAGIC_P2V
>
>+#ifdef CONFIG_THUMB2_KERNEL
>+#define HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
>+static inline unsigned long module_kallsyms_symbol_value(const Elf_Sym *sym)
>+{
>+	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
>+		return sym->st_value & ~1;
>+
>+	return sym->st_value;
>+}
>+#endif
>+
> #endif /* _ASM_ARM_MODULE_H */
>diff --git a/include/linux/module.h b/include/linux/module.h
>index fce6b4335e36..12146257eb5d 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -486,6 +486,13 @@ struct module {
> #define MODULE_ARCH_INIT {}
> #endif
>
>+#ifndef HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
>+static inline unsigned long module_kallsyms_symbol_value(const Elf_Sym *sym)
>+{
>+	return sym->st_value;
>+}
>+#endif
>+
> extern struct mutex module_mutex;
>
> /* FIXME: It'd be nice to isolate modules during init, too, so they
>diff --git a/kernel/module.c b/kernel/module.c
>index 3d86a38b580c..9364017fdc21 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3922,7 +3922,7 @@ static const char *get_ksymbol(struct module *mod,
> 			       unsigned long *offset)
> {
> 	unsigned int i, best = 0;
>-	unsigned long nextval;
>+	unsigned long nextval, bestval;
> 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
>
> 	/* At worse, next value is at end of module */
>@@ -3931,10 +3931,15 @@ static const char *get_ksymbol(struct module *mod,
> 	else
> 		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
>
>+	bestval = module_kallsyms_symbol_value(&kallsyms->symtab[best]);
>+
> 	/* Scan for closest preceding symbol, and next symbol. (ELF
> 	   starts real symbols at 1). */
> 	for (i = 1; i < kallsyms->num_symtab; i++) {
>-		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
>+		const Elf_Sym *sym = &kallsyms->symtab[i];
>+		unsigned long thisval = module_kallsyms_symbol_value(sym);
>+
>+		if (sym->st_shndx == SHN_UNDEF)
> 			continue;
>
> 		/* We ignore unnamed symbols: they're uninformative
>@@ -3943,21 +3948,21 @@ static const char *get_ksymbol(struct module *mod,
> 		    || is_arm_mapping_symbol(symname(kallsyms, i)))
> 			continue;
>
>-		if (kallsyms->symtab[i].st_value <= addr
>-		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
>+		if (thisval <= addr && thisval > bestval) {
> 			best = i;
>-		if (kallsyms->symtab[i].st_value > addr
>-		    && kallsyms->symtab[i].st_value < nextval)
>-			nextval = kallsyms->symtab[i].st_value;
>+			bestval = thisval;
>+		}
>+		if (thisval > addr && thisval < nextval)
>+			nextval = thisval;
> 	}
>
> 	if (!best)
> 		return NULL;
>
> 	if (size)
>-		*size = nextval - kallsyms->symtab[best].st_value;
>+		*size = nextval - bestval;
> 	if (offset)
>-		*offset = addr - kallsyms->symtab[best].st_value;
>+		*offset = addr - bestval;
> 	return symname(kallsyms, best);
> }
>
>@@ -4060,8 +4065,10 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> 			continue;
> 		kallsyms = rcu_dereference_sched(mod->kallsyms);
> 		if (symnum < kallsyms->num_symtab) {
>-			*value = kallsyms->symtab[symnum].st_value;
>-			*type = kallsyms->symtab[symnum].st_size;
>+			const Elf_Sym *sym = &kallsyms->symtab[symnum];
>+
>+			*value = module_kallsyms_symbol_value(sym);
>+			*type = sym->st_size;
> 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
> 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> 			*exported = is_exported(name, *value, mod);
>@@ -4079,10 +4086,13 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
> 	unsigned int i;
> 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
>
>-	for (i = 0; i < kallsyms->num_symtab; i++)
>+	for (i = 0; i < kallsyms->num_symtab; i++) {
>+		const Elf_Sym *sym = &kallsyms->symtab[i];
>+
> 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
>-		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
>-			return kallsyms->symtab[i].st_value;
>+		    sym->st_shndx != SHN_UNDEF)
>+			return module_kallsyms_symbol_value(sym);
>+	}
> 	return 0;
> }
>
>@@ -4127,12 +4137,13 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
> 		if (mod->state == MODULE_STATE_UNFORMED)
> 			continue;
> 		for (i = 0; i < kallsyms->num_symtab; i++) {
>+			const Elf_Sym *sym = &kallsyms->symtab[i];
>
>-			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
>+			if (sym->st_shndx == SHN_UNDEF)
> 				continue;
>
>-			ret = fn(data, symname(kallsyms, i),
>-				 mod, kallsyms->symtab[i].st_value);
>+			ret = fn(data, symname(kallsyms, i), mod,
>+				 module_kallsyms_symbol_value(sym));
> 			if (ret != 0)
> 				return ret;
> 		}
>-- 
>2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
