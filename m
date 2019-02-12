Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07517C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6192214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PE7AS/AY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Jz4lgr6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6192214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:Reply-To
	:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Date:Message-ID:Subject:From:To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9C1cCvfbO/5hwMR3rU0u5rQ5/+7u6SMm8oera/3muWM=; b=PE7AS/AY3kpeDjNa9J2JCyojIC
	faCjSEADaiWBw79/5pFTP9j06F0djd0C+nI+mNKENrCoHdRCBN3+1sqSWG49DA4YncaeeXVjzXMNi
	hJ7xVXhhRUOuI7QaUR+rYSam4cHuYq2Iht5z0mQgdiU5xyKAmhmQum7X9m5gliNNHkzK7RSuV0SO5
	t9u85z6elfwrOdsFKJF4ebyGzAk1R79BldeUsUpIAAMiUx5tldcC6Ifo/bohMyyY4uGBt/pjFYhi6
	mQfkoCgxJyMkJRbgvv5/2Z9Ii+n8LAWi07fMKGmxVUW+Yrvg4/STW2cFBkkXaZQeDLHaWQiPB/Ebp
	urfue6bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXpY-0007Mg-76; Tue, 12 Feb 2019 13:10:32 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXpS-0007MF-Sg
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 13:10:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id c8so2629076wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=reply-to:to:cc:from:subject:openpgp:autocrypt:message-id:date
 :user-agent:mime-version;
 bh=nByHTb6PTNbIcIi38eXqrVvvuOIl7/ahR+SwIrCbWC8=;
 b=Jz4lgr6oCbOztyWSNqmlbnXeukJqNqpEtBHNEYk+UslY14BTftas3F/ktufQ3Q35Av
 nzcfhwsPPlBbppl4d6YPcRlQd0bceQIm4b15v2yScJ6krArH23J/lNXmGK3EAFMO0qdW
 RFMlWjTclVWnsIWn14wY7HD8aNWMACTMmHADu1NTVE4HrVQXUAh1WWSqc7u0UdxFFJSE
 2SJkdmHPRrrWjHXFJU567DPK6oRSbAUBBVcwvoWB2VZIEqbIxzfotMGlmyZMaE1AwcEq
 akhD8tKM2VcwS6nnTBLHhSBehebR/nriACJj496wXmRfGXwyoMBgd90PYpvONhbjGfAI
 bcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:to:cc:from:subject:openpgp:autocrypt
 :message-id:date:user-agent:mime-version;
 bh=nByHTb6PTNbIcIi38eXqrVvvuOIl7/ahR+SwIrCbWC8=;
 b=GEd0OKQ2SmgVvGLGIl1fqOocFGjDslHLObhY5yMZulAX95wbLshi78C9+LnhBPL9xl
 hjnLq5hMafgkSmuxPnLH6aBBzgAVPz2t0aor9eJFWAQgd9ZnnMOhgPiqkdBeEeBDMlPu
 5diOTmRwKLXjeCwzSC7ADS3AcM304/3oco45w0xWS8tCV8iFjFTeZ/lD+5jWDMXKatJp
 kEELRbI/3PLQyYiL0kJRKfCWfVyyVYbzCLTBctQeBRTKIga3tV6SK+XHYQcQKcF1W26N
 90DvnUEhpO14Yj2PCcL6vPrT1yYx6H9cUkj8M9uD5h4aVkuMcpdjCx4H9Wbjr4ASyxt9
 5BAA==
X-Gm-Message-State: AHQUAuY6Dhp6WYoyq++MWaMsosvTkECokNTUOT8jgEnRoNRmVnWSd/Fv
 cSIY9f7FGWS1nNuuB2LvcOB1OcVflVpylg==
X-Google-Smtp-Source: AHgI3Iaz0gJnTk+Fbf7cg2tN//KpocpKtw7YEKTV9i5h+R4Mc7cyvuikYEHKLw4oMGkr3R3CjLTKDA==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr3080210wrj.320.1549977024969; 
 Tue, 12 Feb 2019 05:10:24 -0800 (PST)
Received: from [173.194.76.109] ([149.199.62.130])
 by smtp.gmail.com with ESMTPSA id z18sm6619192wml.36.2019.02.12.05.10.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 05:10:24 -0800 (PST)
