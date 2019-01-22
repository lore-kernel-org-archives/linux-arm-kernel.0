Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E49C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:00:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48D3217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvJ7i/hd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2KnJ3lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48D3217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VF9FU45xE8uoOO7a92gSpG54uIGEydeZ7Wz19fW25P4=; b=QvJ7i/hdqqEXJ8
	PdxryHlzQwDfCOEbatpmyNZUNPyn5CGN5v238EjOWvtdFsRRFu2qy2bvcnzBaPbXsG7QqgqtgZ7qD
	fOSaA9bE5O9PJUf+q0pZ2WTm+wB5EXkKPQkDg40x9sRgB4DYLLw+EgbgjnmCOP2I2+AinnlDHJv21
	KJDygNsqwfP0apn6vFvPoYMvMNZZwlOZiTrSYBeraK1cyIX/9Jsu8wRC8c4QAQE78XCwbXGfGIJFp
	5yz+i/uH3QlRUPlBmcJ11vGuPJCHenvtHLxmKjBV5DbGkiC9/i/i9VuAlW7QKplNQbNk6q3oJTCeP
	yWKfs2W6AVH7VL/FXzAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxXq-0002NR-TO; Tue, 22 Jan 2019 15:00:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxXn-0002MI-SD; Tue, 22 Jan 2019 15:00:53 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B04CB20879;
 Tue, 22 Jan 2019 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548169251;
 bh=HJZhPDbYJqMS4nNQEXqjZxg5xuXEMO4YuuHVnKrEN34=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e2KnJ3lUC2XZRAlej4KHBaC/einrcStzo7CMYurCtAeovVfHhtI9vh8XDw/TxQNRh
 MdDgMVk7TWbmwfP3iZ9HUv6TPfrYt2n1Ss90m0IAeIv2w84XH/P78tKWzsthPOw+QP
 v7ZRd3A9Oo7Ft7eStSUxwiZKBrFmAEUNjF7XGVlo=
Date: Tue, 22 Jan 2019 16:00:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Message-ID: <20190122150048.GA11466@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
 <20190122124204.GA26969@kroah.com>
 <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_070051_928820_0D179EB5 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 04:45:20PM +0200, Georgi Djakov wrote:
> On 1/22/19 14:42, Greg KH wrote:
> > On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
> [..]
> > 
> > All now queued up, thanks.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for considering these patches! Actually i have a branch named
> icc-next [1] which is pulled into linux-next. I will drop these same
> patches to avoid conflicts.
> 
> If all is well, i was wondering how to proceed with follow-up patches.
> Some consumers of this API are already floating on the lists. How about
> sending you a pull request before the merge window with the collected
> patches?

Sure, that works, or you can just send them as patches, either works for
me.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
