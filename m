Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30F02192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmPa+kcA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mflT7Vmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30F02192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/okVmAEy21i+9z0jsnM0qUHeZ+5Pel0C1SlRiz+AKiQ=; b=qmPa+kcAchOPsG
	tapybekTOwZH3BZotFpAZbwqg8eEiAmW0NnXZd7fuQLTCZnHN9qLYPl9xlWKTD90pK4INskztDpAn
	tJC6OEL/eDghK9RsMCvedZ8cgmabIsGF+xgKLSOUTjlk4nNLw/4lSPzRehPDMa296VfaW96zb3GV5
	4q0zFfeMrbRGx59Q1yeilC1jh+9tlB7S+/9cxsF7lrlbhZVQL+XtDYL48ux3BM2cooqS6W4RjW5OO
	y1ysEGbyNaHXITGov9Up9+JApRfiy3p4qIO4WDnUuSAAIIu9pXTRBXjUkukShBO25G5Kw2QTE+LF6
	h/oclwyCKOV0C4Fmlnuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueBf-0004Hn-2c; Fri, 15 Feb 2019 14:09:55 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueBb-0004H2-Eo
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:09:52 +0000
Received: by mail-it1-x144.google.com with SMTP id r11so24304676itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GdqafAwly330nvNvFHRKL4/uUf3uAJzVgQPB2+4wY8I=;
 b=mflT7Vmu8qwd367UsuMo/5RlFSN/uLTmsD67KO5BAtwB0YBZpgW8PeaCTry9Eom+Tk
 tXv6xwmStRku6+BRg0o/oHvASQLGMa1ftbhd1X+6s/gA1GcQR2XscX4E2nKCJ5jvtpC6
 HtvwgL5s0UiP1QIMoM9RjBPfym/a0WrUaMpTOI03ycx7uwFnumGJsAc/rhxnuTUCG79q
 zZ0u/WyDjpEYaNEI+KzjSAZKxqJ9c+MATdot7yOVYNxcRLOmzS3y1lmrVG6z4y8GcIMy
 8G2hJusYuvv17tkrrKPy8j4diVlGrEA4N3oOWUkvBnkKEOOfFOqablRW98WObHT7bQdu
 /4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GdqafAwly330nvNvFHRKL4/uUf3uAJzVgQPB2+4wY8I=;
 b=dmYY+2fL/7LOF/Bwg4H7SZ60qtqSLj7xUZKF9YIKJQZtaBjaQ7tJNvGauKgwfJdngi
 2V8FXATcIYTgUplv4FTSTukdcuMbnqFjsbgPhkJEivwPmDXGOJhJrN6KdlZRuJjMOekk
 R9XdqMsgJHP9x0ihOyPpFYsXmLW+4+39JW6svaPzhepmiEsN73ApTQmWzIaIzcdHhqQR
 m1Osw8sD+G9+vvySgGoVVvbLiVB7kNrM897YeIbsiD6FVlRyZLrkfT8DAlU0p6xk+Sh1
 3vuNbA3i96czhWycrGuyz2y5LyjaP1mnLlu8WvYNl5mZpU0cGm28wzOi0IhJ/NSZzyvO
 lDdQ==
X-Gm-Message-State: AHQUAuZloTDTNr7ggLjgY0lnhINhsJEipWZHOi0NsBEy3zExFzhDUPcl
 Lz4PUQt5GVgUP9QrsC6RDrXfeLF8e7LodVb6PtA=
X-Google-Smtp-Source: AHgI3IaUUXlVInY+v6hXxHm/VwGkufEXTBv9ztdlk1qpOnGsETERJdgB0wACvkghr0QX1okvUtw04fRIOu3IX01HqWw=
X-Received: by 2002:a6b:c005:: with SMTP id q5mr5384132iof.225.1550239789338; 
 Fri, 15 Feb 2019 06:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
 <20190215135613.sdz56vtiawqeryi5@flea>
In-Reply-To: <20190215135613.sdz56vtiawqeryi5@flea>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Fri, 15 Feb 2019 22:09:51 +0800
Message-ID: <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_060951_495707_BD90B796 
X-CRM114-Status: GOOD (  16.66  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgOTo1NiBQTSBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlw
YXJkQGJvb3RsaW4uY29tPiB3cm90ZToKPgo+IEhpCj4KPiBPbiBGcmksIEZlYiAxNSwgMjAxOSBh
dCAxMjo1NjowM0FNICswODAwLCBGcmFuayBMZWUgd3JvdGU6Cj4gPiBIb3cgYWJvdXQgdG8gaW1w
bGVtZW50IGEgdGhlcm1hbCBkcml2ZXIgdGhhdCBpcyBub3QgaW50ZWdyYXRlZCB3aXRoCj4gPiBn
cGFkYyDvvJ8KPiA+Cj4gPiBHUEFEQyBvbiBzb2MgaXMgcmFyZWx5IHVzZWQgbm93Lgo+Cj4gWW91
IG1lYW4gR1BBREMgaW4gZ2VuZXJhbCwgb3IgdGhlIGdwYWRjIGRyaXZlciBpbiBwYXJ0aWN1bGFy
Pwo+IE90aGVyd2lzZSwgeWVzLCBoYXZpbmcgYSBkcml2ZXIgZm9yIHRoZSB0aGVybWFsIHNlbnNv
ciBpbiB0aGUgSDYKPiBzb3VuZHMgbGlrZSBhIGdvb2QgcGxhbiBmb3IgdGhlcm1hbCB0aHJvdHRs
aW5nLCBidXQgSSBkb24ndCBzZWUgaXQgYXMKPiBhIGRlcGVuZGVuY3kgZm9yIHRoYXQgd2hvbGUg
c2VyaWVzLgpBdCBwcmVzZW50LCBzdW54aSdzIHRoZXJtYWwgZHJpdmVyIGlzIGludGVncmF0ZWQg
d2l0aCB0aGUgZ3BhZGMgZHJpdmVyLgpJIGhhdmUgYSBpZGVhIHRvIGltcGxlbWVudCB0aGUgdGhl
cm1hbCBkcml2ZXIgYWxvbmUuIEkgaGF2ZW4ndCBzdGFydGVkIHlldCwKYW5kIGl0IG1heSB0YWtl
IGEgd2hpbGUgdG8gZG8gaXQuCgpIb3cgYWJvdXQgdGhlIHBsYW4gdG8gaW1wbGVtZW50IGEgdGhl
cm1hbCBkcml2ZSBhbG9uZSBhbmQgcHV0IGkKdW5kZXIgZHJpdmVycy90aGVybWFsPwoKSW4gYWRk
aXRpb24gdG8gdGhlIGNwdSBkdmZzIG9mIEg2LCBwYXRjaCB2MiBoYXMgYmVlbiBzZW50LgoKVGhh
bmtzLApZYW5ndGFvCj4KPiBNYXhpbWUKPgo+IC0tCj4gTWF4aW1lIFJpcGFyZCwgQm9vdGxpbgo+
IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKPiBodHRwczovL2Jvb3RsaW4u
Y29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
