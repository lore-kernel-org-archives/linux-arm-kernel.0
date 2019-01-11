Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6299B2063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+KPJ7+h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="HoLam4Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6299B2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l7MDeyqS/rCCTcRC3mAzgVU/tIAkS2mTdLXB/DZGvLc=; b=W+KPJ7+hI7H/lk
	NlJWBKhGFGvboysTGOLlSdgaGtUdY8XFnK9QlGWoTN5l1PjLaxDzELGyNIaK251jGKX6BQwKPxwzo
	OyGH+JMGpp0XYwheqTwcIxS5I6xMsht8ibV/UizXuBgio92iTcMAolnkheBL7FrJZ75+HzZrWUqjv
	ky0VNqg6W62i3M3HEHQY2KLCG+OJeTs78xc9gQZ/2WOPc3Pga6DfgvqIsjKjYysh7aSc19H+MYuR6
	2TmKN+5ht3n6jL0pHJ5qRF9bTi4xhtODkLwiZviYE1odHcmwnEnM1ZceXZk8I2tygUx76kloXo0ZF
	Rgby3HdXsphnH7enJjJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxoZ-0007Hz-CE; Fri, 11 Jan 2019 14:29:39 +0000
Received: from mail-eopbgr20120.outbound.protection.outlook.com
 ([40.107.2.120] helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxoU-0007Gr-9Q
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkO8wB0FH59VSGFP1SfU7V7CEw38jL+1FPPct5jZdXA=;
 b=HoLam4Ii1XdDZzuJ9sJ4Bys+JBYQBX12TIP9txCYY30dWXpIifaF33HqqHj+pUYGeg2K4NBtjdgbx+s548QmkepFByegWudcR+DijQ1xq5pd8K9CBCQZmj4P8AWmD8wEeyw3MRWkBn867dkkIzLLeMXzHC9KaGa7ejQRs+Xp+b8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5302.eurprd02.prod.outlook.com (20.178.91.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 14:29:28 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:29:28 +0000
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes, 
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vKWowhmAgAAW64CAAAmEAIABP6SA
Date: Fri, 11 Jan 2019 14:29:28 +0000
Message-ID: <e35d6894-fd62-efd1-38f7-cc5cbdbbacbb@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se> <20190110182904.5efd08f2@bbrezillon>
 <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
 <20190110202522.10206f2d@bbrezillon>
In-Reply-To: <20190110202522.10206f2d@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0039.eurprd07.prod.outlook.com
 (2603:10a6:7:66::25) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB5302;
 6:9UXOe+CKwDjR8ltumaP7WK81dqZm2NN3gboIGOmnV/4Scf+7MkmOg0w/9mWdhkywWd3+IrzCaDxcJEEUlEN/OWuEjCJhToBgKrPU9AQrlU5BEEHOWbjWXENCYiXms21CjVvaMCY7FZyVj7A0B8tiYwTwUnhJu8q4LzenvEf2loCi0jQ+l8X9jJ0MY2e/zUgS6d0Rl+uPOGqPyD5iz6yMy12nGnJiHF5X0CZoGFBZ6rWQZqI8ucLrfH1Dp27953SIT9PESGR94fMS6NsKBYb28yTjyZtiHPaWj58snoh9KCTHEMy2zxL8AKEOydZGnvqrd0gGdArF45C5Ln3sELi3Ifh8ogitpKcmvfCe8fTvTF1tyKLAmfK98wqbsojimDgP6y8qCD2R0bAYH03BEbR1cUnvTTfPan2VoV9T05TybvZ73Vyngm2UtVJ8rgy35d5dbju+0Lq6HNm64IqdqiMgmw==;
 5:PeNcFPI8vlgo8U6iLfsDOvvGv66sjeUI6XC3d6sVv02wfkp+DMvRartSeVc/H1nXF6oMRF5SB5KW2BY3fko2ZnY+7g/+n0UxL7ofqiMg3LKH2Cz0kyzlVJEzBI0tCa8Bgu7k3UXRE1pRoCIfkQzcOI+xnJpoGTETqNYa1RXQ5bed9JeE7IqC1hvdTpzkf+QA/SbmCuniL+0FGOxyfntluQ==;
 7:i/mmJyEWLsvq0wpXGstoGrtgiuPDxKETOQb5YUiiGYD+KbCYf1UoFkFvD5kXJjmcFu0fPcVZUuyVdhyrVFKooPgd2xQgptp+Mo/JifKKUvtmLWW9T1hn+6yNpwCQdCMhdEnVv9plbMeZVaYbD4MbYA==
x-ms-office365-filtering-correlation-id: e4293c82-a24c-429c-ab13-08d677d13193
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB5302; 
x-ms-traffictypediagnostic: AM6PR02MB5302:
x-microsoft-antispam-prvs: <AM6PR02MB5302D8DA862CDE0BCD4DFA50BC850@AM6PR02MB5302.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(52314003)(6512007)(65826007)(5660300001)(68736007)(8676002)(66066001)(65806001)(65956001)(81166006)(81156014)(6916009)(64126003)(7736002)(305945005)(76176011)(6116002)(31696002)(52116002)(3846002)(446003)(11346002)(2616005)(386003)(102836004)(476003)(186003)(26005)(97736004)(25786009)(36756003)(93886005)(71190400001)(99286004)(31686004)(6436002)(71200400001)(486006)(6246003)(6506007)(2906002)(53936002)(53546011)(86362001)(54906003)(4326008)(106356001)(14454004)(508600001)(105586002)(74482002)(8936002)(6486002)(316002)(58126008)(229853002)(14444005)(256004)(14773001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB5302;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PolZWXxM77y0YUXNRgeXn5m2nlkM0XlZ1yZJEVd6lzqLf23ti8oWUPgfVT8Os00FYB4fg60b0/QVwoUouFrxBDWUYKfstUtzVHuQ7EgNvd/6IiUqPP5GgkOpREioIosYXV7wSYkDI/hu+VgrGdnoT5czsr6CqO1Ep8BIuNun80cunqTZGaqZwG/9v7Ihgde85HVrdyeF/vpiW76L5ENavezs5yvnLQLeSLQCUEgRn36VUxsJOnxZuFt85JAdfNxMAXuxH/kR3xWUPp9Gw7pMDKUdeFoaSgzyWl8DEFAe0lsroa+4kMTQV5QJT7r+dIu/Gr5qcpXXTHaLqVJBbfIZs8YJ/I5PJD7TRVyM8zqfvZA8itdWM78l1uh2ZfOQ1YwxA2mNwHzO4WGEwn+Yl2a4ujGS1/VjRVL/a8WzF7sXqjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <898D23C585639C4395B84DE60D6CBBA4@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e4293c82-a24c-429c-ab13-08d677d13193
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:29:27.5830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5302
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_062934_812400_90F5C886 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-10 20:25, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 18:51:21 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2019-01-10 18:29, Boris Brezillon wrote:
>>> On Thu, 10 Jan 2019 15:10:48 +0000
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> The A2Q and UPDATE bits have no effect in the channel disable registers.
>>>> However, since they are present, assume that the intention is to disable
>>>> planes, not immediately as indicated by the RST bit, but on the next
>>>> frame shift since that is what A2Q and UPDATE means in the channel enable
>>>> registers.
>>>>
>>>> Disabling the plane on the next frame shift is done with the EN bit,
>>>> so use that.  
>>>
>>> It's been a long time, but I think I had a good reason for forcing a
>>> reset. IIRC, when you don't do that and the CRTC is disabled before the
>>> plane, the EN bit stays around, and next time you queue a plane update,
>>> you'll start with an invalid buf pointer.  
>>
>> It might be possible to clear the EN bit in ...CHDR before enabling the
>> plane in ...CHER. Or is that too late?
> 
> I think I tried that, but I'm not sure (BTW, this change was done in
> bd4248bb5e8b ("drm: atmel-hlcdc: reset layer A2Q and UPDATE bits when

That patch is a big fat NOP if you read the documentation. Those bits
are marked with a '-' for all LCDC channel disable registers, for all
supported chips IIUC. Are the effects of those bits mentioned in any
errata?

It would be good with a comment that the present undocumented disable
method is intentional. That would have kept me from assuming the whole
thing was just copy-paste junk from ..._enable that happened to work.

>> disabling it")). Anyway, I'm not even sure this is still needed now
>> that atomic updates have a wait_for_flip_done/vblank() in the commit
>> path.

The documentation for the RST bit states "Resets the layer immediately.
The frame is aborted." which sounds a bit scary and heavy-handed. But
again, I don't know what that actually means and what the effects are
but that was the reason for me wanting to avoid the RST bit.

Cheers,
Peter

>> But this patch is not overly
>> important, I just wanted to avoid the resulting "black hole" when the
>> plane DMA is disabled mid-frame. But disabling planes is probably not
>> something that happens frequently and will perhaps not be noticed at
>> all...
> 
> Okay. Other patches look good to me, I'm just waiting for Nicolas
> feedback before applying them.
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
