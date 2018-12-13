Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19928C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D7D20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PFxYF9qh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=obedovekarty.cz header.i=@obedovekarty.cz header.b="nFcTqQzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D7D20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=obedovekarty.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ynBYTf89iiqy7kMMWnkJkPz9Meml6QPugDwopERqDXQ=; b=PFxYF9qh0ubkRE
	6VvkMv+O5AKrqj2eoAmdcNWq1kfaMug7Y3bnsaC3tASicU0A2h2V9xvvqb9gZdwNfPwWnHx7unCPF
	HX3y8T0oJlp9+gg3WIuh9UsjR9lxQ8a44OCDkVEqs0FQz8vJCh90LlMWgiXNF1GfjwtoBdPjrfJNp
	5c4qrFwoQMi46OHovMETqjXaRY1uU3JYfXnKONPmoETFEPNRw2b3Cjujq0pSJcjpynupiXGesF/PZ
	WRESePiexDh9obxOHvcaY2hMyZDPPW1gDCHgBBPHIak/jpCcJoKiwHlDFxmrsfCkBJaGE44yvmYOf
	lWEWxIt3Dcyzmshhob7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOEi-0001Xs-C9; Thu, 13 Dec 2018 10:28:56 +0000
Received: from mail.obedovekarty.cz ([80.211.117.20] helo=obedovekarty.cz)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOES-0001OT-Dk
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:28:41 +0000
Received: by obedovekarty.cz (Postfix, from userid 1001)
 id 6F242A1E2D; Thu, 13 Dec 2018 11:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=obedovekarty.cz;
 s=mail; t=1544696894;
 bh=822ojLk6h/MkFxb8+YPAYVUe1WwhtFrfU7Kbyqp8va0=;
 h=Date:From:To:Subject:From;
 b=nFcTqQzpnkJPseDNikuNdEhGe56RfX8roDJ7EUHlv85BD/dl6qk2ep3j6dtfnMMOY
 FRdlfgbte/HM8b+0V0VW4+FEC5bhQhFPlKGqTulA7SPKBKCYvnED9z7/jphAR3CiEo
 T8KgoDntGR9gOWvplNE0Tkc/wT8rCpWhQbHBNNGY=
Received: by mail.obedovekarty.cz for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:22:30 GMT
Message-ID: <20181213112119-0.1.1r.9ct9.0.gqn1byj586@obedovekarty.cz>
Date: Thu, 13 Dec 2018 10:22:30 GMT
From: "Martin Kaspar" <martin.kaspar@obedovekarty.cz>
To: <linux-arm-kernel@lists.infradead.org>
Subject: =?UTF-8?Q?Ob=C4=9Bdov=C3=A9_karty?=
X-Mailer: mail.obedovekarty.cz
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_022840_654145_49AD570A 
X-CRM114-Status: UNSURE (   3.11  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG9icsO9IGRlbiwKIAptb2Rlcm7DrSBwxZnDrXNwxJt2ZWsgbmEgc3RyYXZvdsOhbsOtIHYgcG9k
b2LEmyBvYsSbZG92w6kga2FydHksIGt0ZXJvdSBsemUgcG91xb7DrXQgdmUgdsOtY2UgbmXFviAx
NSAwMDAgcmVzdGF1cmFjw61jaCBhIGdhc3Ryb25vbWlja8O9Y2ggemHFmcOtemVuw60gcG8gY2Vs
w6kgemVtaSwgamUgbsOhc3Ryb2osIGt0ZXLDvSBWw6FtIHBvbcWvxb5lIHBvc2t5dG5vdXQgc3bD
vW0gemFtxJtzdG5hbmPFr20gbmVqxb7DoWRhbsSbasWhw60gYmVuZWZpdCB2IMSMUi4KClbDvXpr
dW0gU3bEm3RvdsOpIHpkcmF2b3RuaWNrw6kgb3JnYW5pemFjZSBXSE8gbmF6bmHEjXVqZSwgxb5l
IHphbcSbc3RuYW5lYywga3RlcsO9IGRvc3TDoXbDoSAgb2Qgc3bDqWhvIHphbcSbc3RuYXZhdGVs
ZSBwxZnDrXNwxJt2ZWsgbmEgasOtZGxvLCBqZSBlZmVrdGl2bsSbasWhw60gbyAyMCAlIGEgcG/E
jWV0IGFic2VuY8OtIGtsZXPDoSBvIDI3ICUuCgpWw71ixJtyZW0gbmHFoWljaCBvYsSbZG92w71j
aCBrYXJldCBqYWtvIGZvcm15IHbDvWhvZCB6YW3Em3N0bmF2YXRlbCB6w61za8OhIG5lamVuIHBy
b2R1a3Rpdm7Em2rFocOtIGEgayBwcsOhY2kgdsOtY2UgbW90aXZvdmFuw6kgemFtxJtzdG5hbmNl
LCBhbGUgdGFrw6kgZmluYW7EjW7DrSB2w71ob2R5LCBwcm90b8W+ZSBob2Rub3RhIHByb3N0xZll
ZGvFryBuYSBrYXJ0xJsgem5hbWVuw6Egw7pzcG9ydSAzNCAlIHDFmWkgb2R2b2RlY2ggbmEgc29j
acOhbG7DrW0gYSB6ZHJhdm90bsOtbSBwb2ppxaF0xJtuw60gemFtxJtzdG5hbmNlIGEgbmEgZGFu
aSB6IHDFmcOtam11LiBOYXbDrWMgamUgcMWZw61zcMSbdmVrIG5hIG9ixJtkb3ZvdSBrYXJ0dSB6
YW3Em3N0bmFuY2kgbyA0OCAlIHbDvWhvZG7Em2rFocOtIG5lxb4gcMWZw61zcMSbdmVrIGRvIG16
ZHkuCiAKTW9obGkgYnljaCBWw6FtIHBvc2t5dG5vdXQgdsOtY2UgaW5mb3JtYWPDrSBvIG5hxaHD
rSBvYsSbZG92w6kga2FydMSbPwoKCk1hcnRpbiBLYXNwYXIKUHJvamVjdCBNYW5hZ2VyIAp3d3cu
b2JlZG92ZWthcnR5LmN6CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
