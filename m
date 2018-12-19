Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB347C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A260218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZUFwc+I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JBcBaVlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A260218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=reHajUVuqc4l/fnm+g9LP/FUfLd0F5ouL+jqqbwg8fY=; b=AZUFwc+INTvOCZ
	n6BRfXeAgYhc7woyj6Z8pzdxJPD8exHfgo5XRjDBBAQv6KuidA29nlY2l+rgxGWrT7W9sakY+LHkJ
	/2DhYq2L5fb/vNClTVtZJlBPfLzaj9aTB0y+QjgAMRO2HH14EnLXRDCDWxxIqK+cX01NADx+8vPyk
	elRm8aNusaZ7M9zbZ8/KlMhXKmpCStMm3YW66HN0s7tXAYTzvZXuBTaHioHM+6c3DN2Yhhc3jE4UR
	aKmAHt88G+7PtaSi9NZscqhDEI3jW/cjKpw3sg3r3PM+1SpUOyNiXPULZkV5Lq5EEO4J9MBloCb0o
	n7KmrHJGH/H9EOENWD7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdW9-0000ts-8J; Wed, 19 Dec 2018 15:12:13 +0000
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdW4-0000jq-Kl
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKLMRRMJ9l/ZTRf2vU21mYg2RnznFpBIuaPBot9jTRU=;
 b=JBcBaVloVDQ6CYAz8/ntDSji4iv98/mlMur1fIR3glzYQf/v0LVDXINGzgjZ4I7R/TyYRjMRDYMBnA6EUnOp/qrA+kobLwcW7Jy12DaqTc2mQvE19KOJDAczW+rs66ahE6qtCyIWFKb/c3u099m/KnizbFYwsC3ovbjaOtTiGEw=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB0639.eurprd08.prod.outlook.com (10.163.169.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 15:11:53 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 15:11:52 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Dave P Martin <Dave.Martin@arm.com>, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Topic: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Index: AQHUkYd+cKmKBO7HTkm9+VFCNK1nOqV/i8iAgATnfYCAAcQCgA==
Date: Wed, 19 Dec 2018 15:11:52 +0000
Message-ID: <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
In-Reply-To: <20181218121307.GA22067@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWLP265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::25) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR08MB0639;
 6:brOzH9TzMLcxi7SBSxO9GV3TKrmrUoXhlh2KfXEv/mH7cu52C435o7HP0vTfZ/FaEpcOsffwQAGA4RxDTAYkyR5kFMZIYPACn4uQTG8ijpLdlrmI1wjlX1zprp0CVa2fU44r7n825M0gmYkgoDCQFgmGMLaR/IR438zN9J/UqaID1K0hJY9YR0aN832JUD9DmJmwXfUSNgLIgjd//l3JBrTEnNHkBGxBBEZnLpzNtcVXRKeEkp8mBwdE4T80jFgpMRVPxPLEe+757HvOEVLT8z6TBIbyZTGD3YNYviw4b+8Hvq28XkMa7oQV2KLAvLLJ3MOOvMYELrdRY5mFemGnJqHWsamPx9OCs4fLzFcIDwrMaSdoQhtvprJ04jCQGA3iz9DBn/V1GxxgboMTUD/LJIz5QDQHWs+dxcstiQggvHw4u97u9Jn9Ms2PClNJRD25TYoothz5igncYBctLzZb+w==;
 5:33NLaJSXQUZta+E0g/e/Acobg9ma6wyBguI4AGeq6shiZVO+8rqwfHkwG1z8EeiisLIEhp7ser33wwiKvWuXc3BcCVm8dxUU154MA5XzyDd4zLfY4adNcrDDzrRCud38orh8PoB8CUwRS6b1ywMn4f8njqtRaP5SmIjzSLffOSQ=;
 7:ludp+820k0wCTGiq7bOkTCSRj1wb5RNBNCpaidHSC8qMUURjuaRWrVM0lQPQepDXqlLKUuFMVYD+uee8kkBUibtq0z1L/+zJxN8IXF2zY9pd8AjuAhz8o3kkR8941elC5hcfCjSgIgsBTSZHYhZN5w==
x-ms-office365-filtering-correlation-id: 01d27d07-4ba2-43ab-05c8-08d665c44e8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB0639; 
x-ms-traffictypediagnostic: VI1PR08MB0639:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0639CF912AC5B66E2392B76AEDBE0@VI1PR08MB0639.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR08MB0639; BCL:0; PCL:0; RULEID:; SRVR:VI1PR08MB0639; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(53936002)(476003)(4326008)(5024004)(14444005)(2616005)(86362001)(31686004)(31696002)(6116002)(305945005)(44832011)(6306002)(6486002)(106356001)(6246003)(3846002)(256004)(6512007)(486006)(97736004)(11346002)(105586002)(71190400001)(6436002)(71200400001)(186003)(229853002)(446003)(5660300001)(52116002)(81156014)(81166006)(36756003)(68736007)(26005)(8676002)(65826007)(66066001)(14454004)(99286004)(65806001)(65956001)(102836004)(53546011)(6506007)(386003)(345774005)(64126003)(76176011)(58126008)(316002)(54906003)(110136005)(7736002)(72206003)(966005)(478600001)(2906002)(8936002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB0639;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eoWbKlilpZSAtoBC7PEm+74WX7mRLIJpOyPCw7eTgrqFHcqIlAEZ454Mn/f3XRz8R/PbYLvyNaQzLewK+XJPwEmvYYvNik55DrpkxMnNQuUz4ZNd5g29nCaN/9jEf/SRU0XW9xHjinMEp95JSPKnoyLUY9ugP90f4x2Q6bRwZRdYy0rnFzUY9rt4wJV/gsHN0FNrEhxmUSzE+z76tVZrc8SxfEfdjERfIuIY/jrHWmNtzkFDJ1Q/qUKQgOC5V+bhUP67NzYaMPnxJ+XswrWdY/BHen8pZeAOQQLGQTmBUODpI9/hzLQUTi3VrG8GmXO8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <47E72A1058A67943831F4B02188CC9E0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d27d07-4ba2-43ab-05c8-08d665c44e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:11:52.8554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0639
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_071208_705241_EE5E0BE5 
X-CRM114-Status: GOOD (  21.49  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kbuild-all@01.org" <kbuild-all@01.org>, Alan Hayward <Alan.Hayward@arm.com>,
 nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/12/2018 12:14, Dave Martin wrote:
> On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:
>> Hi Dave,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on arm64/for-next/core]
>> [also build test WARNING on v4.20-rc6 next-20181214]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Dave-Martin/arm64-sve-UAPI-Disentangle-ptrace-h-from-sigcontext-h/20181214-225154
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
>> config: arm64-allmodconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> Since the new header is not meant to be included directly (and has a
> guard to that effect), we don't strictly need to do anything here.
> 
> The way to include <asm/sve_context.h> in userspace is via
> <asm/sigcontext.h> or <asm/ptrace.h>, both of which include
> <linux/types.h> first.
> 

i think there is no need to explicitly prevent the inclusion of
the header.

it is enough to have a comment that it's not supposed to be
included by user code (so the header can be later refactored).

and then such automated header checks (or whatever other hacks
ppl do temporarily) can continue to work.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
