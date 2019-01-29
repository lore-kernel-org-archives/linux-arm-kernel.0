Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A3C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8AC20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n2ae7g25";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD25cT2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8AC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JplBXcRpuxjNpQDdtBEDB/5y1Pb4RWtW+D8qZWkVpW4=; b=n2ae7g25C6gz/1xWtqaxoeN6s
	1+4BOpicvpE889VF5NQJZZxjieKLdwcy8GWZH6gsyXfuXiM0KccZvKnkSzwMYpUTd2LXxUDsueK4o
	4112wsW0DNCBDvREUvv3b+pkEwhSzhl/vbA4dJAPX1BiILRh6pUMgxz9Svjd1ZsJLvKsY7k6SOzDh
	To3y1I3M9Gv5KBeQxyJ8ltEQRkus/0TS3F991KrO1/eEWq4ILepsh1N3mxSNEwi05UFOf0aDLqYvc
	/YItAfzGULUI+DoXqcWrvWVv7M0su3VzjElv/Pof5GxV1l1nOulqZj60bULfVCK8YY/8xdYLq8qBR
	M6/+J3HLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQds-0003Ki-E8; Tue, 29 Jan 2019 10:29:20 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQdp-0003K9-4i
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:29:18 +0000
Received: by mail-ed1-x542.google.com with SMTP id g22so15525060edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6Fa3Zo12iaIFsHb8qliPtTCYK3OxXEKI06KR5QB5UZs=;
 b=AD25cT2s3mmV58tZ1Eiy+oib0SSv84oLSd3ZoQbWOPRek1hiAhHaXLQf0tZFUiGPeb
 2CVL32rLH7Mcq4vrfLkC1eueoaTtPvqW5CIFo+mKHIh1MZp0w/EUJM2z/tLNwou1mYHa
 9Tw4hSNtQ653Syq5c+hcNU/nOpQsN4KI+lT/74pkoM77iOAfRepjDqn6GUEqVD9c9TrP
 g7fkr8u3kKLC6V6yhupo6MElzzHZcRyymZZtOlDoxPgDR2eVAQ8veMVlt1iAXWMWo3Jv
 UhNQkks8q9uwaCuHXzA0ehi1hpVQ2GbEt/O66bppFyY397hQKLgAZEeYs6g9Q6BQTz3G
 t24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6Fa3Zo12iaIFsHb8qliPtTCYK3OxXEKI06KR5QB5UZs=;
 b=Ana9owMzoPclyuwEIaIpCzAZB2c7KjnFa7UxoEFHukH18uOacnhbJUMwSCJ+oiXGUA
 Ra8ux8oi8UFz8og5/fuUQU+Mt6VrPMq9GqyO5eB0GH7iUc+DWExXkBHgtze/RlUZVOvW
 Uz0spLJ+8CZ1dJ6GJMWSmAr56Y1EUIMJOd+JBPB/sn/ZYVAuY0NG09rNB0yRWsgi6jHj
 yHja0Eq3DYcqFqKAk8kG/PfAFogzSzuhP365IrQejvyjCz2ev/8Y+Irk4p3H5PS6yczk
 EsV1iTn927p2yxZgphbHqvIQcpc6Oj3hZu3qFAccyFF2xx4bxpDtADmUJXqOFuuhLZh9
 mAXg==
X-Gm-Message-State: AJcUukdnMuOH46to4AWLUpXBKviJDLrfiUImyYBLZyb6l0yxBTZFGecd
 jbGj7hrxv7uKobhovzKbw7Y=
X-Google-Smtp-Source: ALg8bN7Q6dNTsaEI9Aq7CX7GTTfJ5oc/GRusg1jlsxkHxUpW9w6PHooq7Ep/V7b24Tc7X7yBCULPfA==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr24517848eds.91.1548757754726; 
 Tue, 29 Jan 2019 02:29:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 97sm14504171edq.45.2019.01.29.02.29.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 02:29:13 -0800 (PST)
Date: Tue, 29 Jan 2019 11:29:12 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190129102912.GC28850@ulmo>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
 <20190128150908.GB31317@ulmo>
 <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_022917_184228_4F212B58 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0697415661981537315=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0697415661981537315==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 10:41:55AM +0200, Peter De Schrijver wrote:
> On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:
>=20
> ...
>=20
> >=20
> > Up to here this is a duplicate of timer-tegra20.c. And a lot of
> > tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
> > we unify the two drivers instead?
> >=20
> > The power cycle restrictions of the architected timer, do they not apply
> > to chips earlier than Tegra210 either? So don't we need all of these
> > additional features on the timer-tegra20.c driver as well? If so that
>=20
> No. Chips prior to Tegra114 do not have an arch timer and the arch timer
> does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
> It's broken on Cortex-A57 though, so we can't use it as a wakeup source
> on Tegra210.

If chips prior to Tegra114 don't have an architected timer, then we
can't remove the timer-tegra20 driver, because we still need it on
Tegra20 and Tegra30, right?

Thierry

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxQKvMACgkQ3SOs138+
s6ESkxAAmPafbK79nW+LhXKQ7nIGVNRT3TZ2CgSuShtFP7bYxtDA2MmTMQu4/VfD
G6v4td8renRj+3RaGbmukoVGeHlp7ILdkUb3+RLf5rJVXe46rvGuoSXwj3t92wNC
UXxLUQNrqpR7C13sCufdjbAoy4xurzf1arsKJLjfmPF0EW5Wfcs8D8+fMkd1ZrHf
NTWeeOQLi+hhvNU2RQSF7OH8pkXpTICbLCdQ3hvSrTJaQ6dcJnLkG6h5I0uYCpr4
MHt9WButS8LHlxEcpXH/THOoFQ0Hk7+yLG+XIEKWwRBojXTN3b5eA39y4U0zqWkZ
P8YyHYP+0fSeUurbP/8MLxKOQHRY8Ost2ONs4KgyenTPF7NkWNq+jHmNAzfkZ8Ta
2D2cSi79xOXb7eSZ1g09o+z3hTzmqqBP5Mj1Y9XjQQaNDmjb9eM08EQJz176awTq
fggDH3rR/BSQ13D93F6ghDFP0yFDbFl8q3NIN6IC9c2jS/GB/xqVS2/dMImW3DL7
gDkIEnI7K2EC3fiUtKK+SGDQLK0c7+QlkZ+fzD86cULLiatvm8TsFwJFW5rxQqKs
ZgIi5FnD/CXugk3QsqFnaZeQvpb4U8l8TLIg4ZAYUGEwiH/KDCU3BEoSGwmro7Zf
5BSPZwp505/YvejxBl7LWrw27SLA0pDbsJNmArubNjrTv4dZKj4=
=tJel
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--


--===============0697415661981537315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0697415661981537315==--