To: arm-soc <arm@kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arm64: dts: Xilinx ZynqMP SoC changes for v5.1
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 mQINBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABtB9NaWNoYWwgU2lt
 ZWsgPG1vbnN0ckBtb25zdHIuZXU+iQJBBBMBAgArAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIe
 AQIXgAIZAQUCWq+GEgUJDuRkWQAKCRA3fH8h/j0fkW9/D/9IBoykgOWah2BakL43PoHAyEKb
 Wt3QxWZSgQjeV3pBys08uQDxByChT1ZW3wsb30GIQSTlzQ7juacoUosje1ygaLHR4xoFMAT9
 L6F4YzZaPwW6aLI8pUJad63r50sWiGDN/UlhvPrHa3tinhReTEgSCoPCFg3TjjT4nI/NSxUS
 5DAbL9qpJyr+dZNDUNX/WnPSqMc4q5R1JqVUxw2xuKPtH0KI2YMoMZ4BC+qfIM+hz+FTQAzk
 nAfA0/fbNi0gi4050wjouDJIN+EEtgqEewqXPxkJcFd3XHZAXcR7f5Q1oEm1fH3ecyiMJ3ye
 Paim7npOoIB5+wL24BQ7IrMn3NLeFLdFMYZQDSBIUMe4NNyTfvrHPiwZzg2+9Z+OHvR9hv+r
 +u/iQ5t5IJrnZQIHm4zEsW5TD7HaWLDx6Uq/DPUf2NjzKk8lPb1jgWbCUZ0ccecESwpgMg35
 jRxodat/+RkFYBqj7dpxQ91T37RyYgSqKV9EhkIL6F7Whrt9o1cFxhlmTL86hlflPuSs+/Em
 XwYVS+bO454yo7ksc54S+mKhyDQaBpLZBSh/soJTxB/nCOeJUji6HQBGXdWTPbnci1fnUhF0
 iRNmR5lfyrLYKp3CWUrpKmjbfePnUfQS+njvNjQG+gds5qnIk2glCvDsuAM1YXlM5mm5Yh+v
 z47oYKzXe7kCDQRRbrwxARAAl6ol+YeCANN3yTsIfvNmkFnh1QBA6Yw8yuYUkiWQxOeSj/G6
 9RWa4K470PTGu7YUrtZm6/snXiKqDtf4jH2QPgwz6b6OpLHI3qddWzYVWtCaR4cJzHxzU0hw
 zKvTly/WWaZLv/jl7WqSEsyB99+qeGVFAeWrGnfFMe9IOIJiPdni1gcxRXZckeINVYrOddTZ
 +PNZbAzvS2YSslnpW4n+xSir+KdxUT0mwbxIIe9VdzQwj5SSaIh4mGkvCDd7mrFf0tfnMVW8
 M9lnFBGQqXh3GNqrEABKqeBjOzxdhuoLcyDgVDJO345LtZs5ceMz+7o/OyxiUzgMUFCdRx5c
 dy4vsbtqBfVb9dNf37ApqbQAFDKOyoiYDy7vE7D9ZooKDqEmxlDEdI0KVHChdi9o2jVUurqX
 bzY20ZhaIytsugPwXOlgCobXb/P3tP2W8olQO/xDeaYWdRroDCcTixydXqsOw0OQh3EkOWzs
 dGI5oYOD0+qW1t5gdcPgpQJ8YQG8jLHwZ18b73I1iD5wVZQdmdGB/4IszA3TNEmvxyM/quyU
 e15Bi+DGHgDNeZuju4ZAiXKBVeyzM5DSpDogmdxNCWA7DF75od0uBFVgBvm7gPvW3hJQplw3
 FzyOD4pzD6qcJizXBIT1TEH7wGEakKdn4Nb0xMiufDLPtGvS9ZOTL72xYPUAEQEAAYkCJQQY
 AQIADwIbDAUCWq+GZQUJDuRksQAKCRA3fH8h/j0fkfg6EACjlUQpjvO/rOASSebpxdxoBEcY
 ffebTPWHC2OMt9XIuVrNqsPVUnv1GQqCq0AtR3Sf9PULCb40yn3b0iwE+kLlCXcWWBBCy88v
 pKzYGeCGgOvjAdWr7SWxo8hEpxBQ44EqoppqB8bYvnNKvfCuX2UBnlhlNCYjiELJVpGn7H3+
 Xd2Zr0brzNjl/DVpi6qmpKlXr7npAalv7hYMxRvQD+j5ee1H/89+cOyHUofjwAZ9t0pIwjzc
 gl3dX43sVVHYFZTWtnwIUMUC5aPfvi2jwqKcLsGwmdCXHtzULPEHoe33c298tozJG2qBzti+
 DZ8rI7/5fNg84cDBM8zjGuU6YIpk0jjOQ+V5V5ees+7JprwswaqMDnaA2xDmDetSSGnrUbDu
 DzeuMMNmzm+BntDbHcJ0fSYutA/Da71Anwrw5WdcW2Iq3xAvcVq6RsIohw/eiAJxMcne3vmb
 j6nAfnQwzXJB0WCq0vE+CuCfdTt9RVL3Hgw/I7nskMU84bihrQ5lfJ2VU/vCucl2LebwOeWP
 HIic/FvF0oY3lecyr+v1jvS5FXJ6rCn3uwotd30azG5pKDtAkpRqW283+LueDVQ5P/Gwp5V1
 9e6oMggSVn53IRVPB4MzTXVm/Q03c5YXPqgP4bPIF624HAPRnUxCWY1yrZuE4zNPG5dfY0PN
 RmzhqoTJlLkBogRRb3+lEQQAsBOQdv8t1nkdEdIXWuD6NPpFewqhTpoFrxUtLnyTb6B+gQ1+
 /nXPT570UwNw58cXr3/HrDml3e3Iov9+SI771jZj9+wYoZiO2qop9xp0QyDNHMucNXiy265e
 OAPA0r2eEAfxZCi8i5D9v9EdKsoQ9jbII8HVnis1Qu4rpuZVjW8AoJ6xN76kn8yT225eRVly
 PnX9vTqjBACUlfoU6cvse3YMCsJuBnBenGYdxczU4WmNkiZ6R0MVYIeh9X0LqqbSPi0gF5/x
 D4azPL01d7tbxmJpwft3FO9gpvDqq6n5l+XHtSfzP7Wgooo2rkuRJBntMCwZdymPwMChiZgh
 kN/sEvsNnZcWyhw2dCcUekV/eu1CGq8+71bSFgP/WPaXAwXfYi541g8rLwBrgohJTE0AYbQD
 q5GNF6sDG/rNQeDMFmr05H+XEbV24zeHABrFpzWKSfVy3+J/hE5eWt9Nf4dyto/S55cS9qGB
 caiED4NXQouDXaSwcZ8hrT34xrf5PqEAW+3bn00RYPFNKzXRwZGQKRDte8aCds+GHueJAm0E
 GAECAA8CGwIFAlqvhnkFCQ7joU8AUkcgBBkRAgAGBQJRb3+lAAoJEMpJZcspSgwhPOoAn10O
 zjWCg+imNm7YC7vNxZF68o/2AKCM2Q17szEL0542e6nrM15MXS6n+QkQN3x/If49H5HEYw/9
 Httigv2cYu0Q6jlftJ1zUAHadoqwChliMgsbJIQYvRpUYchv+11ZAjcWMlmW/QsS0arrkpA3
 RnXpWg3/Y0kbm9dgqX3edGlBvPsw3gY4HohkwptSTE/h3UHS0hQivelmf4+qUTJZzGuE8TUN
 obSIZOvB4meYv8z1CLy0EVsLIKrzC9N05gr+NP/6u2x0dw0WeLmVEZyTStExbYNiWSpp+SGh
 MTyqDR/lExaRHDCVaveuKRFHBnVf9M5m2O0oFlZefzG5okU3lAvEioNCd2MJQaFNrNn0b0zl
 SjbdfFQoc3m6e6bLtBPfgiA7jLuf5MdngdWaWGti9rfhVL/8FOjyG19agBKcnACYj3a3WCJS
 oi6fQuNboKdTATDMfk9P4lgL94FD/Y769RtIvMHDi6FInfAYJVS7L+BgwTHu6wlkGtO9ZWJj
 ktVy3CyxR0dycPwFPEwiRauKItv/AaYxf6hb5UKAPSE9kHGI4H1bK2R2k77gR2hR1jkooZxZ
 UjICk2bNosqJ4Hidew1mjR0rwTq05m7Z8e8Q0FEQNwuw/GrvSKfKmJ+xpv0rQHLj32/OAvfH
 L+sE5yV0kx0ZMMbEOl8LICs/PyNpx6SXnigRPNIUJH7Xd7LXQfRbSCb3BNRYpbey+zWqY2Wu
 LHR1TS1UI9Qzj0+nOrVqrbV48K4Y78sajt65Ay4EUW69uBEIANCnLvoML+2NNnhly/RTGdgY
 CMzPMiFQ1X/ldfwQj1hIDfalwg8/ix2il+PJK896cBVP3/Fahi/qEENj+AFr8RbLo6vr8fXg
 x2kXzMdm6GUo+lbuehCEl/+GjdlosxW4Ml6B2F8TtbidI+1ce+sxa32t1+6Z/vUZ45sVqQr7
 O6eQ2aDbaQGRlMBRykZqeWW0ssGhoS3XtCC2pCbQ08Z+0LwGsvoRAIE9xzCrC2VhVsXdG99w
 FaltMl88vcNCoJaUgNI5ko5Z27YqDncQiaPcxSbJj+3cMsKTZRacx/Tk+hc5eOQ1l8ewGU4t
 NLfkyDlQl+qgc9VuYtXZwjUyNJ8FMv8BAJZHkQDIpzfwxyVbEN0y8QDkGYxRv2y+1ePwZxqS
 Nl0dCADM+Xp5RWOCCUqNKtttcNfWrzkhMSlOWWuQrxtfxLngMuRPnJocPdTdoCKGLUCq54d+
 Haa0IM08EunwYrrkThvV4QsWwxntHpSm3KYwS6xIObiH89Tfj5zN5JmgP/Hu6eXpbR5UScgR
 Tob2CgDukj1aHFx/M+u3iux2/pVPM8vF3DNT8P2/KXe5lz6CZNHqYRHlUAE7dFowhHamZEzM
 FO5FK5xp6C1RDSARi9Mg7vZGcqdLS7kvBQlu0NLNw6fNK/vLZFyp9ngh41xve1p1XlHkOoxV
 MHws3wBaSAJZnTINP9UC4Frwbwl1bWiza0Re//ve11SnP3u9WMzHCRuaEmsMCADCgPwbsg6Y
 ++MqTj5gF7cy+X/sC2yoi2D1bOp9qzApnJMzrd6lKfnodvp6NfE1wEG9wyMAmTDFjgHxk72g
 skymTvd5UreSjnBUqF6IxgRWuyhqU4jyx0qdCG40KC6SwWVReBbHaqW3j2jRx8lt5AnS36Ki
 g000JD0An7909M3Q7brP23MVTfDdPOuAQ/ChjmNYgzmfODd0F186fDpnrMPHxLWMT8XdhIqc
 1X28fQpRE8JFZsH9bWXoaRKocAF8BMMtzTFEIskFaSuqm6UeUD4/0aUvHmaKfjfGXNjRwxqn
 BuRLy09ed4VZ3CgzAuH5B5yZ8U6s1r0tmukyWdFeDmAsiQKFBBgBAgAPAhsCBQJar4aCBQkO
 5GNHAGpfIAQZEQgABgUCUW69uAAKCRALFwZ7/yqG3XbsAP9Fw6fg1SLY9xyszHJ2b5wY/LYu
 eBGqL7/LnXN7j0ov0QD+I9ThUwZBY1yPv3DUpbtVchCPmE8BiUcPxlAmhNlyBmYJEDd8fyH+
 PR+RtCwP/RiiOd4ycB+d9xfVSI7ixtWCiYVZjYGoCfodyUEm/KLXy/xZpRoQZrgaHGXBQ07d
 XBsWQtFunQ5k9oyWzfntmlgw7OS2fEFyx7k973cvzTpgIodErrwoZaH3gj9NsflTP4Wmm2qj
 riCRyjPVZfi9Ub4TN/P+YkDgIAGsWns1PsvyLvsc4OOOHO7cNbNs0AmNIihAm52IRpmkuFpj
 87GgTV/ZB/kVtKEKjyhvK9JlApnULIWme6WobNHUpHmIhM7t2KLly7chJ5at6RrfTr9Adasm
 CO6Xn1wIXuMfyojv+ULAaZWFRL+CJjDuzdWLzgSTlMquOX3NkCCV2unW+As7Tld3H00CoCJB
 5WOlgSQVIdBK8lLEPJGJ8hT1lGS7p5/j1PBs+6i0yu9PTXgbidWIFgjBB9Wj9S2zwFRKoHaX
 wQsNt9G6u8axwNqFb9UXIw+LZ0gL/cUAFouTtulm2LTGdrUNk6UhMBrM5ABqJG9fyMvZVX3P
 EwIAdQuPb2h1QLk5KnknUNikjdIZa9yRC5OnUDwV3ffG4Gsb+xtEL7eTLlbFPgBRUmvy6QbE
 9GjRSSvlab6Mj5tocPBA0CSsonfLCiHlOLvjdMsdmX5NDUpDCo5QMSNEfHEmV3p+A/NOQ/Hk
 Qg41tpHgK85MlNXw6MBWLgdXBSGdD0zVX4S4Gz+vwyY1
