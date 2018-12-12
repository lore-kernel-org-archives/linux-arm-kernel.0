Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F80C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FB620839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXoNHoqn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYAasLbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FB620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DV+myP19K+HKxbFYLLpenjC+HqOIW+z0g3jsspIH6QA=; b=kXoNHoqnIcpcyr
	8u0veddqhRoD7VolDlIHXU/XUJsSnkNOdD1TysrMVgIbe5SjofTuTeh0QcZDAb+PuI6x1s73YFn4O
	QH2vU9c9MWp5LOsCVk0MDFtZxlCkWLdeKg8aU/f03rh2Ftf3Pn2VYVDLL98L0udnRz0glK3IaSEV6
	bg/+EiAyi1QWxtJP0vf1aBhDKSzJr0af7rWd5hZ+TKoHkJjXFsVMCj48jox6Z7a/9jFhGwBHd3Ete
	ve2ZomgPxfPrDVVmRtb5An/WKRYqvmqwLLsMawuyMFmZn26DOioSSBaOcV7TPQx0cQdnJ78q0BK5+
	ReC+xBDx0wiSiG8/FSww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3fv-0000yg-PX; Wed, 12 Dec 2018 12:31:39 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3fs-0000xk-36
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:31:37 +0000
Received: by mail-lj1-x22e.google.com with SMTP id e5-v6so16125938lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 04:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=oM7AeCHhjJOAyr8ADYL7ecfUVGQgyXPwClZKi4GtDW8=;
 b=VYAasLbdR1Umx0nfjWCo5OFRQFOcBq0mXFaR/2u29geb44g3Kfz6mM3GZ6gfiK1Nr0
 y+j1E/zwbrPoL9+wuJm5zU2R6JRi4D7k7z2U+XWLNAc9CHko1RP/JAjHmyRgju/FsBI7
 ytEl1J5Qb6amIGub3aw6myGAo9T7cWVZuxOzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=oM7AeCHhjJOAyr8ADYL7ecfUVGQgyXPwClZKi4GtDW8=;
 b=VWLbOmEzyrcOeCox4uNjFB4p6XCSZV3s6ebSmiFANW3flBSFCtVO021XGW0lRHOJl+
 Pwogfdnx5MkKjmQTDhss2UirLjljMFCule89S8h08TKMqc5pT8Q2iUrg6/AJhx4sCnbJ
 Rm31pP0rD0ZN30EFPuBEXGT/PU09J7yjkSDPVj6qNBOKRUiZN9TqjceAb/bB0z/UO//r
 OV9Fo3lhMvzpsimyZa+9NV6z2awvdb6AMPxXrS2b/EWMtRFkbHav8+TgLBO5wwCvf9YH
 fNLCEaiPhbVQVynGfSt2Sjq58NrhTwjfkiB9I79y8qdM4kDpAJAZpzkl+b2yuWf2hRA+
 wudQ==
X-Gm-Message-State: AA+aEWb+nUR0UBlQ3PFnKf15wAQRqLXV09U9oVbxE4RAgxk8EtSOAOGP
 ph1wN7SWG6BUWRU3aQv5xN9vvCsiKfk=
X-Google-Smtp-Source: AFSGD/U13KJTbQxjOoRnRRkThFeeVYy1ZFk2VlxuDAH+1wCk29DXz2pMsTF584un44Cyb7GR4GXUPA==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr8517354ljd.140.1544617883987; 
 Wed, 12 Dec 2018 04:31:23 -0800 (PST)
Received: from jax.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id n8-v6sm3511302lji.90.2018.12.12.04.31.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 04:31:23 -0800 (PST)
Date: Wed, 12 Dec 2018 13:31:21 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm-soc <arm@kernel.org>
Subject: [GIT PULL] tee subsys for v4.21
Message-ID: <20181212123121.GB29450@jax.ideon.se>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_043136_154661_26EE9FD7 
X-CRM114-Status: GOOD (  11.00  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver enhancement. A friendly log message
is added to inform that dynamic shared memory is used when initiazing
the OP-TEE driver.

Thanks,
Jens

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-optee-for-4.21

for you to fetch changes up to 3c15ddb97c77f34ba009910becd5921f169770a2:

  tee: optee: log message if dynamic shm is enabled (2018-12-11 14:38:40 +0100)

----------------------------------------------------------------
OP-TEE dynamic shm log message

Adds a log message in the OP-TEE driver to inform that dynamic shared
memory is enabled.

----------------------------------------------------------------
Victor Chong (1):
      tee: optee: log message if dynamic shm is enabled

 drivers/tee/optee/core.c | 3 +++
 1 file changed, 3 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
