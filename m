Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F1CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B482086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eIzTuluP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mMJxYlyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B482086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W8ufVdDE8WPqkfZUqaX/zfwiYLGcbUqbHgV6SzDLg2w=; b=eIzTuluPdW7f1D
	RLnwH9g6avzBsOrvrFH07Cfb5O+NzVrGhRM/AgNNwkF0n0sXZc1fhp75csBa2DlJ8sPOP8OkbTRXa
	SLgbphJ3NAS18qoaH7n0oQuEtScWqZ7JZ4D7M8lFX/SfuiqwhFZOdJT381iw0n2nyY8cz6GnmTshk
	2kwzEolPxFBPmBfirR9M9aMXP678+sSXf1HPv/95v8bvsf0kynx9Kc4bF/tlovCt9Rafs6KHiUd0M
	s8Dccxvm8uohbFNAicQCai1QpnIxa2rgrDOrYEBV2lDrED1UP/r3JHPcVZ72niZWRwXXQBUGRm74N
	QjzidQ41It59r4/2BTjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlgQ-0007Zu-VJ; Tue, 11 Dec 2018 17:18:58 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlgI-0007OK-2R
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:18:52 +0000
Received: from zn.tnic (p200300EC2BCD2B003506E5B42EFA948B.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:2b00:3506:e5b4:2efa:948b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 600FE1EC0432;
 Tue, 11 Dec 2018 18:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544548718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=B2OzY8cU66GTPp1Qou0KObuKwALBjauH+fprpDa8uf0=;
 b=mMJxYlyfp6zAlEO6MsZchbb0jNn6HJWtVO+/TUK/dJ40C3IDEaWyVI+6vgVRiQQVmJ5Oxk
 QElCzXNH88LGDRPhjltkmeRygPWf/GqbwGsNFR2zzlH2ne0gUFmFjB8ctobkC/ou1OYX1O
 p72mWR7A9OujFChfw8lF33yMYr0ci10=
Date: Tue, 11 Dec 2018 18:18:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 07/25] ACPI / APEI: Remove spurious GHES_TO_CLEAR check
Message-ID: <20181211171830.GL27375@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-8-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-8-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091850_781804_F8E663B9 
X-CRM114-Status: GOOD (  13.47  )
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

On Mon, Dec 03, 2018 at 06:05:55PM +0000, James Morse wrote:
> ghes_notify_nmi() checks ghes->flags for GHES_TO_CLEAR before going
> on to __process_error(). This is pointless as ghes_read_estatus()
> will always set this flag if it returns success, which was checked
> earlier in the loop. Remove it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index acf0c37e9af9..f7a0ff1c785a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -936,9 +936,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  			__ghes_panic(ghes);
>  		}
>  
> -		if (!(ghes->flags & GHES_TO_CLEAR))
> -			continue;
> -
>  		__process_error(ghes);
>  		ghes_clear_estatus(ghes, buf_paddr);
>  	}
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