Message-ID: <9c5f9835-d9ad-a168-7e3f-b71fd6cfda29@monstr.eu>
Date: Tue, 12 Feb 2019 14:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_051026_934656_905BA6CC 
X-CRM114-Status: GOOD (  18.04  )
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
Reply-To: monstr@monstr.eu
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 p.zabel@pengutronix.de, linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1430445775622344989=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1430445775622344989==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ffzzJxiOln4slO9nzolnra0G70N2Lhg6j"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ffzzJxiOln4slO9nzolnra0G70N2Lhg6j
Content-Type: multipart/mixed; boundary="RHhhXeOU7m4w6ISJIqXj1WVtYu75vAVe0";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: arm-soc <arm@kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, p.zabel@pengutronix.de
Message-ID: <9c5f9835-d9ad-a168-7e3f-b71fd6cfda29@monstr.eu>
Subject: [GIT PULL] arm64: dts: Xilinx ZynqMP SoC changes for v5.1

--RHhhXeOU7m4w6ISJIqXj1WVtYu75vAVe0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull these patches to your tree. There are two drivers related to
power domain and power management. And there are another two nvmem and
reset drivers which are also the part of this request as were agreed
with nvmem and reset maintainers.

Thanks,
Michal

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee50=
0c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v5.1

