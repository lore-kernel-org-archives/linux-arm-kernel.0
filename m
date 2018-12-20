Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F79C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184E2218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fL9sl6MH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gm+p8JMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184E2218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LOk/K7DBhj05QWUCSnSYi9AfBaHLrGKLqCPtyjK1rkM=; b=fL9sl6MHS+nVrV
	FTaJBecIK4ejIiLrFXnHXw99MYI29kuXDHU9rPcMg01YVX96FsKGM5JZOcSq0odzUxSP9m2SbyIDT
	pZKwsRaGWAhG3YdG16d2dRh3VLyABKz8HPJ2uXPeIEfe0mv32mKlV9lNUw5XubD9RzhwruY/tJv3m
	lsBrHH475zsb2LC8LP2Rcsf28eWziDdGIDisT3683Ru5XO09Ti/XAp1je9uG8H7V0YAV1b5lDHRwT
	lLERN9dcV7GQRS/+mDrw+PuHuwkjEsKBVcvz4Ze5AirYqltL3dm2usdAQhniy7YGOWY2K/fzoPdDp
	9a/8N1GtRADF0lin0JNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5AQ-0003uy-EE; Thu, 20 Dec 2018 20:43:38 +0000
Received: from mail-eopbgr150041.outbound.protection.outlook.com
 ([40.107.15.41] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5AN-0003ty-3T
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHP7O/I4+A6sns0lUCrcrMAdvGQf+/gTn6E7ZDflJJ0=;
 b=Gm+p8JMRsTHSmkLPM0IiBbeBPDO7eKj5vaBHykAs3bSbic7kCjCPTo5JnbAErxtmvZ31q1O7YmmioTHqqjTIg872Nwco77TppXiK8BJx2FwPDTdDsQwgTleSXnV17XVw2F2Jt0pNhwz23ydgjuNDd3+Q3EJx7xPK3x3tDH1YyLI=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2893.eurprd04.prod.outlook.com (10.175.24.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 20:43:19 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b%3]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 20:43:19 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO"
Thread-Topic: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO"
Thread-Index: AQHUl4RRPIsexLRCcUG5YYldZ+fuVA==
Date: Thu, 20 Dec 2018 20:43:19 +0000
Message-ID: <VI1PR0402MB34856DA189C2B6677967E9CA98BF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <2071995319.127120.1545163830046@email.ionos.de>
 <20181219101844.6362-1-horia.geanta@nxp.com>
 <CAK8P3a3RLdRtY2ND0r4VQ5447V1WLYD6b9NcWjYvYR2AUCV1tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2893;
 6:d46G0XE4WLmdRshT0Sr4AX+9vIYTHA04f+bIC7Zd2MHIUOZw/OC34Iwja5QcbySpcdn///tV1gVfPQOyphQoIDXR2K30FTtie1ActzlKbTdrHd4pvSReBhHpnvrP1yKaIVvHuFJ1vSu2iiUFuj4Lha8RNvTzTBib2BErj8vuIjDueegwHsNb5gyEdkZX5XyQM4vZl0dA12hLchbf9El5ihDAlsdIMg3t/jsaQkXI7JTxFS7BGsSb4nXV6m4nwK6BVhlMzUz3ExZtdRCPTSclRxAjXAvNTiYBBhEjNoPsDt15lpxPyqsKFLAIR80zjk92JmYHOJ3S5bzPGekOoPqkCpDmjahcp7gctfau4yXD982P3nOk9G5N9PNkAz7sX+v+WuqFd3q6oeroQpDaJtDZJhpqdKvWwknVkSUxIxw0HHKekfZGcpxLxPHfXqQvxhK9BCheqh8EFt8yDHz0u7os2w==;
 5:aLoujnkwkwkcTToxfc9iPZsWMEutHti5ThBqKdAj5oby4FhyDYd61UEOWSrC2I9efB4GItecFf88IH9FVZ+o7S4hSsfWTCalDvqtUCZEh0OLBNbltViKnFyEmiuZa1DuF9MeUmE2V/x4rsZgQEAfPjQ1+e31hCsOaCwNaT/Whpo=;
 7:XFz4vJZYbX60Dh64SL7mFhosdQepn45balHt0x5pMbLZp+YyyWpI4Qe53wJVGd++qrn05QeGxyFdJPo6pU1MFQ+AYHOkvBHt5tmhp5WL8jAPJwhDty76pf6jeOd1hOMn9zlDsYZ1jgMEJ0v2chSuIQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 329b5dd1-ed97-4305-751a-08d666bbc6ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2893; 
x-ms-traffictypediagnostic: VI1PR0402MB2893:
x-microsoft-antispam-prvs: <VI1PR0402MB2893ED2E7420F237743B382398BF0@VI1PR0402MB2893.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB2893; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2893; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(5660300001)(66066001)(26005)(229853002)(97736004)(14454004)(2906002)(74316002)(33656002)(44832011)(99286004)(7696005)(6506007)(102836004)(76176011)(53546011)(6116002)(256004)(446003)(3846002)(486006)(186003)(6916009)(476003)(54906003)(55016002)(4326008)(305945005)(68736007)(8676002)(8936002)(81166006)(81156014)(9686003)(53936002)(71190400001)(71200400001)(6246003)(7736002)(478600001)(316002)(6436002)(86362001)(25786009)(105586002)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2893;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +TSp2/BZ7NAHM+fDVPKwhhdgh5nzVW0vFdBihAr+4r24tSCqfxyU8aeFiRhEzSV9iIcYnxNK/mGCWbHE9q6DJlESis0XsDKbLuP1ggsx4NOUtHo+OdzBKXRk7ytY37dLTzR++Bimum7trtZeXptHNmv6g3YwZDIIh4rujhLNOr/xJv/TgSE4L05VDbV6yC04UNTj6pj5qEbbXt7BAd4Y6KSY7IaO4h4NSec3s3qj1lAusLCFZd6I3ImBsQG/uoACLc7AEy8N4OATCM4NrBdH3dJOmOKRsR3V4nGsh0tuCucSmk798j+aGacSxLyDL1wL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b5dd1-ed97-4305-751a-08d666bbc6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 20:43:19.6762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2893
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_124335_145852_76FF4CFC 
X-CRM114-Status: GOOD (  16.00  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/20/2018 5:28 PM, Arnd Bergmann wrote:
> On Wed, Dec 19, 2018 at 11:18 AM Horia Geant=E3 <horia.geanta@nxp.com> wr=
ote:
>>
>> This reverts commit d9678adbe733a770428a98651beaa2817d503ed3.
>>
>> Received below report from Stefan.
>> Revert the commit until CAAM driver dependency cycles are fixed.
>>
>> this patch in next-20181214 breaks "make modules_install" for
>> arm64/defconfig on my Ubuntu machine:
>>
>> DEPMOD  4.20.0-rc6-next-20181214
>> depmod: ERROR: Found 6 modules in dependency cycles!
>> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc
>> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio
>> depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam
>> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_de=
sc -> error
>> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_de=
sc -> caamalg_desc
>>
>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>
> =

> I've applied the revert, but I think there is still a problem, since
> anyone could manually enable those options and should not
> see those cycles in the module dependencies.
> =

Agree, root cause has to be fixed.

> Horia, can you have a look at what caused that and how to fix it?
> It's probably a commit in the caam drivers. I have also created
> a patch to address a problem with that driver but forgot
> to send that out, it might fix this one as well, see my follow-up
> patch "crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM
> dependency".
> =

Yes, will continue discussion there.

Thanks,
Horia


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
