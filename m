Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E278C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4B021971
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ruhPZuCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4B021971
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBfknodvYBsmf4FABd+bDIBYeSTk8rgqpYPWYaIpHXo=; b=ruhPZuCQCPhxuY
	D3khnPgx2JnxIh0hqDUTatthmpDxkw7qUfSidPMmNdRGulVUjhyQ4V6aCIAdcV60tqA7vjm66qCZt
	R7CDLDUQNSa8IrMNfMGLxoiSFqcTHBeDb0KPDPyFvfbEiyiiEyw3s52yJZxqSWu3vxcHs849Si+tt
	3iuplDC2lRWdfT+mpQDpVwh5Eb6dr1RQ9ArAVG82po6LUctDWbNovXyLhM6HhgkZvM1S/HRx6lUN3
	3sX9MMjE1N7cPrEZhHaZd/vwsBhH72Q6XKTimrmBoyFTXO5vocKpMxXadrdm+gSR3E+yYZt5Bktbd
	kumsgH8JM0e5eceCc88A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb62v-0004w9-FM; Sun, 23 Dec 2018 15:52:05 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb62t-0004v6-1c
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 15:52:04 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 0EDE48119;
 Sun, 23 Dec 2018 15:51:54 +0000 (UTC)
Date: Sun, 23 Dec 2018 07:51:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181223155147.GI6707@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181223103315.GA1936@amd>
 <20181223111059.GB1936@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181223111059.GB1936@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_075203_125267_19FA5A33 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: Rob Herring <robh@kernel.org>, Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michael Scott <hashcode0f@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [181223 11:11]:
> I added some printks to motmdm_probe, and they don't appear to be
> called. I wonder if I'm missing something else in the config? I do
> have serial
> 
> root@devuan:/my/ko# ls -al /dev/ttyS0
> crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0
> 
> but not gsm multiplex:
> 
> root@devuan:/my/ko# ls -al /dev/gsm*
> ls: cannot access '/dev/gsm*': No such file or directory

Hmm with serdev you should not get /dev/ttyS0, so maybe you're missing:

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y

Probably the Kconfig dependency should be for SERIAL_DEV_CTRL_TTYPORT
instead of SERIAL_DEV_BUS in these patches if that helps.

Or else you're missing the serdev related dts changes?

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
