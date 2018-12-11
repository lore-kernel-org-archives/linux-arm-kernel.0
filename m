Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80552082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dgi33l+r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLkkBYiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80552082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eX/WEou8pNPwmh81EvOKDRzIwAKZEAM3niecAJmSF10=; b=dgi33l+rjw/aIS
	jXZdjWDCLY0ifsOgHBNsjaf/DdNtr1e4QtObsJmzMfjfJEzrgd2KmEORTuoG/yIBmlWaFV0YkSIEL
	DK06RtqSEXPCUgfdtM73kpV1rAmB5iJMAV5+M7p/Xcm3PkP/JDKMBbzHVmbu4MvkCVpjrvC7tQIBb
	fScgToqLIJSrKPUEtrTgGuxvuofGViBwqcqr+41c7Vpz2Il6oRjZX1igt34bvZfUWvhtlrQnBkGmK
	Orr4XYY9oTditMpbms1aoTXn+wvRuGMjI5TOZPicLsa9n7oJaZCeqrDda+P3E/6BFYYBlHIA0NDIk
	bkDk+IEkeXcqcTahcD8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWe4f-0003fR-Jj; Tue, 11 Dec 2018 09:11:29 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWe4b-0003eS-RS
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:11:27 +0000
Received: by mail-ed1-x544.google.com with SMTP id x30so11893121edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7onlj4xwr4CnEsWIxH12oN83HoaCOj6sqV711Y5tgQ=;
 b=cLkkBYiTbvb3ytQJRAXAx8f/WcIia8wW+HVYJqSF4uyEQLKDB17yDjlWt3c4E9j/OC
 I1xoDKutkfkgfK39K1YJbJDNBu8hV5HTvgsxNZaEI3JqHXvOUXcN0K0l8pWQQgZhVD8k
 t1TudpVCdWjeH3mI20gY2h+W1de3hl8b3nZLs7CL/ItllUhmGBwHnhDY0vbPQlVHGFDT
 liW+U4SLb/hW8e+LOMlOFJFBQuWFCr/cbyS8cQx2Nl0OcUWWDWdLOgbqBVNsdB4jK/mw
 +WZb2CbRUcvv3UmQBjlPWRcXSWgWERx3F77IDc/VUs5jWOsGHOvAugaTUdFHO2iUO1JC
 D6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7onlj4xwr4CnEsWIxH12oN83HoaCOj6sqV711Y5tgQ=;
 b=Pg+9YQGpc08V3yOtmi+R2vTOpilQ8uRYhU6RGqZhFhdKkkdlyk5bDfEOm3HmjdISq9
 JVXQimtKs2LHm2/oFJLb0MD1wpG5lDWexYT9NwWo2BcbmCfmEXylGAyYqd3OipuozR/Y
 JbOD7oeFb+AOlmf1KqCLd1JJ5NhsHKNFTGZpe3jpGp56Yq03HoKomdmgQOsAI5PYfDOQ
 i4EAwFJ7ffHpu3n3KX1p7I/gztWAw18Lcb8duuzEZh+6v8QyN4KqKxUgeL7ck7A0sVJQ
 XHBWbj2wIkyxePrfHhAVLbX/g/AGDbmJbj0uElIx57f7tnA+Wsm0O6VAXcPT2YcLczj/
 QuQw==
X-Gm-Message-State: AA+aEWY2GKzBpYAED6dUOdQ9CZWxo0V9PQe8C7be6r4N+ec9luSJG8Yh
 IjcqnSaWIG1Dy1fvWEpJ4XobjkHv1vLBkRM50P+EAMq+Fg0=
X-Google-Smtp-Source: AFSGD/X/qCWYrcZlH8HWh61yRdIibZYW9oLlXA7A835s/BO9O9KtCD2u2UF2hYTsdgMw9axfDVfb2VTkjQBcZ3Z//uo=
X-Received: by 2002:a17:906:1001:: with SMTP id
 1-v6mr11851731ejm.91.1544519473798; 
 Tue, 11 Dec 2018 01:11:13 -0800 (PST)
MIME-Version: 1.0
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
 <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
In-Reply-To: <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
From: Lei Wen <adrian.wenl@gmail.com>
Date: Tue, 11 Dec 2018 17:11:02 +0800
Message-ID: <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
Subject: Re: Coresight etmv4 enable over 32bit kernel
To: mathieu.poirier@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_011125_910940_C4FC06C2 
X-CRM114-Status: GOOD (  22.38  )
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
Cc: leiwen@outlook.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 2:02 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good day Adrian,
>
> On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
> >
> > Hi Mathieu,
> >
> > I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> > And I am following [1] to do experiment regarding the addr_range feature.
>
> That wiki is very old and after reading it again I seriously consider
> removing it.  It is still accurate but there are better ways to do
> things now, i.e perf.  The main openCSD documentation page [2]
> contains everything you need to know about the integration with perf.
>
> [2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
>
> > The default addr_range is set as _stext~_etext, and it works fine with
> > etb as sink,
> > and etm as source. I could see there are valid kernel addresses using OpenCSD.
>
> I'm really curious about how you use openCSD to validate your traces -
> can you  expand more on that?


I just manually replace the cstrace.bin in the
decoder/tests/snapshots/juno-ret-stck/.
And modify the register data according to my platform.
Then produce the decode result by below command:
./decoder/tests/bin/builddir/trc_pkt_lister -ss_dir
decoder/tests/snapshots/test -decode -logfilename 2.ppl

>
> I think the results are misleading you since the openCSD library can't
> readily be used to decode sysfs trace sessions.  The wiki doesn't
> mention using openCSD to decode traces either.  The only integrated
> way to use openCSD to decode CoreSight traces is via perf.  Again, the
> link above will give you all the information you need to do that.

>
> >
> > But while I try to store one small range of address pair, which contain only one
> > kernel function. It doesn't behavior like what said in [1], the write
> > pointer would
> > grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> > openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> > I_NOT_SYNC.
> >
> > So my question is why ETB continue to grow when there is no trigger at all?
> > Is it normal? I could provide more info if you need it.
>
> I am dubious about the validation process and as such can't comment on
> this.  Please share your results using the perf integration and then
> I'll be able to have a better idea of what is going on.

I see... I would try use perf to get more result and get back here.

>
> Taking a step back I am curious about the ETMv4/ETB combination...  Is
> the ETB the only sink you have to work with?  Moreover, are you sure
> it is not a TMC-ETF?  The ETMv4/ETB match seems a little odd to me
> since they belong to two different era of the CoreSight architecture.
> Usually with an ETMv4 we will see a TMC-ETR, which as a lot more
> capabilities.

ETR is supported. I use ETB as it is mentioned in that old wiki page.

Thanks,
Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
