Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F61C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:51:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C72420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="icv/mJR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ctopjR8MfjrgdagcHYlKXPGwJCxj+hKmqPWHvxZUr4=; b=icv/mJR03k05hD
	ikJOZQ6lZc251BgMRua19S41booB/u0tGBaZIL5iLfABhtvDH8v2ieiaqm2pkBC9q+C6gFTmVn5Ve
	KDKR1J++EdKPlN31hJOTBwrF1fJfGTaALntQhtXTmvapgt5zV+frA0hFEuA69Gb4ZdRQjDjDQwwpQ
	WKt4kEi6zWlhoHtnD5opri0dCjrGtuDeiKHeGVL0A2MBZoQeB/YPrAQN05wIIQTDmoGbwRJC/sDPi
	jq5Hi5vCYvNzwjLGWwuGjRAZytqIPc14ZqYl+1Q/ACCwm3vmz5xhFgfK1HGmo+wFnb+MfhRqfyx3e
	3J3hpzAxHQD+Bi68kNGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUjr-0000LY-3W; Tue, 15 Jan 2019 19:51:07 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUjn-0000Kz-Os
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:51:05 +0000
Received: from oxbsltgw35.schlund.de ([212.227.220.134]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF45G-1gU2Gf1HnU-00FUB6; Tue, 15 Jan 2019 20:50:49 +0100
Date: Tue, 15 Jan 2019 20:50:48 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <884332236.499392.1547581848222@email.ionos.de>
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:+elgm5XkOyevwG1T38e8l8G5/xrYrE/AXpRfEqSejzcD3j/tTTm
 garzisnzmfWhuxI9fmnIaajQLlzVYnxMcO0AY2FF/dKlnZWh9hutuKR7EBAd5hDw9DTCpLn
 fegPCon/vjdIEUSvcermSZENwTiBYEUuxAB5t5NyMAcfz/i33PfK1qt4Y4EkI78xYypQ+H3
 GtqHjWakuhlgJsx6ww4hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3DnGGu1+C4=:2UWRM59ehu+mczGkpaQ3gd
 YHNZRq6Ct/0hKTjTli1v+A8LPw0c30Kh95XHcwWYROUOAmnfsZ2BnZBAxLQvZExdNGs/ie1Me
 njQEdv0/0FKimYnpl038AWAUEmxJzfOp63L2myVPKKCrND208EEkpIYJ0/MRXC7bFpXP74TAb
 UljjRH/QShwgZT9/cUd3uS7T5njU50hWUDbEPGk4eMojWfsgvHDagyI1Vh/JlKO/kOpAgnZKh
 +FT3GtB7Zr1eOxso6VjbakG1jcYEEkl0ojW5qFExKFXmzYm7FfzbgA15xL57BoIdJVUMMdVaZ
 B75tK9ZrLjB5TsqTyEHPOsKGehDDTX0wDXgSbw4PQ4GAv27Mg2F5tLbMrDu9nWbyJqwjjn6Gt
 nwXs+Q3kC1kaqRk+tZkd3DY0jgjH4rEcd9E+FbdE0HyHDjsKz5Ygv8Wz35xlEZlzDrhXPkc2l
 gkHAkxukLR8/SeyFKPv09KCnScMhxLabVS8SdN7fQ2DyD/KgOOMNxnGZn11kaTVfNc6gnK596
 MIBxMPzid1S/+97Da9LyMKeZaaxFuduxvuHzG40m0RmSVEVhyTR/rQbMGr7Uilx9V+E3RuxG3
 fMiUUZ+xgaXEvBP1Lf86N7PFNJNhJ6HN2Z+oPQHD0xfIUS1BMQ6Zthx+CT/p+/XFn7/tLDew1
 l/S+yY8vn8pq37+eliX2oKIdKiAWBjZnr7nFWJtKC/om9m6YetHgNjXIQw2EaX+UbTVF/cCTM
 tI2leT43NDgQMr6FGvf4WP1XNNuV/YVgKadlfOeq/rLQyoJpLhjCXWZDA08=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_115104_114257_4F0F55E7 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: mlangsdo@redhat.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> 
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 

i applied this v3 series and Marc's v2 series.

Now i'm getting the following on a Raspberry Pi 3 B+ :

meltdown:Not affected
spec_store_bypass:Not affected
spectre_v1:Mitigation: __user pointer sanitization

So the entries l1tf and spectre_v2 disappeared.

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
