Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962782084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ctw0pdg0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qwySljr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962782084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EYBTjl0lhfCbm57ID1UHDX6NPT0zgSKln+9/4xwcVas=; b=ctw0pdg042vfYN
	qKmzSA2wEnJPQvrrTY+eMixdPD7nt9RaP75cnEL01OxWz8vjcGHZOH/C/6oWIBTSImNGpC9kinJ7q
	z/wwPdmuB39dOqSgQ4xr6BfLoGiY/gU43T5IHmeBTrsUwFlGuSTInSL1kB8Ic6QAAVUFghMRrJ4WO
	4d0eKkg1xSYvpKLLWiSNDdk0RnwxeE4p2j9XQe5Gyh6A5jpr+1c/rozbe6uLw/YMIiqDKuyiLNYZ/
	Ll1cfMsxNPnbjKcnLod/2rMbxvvNTW4OE+seumin/PmsVJRp9FrzeG2PFozb0ZCbXKjycsJD11smX
	Xhhbpd4eHUzcwOdcyUig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyKal-000655-Cz; Mon, 25 Feb 2019 18:03:03 +0000
Received: from mail-eopbgr150080.outbound.protection.outlook.com
 ([40.107.15.80] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyKah-00064X-0I
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 18:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVQNAfInftjEKQdTVIgTyS8KZ8vMtQLsmwmdsQqTnUs=;
 b=qwySljr2JLUM1To822DuvPb+GGxsMOxL9U0s00GYzpPGwPJiYh2gHT3W0KOhvpr/WoO+qVw69gXSAnTWnhhApFRLc5M0Y0+5Tv12+cIkeaah//xjHmWClpXPf5EotXN8NOdIvlCajTW1ptVFCbPJxqCSHHYcATKq5mYlu5uvTnE=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3088.eurprd08.prod.outlook.com (52.133.15.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 18:02:51 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 18:02:51 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Thread-Topic: [RFC][PATCH 0/3] arm64 relaxed ABI
Thread-Index: AQHUyFD8LSHMwEYo7kaikjJNt8xTtqXnc/kAgAlRvYCAABJJAA==
Date: Mon, 25 Feb 2019 18:02:50 +0000
Message-ID: <7afa18b8-f135-036d-943c-b6216e7da481@arm.com>
References: <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
 <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
 <20190225165720.GA79300@arrakis.emea.arm.com>
In-Reply-To: <20190225165720.GA79300@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0362.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::14) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb85d342-77cb-4df6-4dab-08d69b4b74ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3088; 
x-ms-traffictypediagnostic: VI1PR08MB3088:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3088;
 20:yrrnYBcp1F1tDfbY9DStaCTmCCp6zvFBmtTxtKRPIlMNTNJHp0tbQw3hytMUKmbW2rNC7iwqFReQnBVFJT9BErOv75UHU2FXTVAEQPH/6ggtvbMGbIRzrR29IArW6rOIypAw6VIZo5fHyXRHGdVVqQHf121+FBxcgNHgbvNmBsE=
