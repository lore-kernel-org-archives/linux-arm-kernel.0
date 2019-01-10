Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD863C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6B921773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnFZUC41";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="noEj6Brd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6B921773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DQviNArUjjur1k4GGqHNP+/tzOns/OC8wLuqjUZxrAE=; b=jnFZUC41VJyaBn
	EuZqp2pinn3Sj7OJiKU1PiVkz0XfNziNh5ToTNNiWMmrP/WCifbmF9Zb21jUU5UinuNYWzYBrcYEw
	qiPwBYoRzjCM+agMeSHv4Wvh7UwXLwxCsKiD+Ztgubvj+acDSaIa+nwx0SBmJi+QOpyzd7W+U3N/R
	rkp51TfMusF2WChSrJrV5Qdyb0StDGmw7ibHJu1k+oEXAgXLvpkuuD/yEA6HYF1Twasbbw5zKF0aL
	P2GunAGsc4OWD3oZ+H9Vfz8iafaWyx8nOxEQMmQdZzw5zsT4DwSxcqXmmB1Z9I2OsDcFrhn+m/Op/
	axv5MEwZBrlVk+U4eLAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaqP-0001I6-TO; Thu, 10 Jan 2019 13:58:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaqN-0001Ho-03
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:58:00 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82727214DA;
 Thu, 10 Jan 2019 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547128678;
 bh=RpVf3BEE0pPwg3BCjGoRRZ5TTaMuz4TRJBaIlzP9Yaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=noEj6BrdODZBXRPeNAoij3LIJBL9o9S9YP91ikgVpDxjbOOkjaZ32NFqNPnGdifMs
 MTGV7nPliNRpufWmiw/xD9CyTWFzPb1zw+bPb/hA1hp1x2z1CNkXeHXLJVC/y7aXFV
 laQJcstjt8HWpIP+AXJER1AMvLNH6TFQbGwoQ/Zo=
Date: Thu, 10 Jan 2019 21:57:44 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Message-ID: <20190110135742.GC30487@dragon>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
 <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
 <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_055759_059411_F16AF718 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMTI6MTE6NTBQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6Cj4gSHVtbSwgSSB0aG91Z2h0IFNoYXduIGhhZCBhcHBsaWVkIHRvIGhpcyB0cmVlIGFzIHRo
ZXJlIHdlcmUgc29tZSBjb25mbGljdHMuCj4gCj4gU2hhd24sIGRvIHlvdSBuZWVkIG1lIHRvIHJl
c2VuZD8KClNvcnJ5LiAgSSB3YXMgYWN0dWFsbHkgZHJvcHBpbmcgdGhlIGNvbmZsaWN0aW5nIGNo
YW5nZXMgZnJvbSBteSB0cmVlIGFuZApleHBlY3RpbmcgeW91IHNlbmQgdGhlIGpzb24tc2NoZW1h
IHBhdGNoIHZpYSB5b3VyIHRyZWUuICBJIGp1c3QgYXBwbGllZAp5b3VyIHBhdGNoIHRvIG15IHRy
ZWUuCgpAVm9rw6HEjSwKClBsZWFzZSBnZW5lcmF0ZSB5b3VyIHBhdGNoZXMgYWdhaW5zdCBteSBm
b3ItbmV4dCBicmFuY2ggd2l0aCBkdC1iaW5kaW5ncwpiZWluZyBzZXBhcmF0ZSBwYXRjaCBmcm9t
IGR0cyBvbmUuCgpTaGF3bgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