for you to fetch changes up to e23d9c6d0d4912fab12cd2d56070b0a8199772f0:

  drivers: soc: xilinx: Add ZynqMP power domain driver (2019-02-12
13:38:16 +0100)

----------------------------------------------------------------
arm64: zynqmp: SoC changes for v5.1

- Extend firmware interface with reset, nvmem,
  power management and power domain support

- Add reset, nvmem driver, power management and
  power domain drivers
-

----------------------------------------------------------------
Jolly Shah (2):
      firmware: xilinx: Implement ZynqMP power management APIs
      drivers: soc: xilinx: Add ZynqMP power domain driver

Nava kishore Manne (6):
      firmware: xilinx: Add reset API's
      dt-bindings: reset: Add bindings for ZynqMP reset driver
      reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
controller.
      firmware: xilinx: Add zynqmp_pm_get_chipid() API
      dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
      nvmem: zynqmp: Added zynqmp nvmem firmware driver

Rajan Vaja (4):
      dt-bindings: soc: Add ZynqMP PM bindings
      drivers: soc: xilinx: Add ZynqMP PM driver
      dt-bindings: power: Add ZynqMP power domain bindings
      firmware: xilinx: Add APIs to control node status/power

 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt       |
46 ++++++++++++++++++++
 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt |
25 +++++++++++
 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt       |