x-microsoft-antispam-prvs: <VI1PR08MB3088F036F706BCB18FCA38BAED7A0@VI1PR08MB3088.eurprd08.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(65826007)(86362001)(99286004)(93886005)(6512007)(6862004)(478600001)(386003)(71190400001)(71200400001)(6506007)(37006003)(65956001)(54906003)(14444005)(256004)(53546011)(31696002)(305945005)(8936002)(65806001)(66066001)(68736007)(53936002)(5660300002)(7736002)(6246003)(44832011)(81166006)(476003)(2616005)(486006)(81156014)(11346002)(446003)(8676002)(26005)(106356001)(3846002)(6486002)(6436002)(4326008)(14454004)(6116002)(97736004)(102836004)(76176011)(316002)(36756003)(52116002)(58126008)(229853002)(7416002)(64126003)(25786009)(6636002)(31686004)(105586002)(72206003)(2906002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3088;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NW+5VgZcT8Krza092sQKHPkVSFrh5m+AWwqIzbaFCm1qZ7945lZq7Ao/IarsyF1eMosvpDOaQK8VxyLJL57ge9vPBj4/ZD4t/fxQbMNw4JNocR+4RK1Qw3iRKKP98e2n6KuKnb13sZuv2VGKu4AUUIemjtqCACZ8jATjl3pkQZxkFz5yg3BWtz+xtNEIE2xMmyEVTgAHnzRahrPyNBdlpuBWvP5e83a0GBhaMcF/Yt3qVA+sOEIkSpiR9lSSLmfec0N5Va0IK58cxTtOUPuleLXzLKtK2tBgUEKTAmFvC7F6wQtBRuVe+nbzo9nyGd/tGP9BnSgMUVSDHKSra9T7eg+LJo+uOFvu9DybXxF83iqvC3qq6ih0CYR78aS5YBcpM3KdTsM0AJJTiWT0e0fP+N9Zdk1QPmDpRnFWDcpAUKQ=
Content-ID: <63E1CE8D940678418B16F5E6DCE4B04A@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb85d342-77cb-4df6-4dab-08d69b4b74ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 18:02:49.1159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_100259_110496_7E61205C 
X-CRM114-Status: GOOD (  27.70  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, Evgenii Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Kevin Brodsky <Kevin.Brodsky@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/02/2019 16:57, Catalin Marinas wrote:
> On Tue, Feb 19, 2019 at 06:38:31PM +0000, Szabolcs Nagy wrote:
>> i think these rules work for the cases i care about, a more
>> tricky question is when/how to check for the new syscall abi
>> and when/how the TCR_EL1.TBI0 setting may be turned off.
> 
> I don't think turning TBI0 off is critical (it's handy for PAC with
> 52-bit VA but then it's short-lived if you want more security features
> like MTE).

yes, i made a mistake assuming TBI0 off is
required for (or at least compatible with) MTE.

if TBI0 needs to be on for MTE then some of my
analysis is wrong, and i expect TBI0 to be on
in the foreseeable future.

>> consider the following cases (tb == top byte):
>>
>> binary 1: user tb = any, syscall tb = 0
>>   tbi is on, "legacy binary"
>>
>> binary 2: user tb = any, syscall tb = any
>>   tbi is on, "new binary using tb"
>>   for backward compat it needs to check for new syscall abi.
>>
>> binary 3: user tb = 0, syscall tb = 0
>>   tbi can be off, "new binary",
>>   binary is marked to indicate unused tb,
>>   kernel may turn tbi off: additional pac bits.
>>
>> binary 4: user tb = mte, syscall tb = mte
>>   like binary 3, but with mte, "new binary using mte"

so this should be "like binary 2, but with mte".

>>   does it have to check for new syscall abi?
>>   or MTE HWCAP would imply it?
>>   (is it possible to use mte without new syscall abi?)
> 
> I think MTE HWCAP should imply it.
> 
>> in userspace we want most binaries to be like binary 3 and 4
>> eventually, i.e. marked as not-relying-on-tbi, if a dso is
>> loaded that is unmarked (legacy or new tb user), then either
>> the load fails (e.g. if mte is already used? or can we turn
>> mte off at runtime?) or tbi has to be enabled (prctl? does
>> this work with pac? or multi-threads?).
> 
> We could enable it via prctl. That's the plan for MTE as well (in
> addition maybe to some ELF flag).
> 
>> as for checking the new syscall abi: i don't see much semantic
>> difference between AT_HWCAP and AT_FLAGS (either way, the user
>> has to check a feature flag before using the feature of the
>> underlying system and it does not matter much if it's a syscall
>> abi feature or cpu feature), but i don't see anything wrong
>> with AT_FLAGS if the kernel prefers that.
> 
> The AT_FLAGS is aimed at capturing binary 2 case above, i.e. the
> relaxation of the syscall ABI to accept tb = any. The MTE support will
> have its own AT_HWCAP, likely in addition to AT_FLAGS. Arguably,
> AT_FLAGS is either redundant here if MTE implies it (and no harm in
> keeping it around) or the meaning is different: a tb != 0 may be checked
> by the kernel against the allocation tag (i.e. get_user() could fail,
> the tag is not entirely ignored).
> 
>> the discussion here was mostly about binary 2,
> 
> That's because passing tb != 0 into the syscall ABI is the main blocker
> here that needs clearing out before merging the MTE support. There is,
> of course, a variation of binary 1 for MTE:
> 
> binary 5: user tb = mte, syscall tb = 0
> 
> but this requires a lot of C lib changes to support properly.

yes, i don't think we want to do that.

but it's ok to have both syscall tbi AT_FLAGS and MTE HWCAP.

>> but for
>> me the open question is if we can make binary 3/4 work.
>> (which requires some elf binary marking, that is recognised
>> by the kernel and dynamic loader, and efficient handling of
>> the TBI0 bit, ..if it's not possible, then i don't see how
>> mte will be deployed).
> 
> If we ignore binary 3, we can keep TBI0 = 1 permanently, whether we have
> MTE or not.
> 
>> and i guess on the kernel side the open question is if the
>> rules 1/2/3/4 can be made to work in corner cases e.g. when
>> pointers embedded into structs are passed down in ioctl.
> 
> We've been trying to track these down since last summer and we came to
> the conclusion that it should be (mostly) fine for the non-weird memory
> described above.

i think an interesting case is when userspace passes
a pointer to the kernel and later gets it back,
which is why i proposed rule 4 (kernel has to keep
the tag then).

but i wonder what's the right thing to do for sp
(user can malloc thread/sigalt/makecontext stack
which will be mte tagged in practice with mte on)
does tagged sp work? should userspace untag the
stack memory before setting it up as a stack?
(but then user pointers to that allocation may get
broken..)
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
