Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD4EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC8C2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ns0VwfkQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b8qfzftv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC8C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N964DrB/59keYB9hKPClxfsQKXRrJmrIDhlWS1niJcQ=; b=ns0VwfkQOXaAUq
	HZB1rFh+oDZfhnmXrqE76q45v6pEWGfSj+8x3cuH9FfUGkz01KV/PkE0Va8wkD2H8/twdMU/wXKU5
	1+GbVTDo+nMaFjRQvGblYzfHoG3PZMiIOaMV0sGSYXjvUqS6CuEUTeLCH2HF/Wl5ljUjrGrFP9+HS
	2y9XO9mEcSTs1mv1fGFBzTpWmRR/ugVUPqm+Sep8drBnfe2OSptvo71I6G6CJS7Gq68I8ALrtoYyz
	TbqU1RnmFH7r/Whqvzos4+dnikKDj+o7KeBIK23wMfBD7n+DkVkTSBK4Ih8zgQXw6Xm0+G9FSScoN
	BSbmFrLEx9XLunBIn3Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCpE-0008C6-EE; Wed, 12 Dec 2018 22:17:52 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnb-0006Jt-4h
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:45 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so17719126ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R3s3/uDbmK5xVBGG9Mu8VuBAJIRcLJVL+0J8S7pa9Ok=;
 b=b8qfzftvTMWCTX0/ufGPmx6TClH6f/VZQMOPKm5+LwPkAUAnhudmadXkMCOniktF5f
 3b7qwoAGhjFWdXiwTpge3F4nkodsZO3MvO0kc7Rtq1UT2Z9qw9j3lba99vMHd24swaqp
 lSMlPYLQ8fdxLxGV61kleaoA44jUg3br0WeRhzEjE0HIgi5mfCPhgxOSUUusppQAJ4nt
 4hxO+Glywkpy0ikSxrnXkMlsiFuj9o6HkPL7f2TPsmzvmarr6/cyjg+nBx4boAt7DL9L
 w4yQz3ivi79qZsx/CxNWlJPWvP/5yYJRxJnXQ9wZ5hdwYEpaPxc64QyVldOFN2URARC2
 Vq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=R3s3/uDbmK5xVBGG9Mu8VuBAJIRcLJVL+0J8S7pa9Ok=;
 b=Llk105jK5rywtsEEO7garA5yrd2j53TYC/FOgVsGWbaVpK0NTHx9/q4tSB/Dxule5V
 IEcmdMz5T/x2t8Nm1zJzUZMFHRjC4YPa84WYERBRD7lmXZaN1xGBtBVObJa+/GLE9gH/
 //4QAPKExPudF9dRv+FF5LILQAcN2A/u4IiEx2iuE/m7PmXPzwZyWkuZiruy5EeqFL4d
 4vTIfjIXfs6wvaCMkk5t9P8tq3eZUPNJekgHX7/1/5Z0DU7G2HAlmzTnJui6CnSWINWU
 RTq87OrS0Ju1XumxEEy3oyvb8gEP/EEzK3WYAmYivFY5QXlxSHP0zkToXaBHe6WqtcuY
 ck3g==
X-Gm-Message-State: AA+aEWbTz4QQb+BYf1n2lbn3RmCRsdkv4Z2w5OmQdUqBIv8bug+CRwq8
 dUCnU2dBrHQBv4z2ZZ2QuhgmuA==
X-Google-Smtp-Source: AFSGD/XbMHY39wLCj2dgNUr7mCKBSpNZhc/IrH+VT2Am20OhxXGqa6ql0mIutSCCbYrJPFcMuoiPVg==
X-Received: by 2002:a2e:4442:: with SMTP id
 r63-v6mr13208033lja.79.1544652959493; 
 Wed, 12 Dec 2018 14:15:59 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d2sm5146lfg.16.2018.12.12.14.15.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:57 -0800 (PST)
Date: Wed, 12 Dec 2018 13:36:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181212213617.mltwlxfcbap4prlj@localhost>
References: <20181212122800.GA29450@jax.ideon.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212122800.GA29450@jax.ideon.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141612_080714_67DF4EF0 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this tee driver fix for a possible double list_del() in the
> OP-TEE driver while uninitializing.
> 
> Thanks,
> Jens
> 
> The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> 
>   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> 
> for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> 
>   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> 
> ----------------------------------------------------------------
> Avoid possible double list_del in supplicant comms
> 
> A fix for the OP-TEE driver to avoid possible double list_del during
> tee-supplicant communication while the system is shutting down.

Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
name is 4.21. 


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