34 +++++++++++++++
 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt       |
52 +++++++++++++++++++++++
 drivers/firmware/xilinx/Kconfig                                     |   =
1 +
 drivers/firmware/xilinx/zynqmp.c                                    |
166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 drivers/nvmem/Kconfig                                               |
10 +++++
 drivers/nvmem/Makefile                                              |   =
2 +
 drivers/nvmem/zynqmp_nvmem.c                                        |
86 +++++++++++++++++++++++++++++++++++++
 drivers/reset/Makefile                                              |   =
1 +
 drivers/reset/reset-zynqmp.c                                        |
114 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/xilinx/Kconfig                                          |
20 +++++++++
 drivers/soc/xilinx/Makefile                                         |   =
2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c                              |
321
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/xilinx/zynqmp_power.c                                   |
178
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 include/dt-bindings/power/xlnx-zynqmp-power.h                       |
39 +++++++++++++++++
 include/dt-bindings/reset/xlnx-zynqmp-resets.h                      |
130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h                                |
184
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 18 files changed, 1411 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644
Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644
Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644
Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c
 create mode 100644 drivers/reset/reset-zynqmp.c
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--RHhhXeOU7m4w6ISJIqXj1WVtYu75vAVe0--

--ffzzJxiOln4slO9nzolnra0G70N2Lhg6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlxixbsACgkQykllyylKDCGXrACfU2X2BXVZkyvUl/xvBq4zSXAY
mUMAn34bmKTp7w4FS6VxVy1agUpjo5nF
=IgGC
-----END PGP SIGNATURE-----

--ffzzJxiOln4slO9nzolnra0G70N2Lhg6j--


--===============1430445775622344989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1430445775622344989==--

