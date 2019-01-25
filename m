Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68850C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C10218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvdLp+nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C10218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+LdgOii7potcayZ3lg8p/5X5GYFRQKkEz/LdAqxsfVQ=; b=jvdLp+nOUXZ2L0
	RVO5CO7283OiLFlBR8B5rN26JMFkqAGaocfg62XbT9DwTvKdgtcKXbAh/Lep8X/OHczzwWTU47NuF
	mhzPdcW8MqjuRhY8eZqFnIa0SEVajKPiYJX2rcoSryq4G8oVi865b4ab1Rk5Sz9/Flc4IsqndfEw5
	paLbIGf4Ts40t3BY0xNRnm6VVZF5ptGxp+9F/QJAwkK8IvLMQOOayyfs3iL+nbvlrLazCwHeSX9Za
	ocO1wUCoNiHwjagqNPnDOlhQZxA34mEzjXKR9u4bw9D3Cu3RiGVPCmHYB0cTYqnheBLE96T0fnO/k
	KQYsxyRFVjhl8F3WjWhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn34f-0003c0-6z; Fri, 25 Jan 2019 15:07:17 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn34Z-0003am-OZ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:07:14 +0000
Received: from [192.168.178.52] ([109.104.48.130]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjOl-1hS8GC3fo3-00lGpf; Fri, 25 Jan 2019 16:07:03 +0100
Subject: Re: [PATCH] mmc: mxs-mmc: Introduce regulator support
To: Martin Kepplinger <martink@posteo.de>, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, robin@protonic.nl
References: <20190125113449.10128-1-martink@posteo.de>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <a193bd83-bef6-dc60-b752-a8e355b44082@i2se.com>
Date: Fri, 25 Jan 2019 16:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125113449.10128-1-martink@posteo.de>
Content-Language: en-US
X-Provags-ID: V03:K1:ucaF43hGRMhO35kCOuGkoiDdlEVkBnYIqrXV2GzRw86W3cPN1OV
 br/+GN6PQNBowxx94uiDprjDe7jviXtl7IROKk/54cW9b18vc7HVdDjXDkDjCPr3Vz5Ry72
 JS5591gt9bXnM+omn7QriQQxpI9yhO+1kRVRS6G0PeE3atxtYzdoiDxqJ20DHk5bivAWYDX
 u2E3zVRzwp1MBfvlp5ahg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAV8ZLXhoG8=:s7ch59USJwhIce4l+3fbT2
 KY7ZehIaJk9MgoCJZIHqK+/c+6CjxHoDp17XQ5T2OdNynCiH7UbvKc4uzWnmz+uS5NSnzRtVr
 Xi7ctAJXXTcFi/I0XZtpqDFDxWI8LQk3BjcGC1DaQ8KOATINRa9chZDISDWSH8MgWFG/bZLMj
 vyyW4H2I8iitUbvb2PrxdcTIQuk3qu/XJYIiOInIArllp6kB0mUh+t4X0dX6ldstjbW1J7XtD
 d6XTzxdQFM3TRHMgahBKrSbTl1LKEGnQpKgGceNTQe5ZY4kWOWNNDty6JXQajIpaAAnxyHbb0
 YrfvqBICuixaAsID0sCgN2QUMMN4yoLteKdze65I2h6ebmtqA+gm+IlhliTdTyeQVERXJTjw+
 IMf72OAxbw7e/nkm40xvtio+Y9ny4sMM75yZaa9/QADCKX2NWK6CP5lLngUTtygRYI/pe1149
 Kwh8KlNgagfB5j8fsDmk2vRMJhChar/sstCc8bmrVz8K8KLFl5Xh+pMjSOC7JgyxpiDTC4iJ+
 xdCdOwEL+Zr0Uv4mkwBP10VGRn9tf+iJkFS8yc7jl4K80b5bz6HezpsGIXVq6LhsqbH7rEzrq
 vKF4exPZXcXdyLxa641aMbsipJloQjJ/rE8fhYzRAhJoLsneLtMCI/vFAgdVvzMvbN6ny6WRq
 H3uelxFqOX+/uwPEe/egPUyry/CTLw2JJh7tSAVGXmHlf2AHHLkU2zFhNytatIdFdr8Sf4C3R
 kZPTuXgLgpGaPq9LzwSDeVT6ys5uS6f1l6e1Etvj0KOHS7AyhDOvskbBieo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_070712_121583_A9668A32 
X-CRM114-Status: UNSURE (   9.19  )
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
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

Am 25.01.19 um 12:34 schrieb Martin Kepplinger:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off.

could you please explain in the commit log why or for which board this
is necessary?

Thanks
Stefan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
