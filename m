Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1DD214D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHSapAdL";
	dkim=temperror (0-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XAqzeVa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1DD214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8qLwZaFkqD2+gmROfAP4kcmmVE78AFxShsclM08crBs=; b=aHSapAdLPpqGzH
	vv/PUcd4Po1VuQ1EAtYWzOK5qWVszKUpECIRwaAQzRo0e/eIx3r2s1vYlcuoyVFmC0weohQBykFc3
	2PUccbU7NAYpa4fl8bNZ+tFfN6ILH1Qtv1pxUxc0MTJPKs8dyfJQ2dfEIRG5rN7RMGi1WC299ldYJ
	fnZLJYqIOmPmRtY4e6H7sSsmST9ACwcOokfLbhywycgzkGhRAR4NyfBtgCxxA0kRKiD12dYZk52l4
	jOPGI/4PQfvvCs5GKs0HRToFYrUm4Qr9/IzpkG1Zr4xdnqQddou33PTvvsII85mBLWDtPkdhRSUAq
	xMGY8EJ1Grfg1L0y0R7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlPw-0006LD-Jb; Mon, 03 Dec 2018 10:25:32 +0000
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlHX-00009N-Ie
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:17:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1lVJuD3Rkd0TLeBS6dfarWUWEEeXwKNEAyE1fiGZ3Q=;
 b=XAqzeVa4dOpnAegyBc+EkMWs3Qoa7urqNTnozxDtZcx/XTCbN17hNslZ7cznK58ZFGH3Wvl0AAD4d/WIrgyh+bs/fL9QJH/Ij0JE8bJu3pDItHhsjWEfCWb363TkZ1fHc1SMnjnUF6pwilS/+w9aNgA2zNg4LzdI/hq2+4jcwyQ=
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com (10.171.191.18) by
 AM4PR08MB2788.eurprd08.prod.outlook.com (10.171.191.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 10:16:36 +0000
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::8584:2893:f8fe:d054]) by AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::8584:2893:f8fe:d054%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:16:36 +0000
From: Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: revisit arm64 per-task stack canaries
Thread-Topic: revisit arm64 per-task stack canaries
Thread-Index: AQHTpMc3M17A3LVZbU6KbMDysNPxbqOiSVKAgAASG4CAAEU7AIF6RQMAgBxJNYCAACSJgIAfswIAgAAD0ACAAC2OgIAVYTCA
Date: Mon, 3 Dec 2018 10:16:35 +0000
Message-ID: <3f863978-a755-e366-2067-135781547b85@arm.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
 <20180213180436.GA21758@arm.com>
 <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
 <20181030103502.GD19955@arm.com>
 <CAKv+Gu96pRfneQ-SLL3a9d-uLAqOPvkLcB25Md=f+z9f5Yg+fg@mail.gmail.com>
 <9f84b541-1d23-5143-70e3-f42bef3c8e1a@arm.com>
 <CAKv+Gu-UodqRkpK3jVgkgVos=+U5RuBpsPVj5H3CwbzUUPQzKg@mail.gmail.com>
 <CAKv+Gu9Px=RKue=6DT3y+GYZ3vehYs+B6nfVYjtWjjfJpHk4dg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Px=RKue=6DT3y+GYZ3vehYs+B6nfVYjtWjjfJpHk4dg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-originating-ip: [217.140.106.50]
x-clientproxiedby: CWXP265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::16) To AM4PR08MB2788.eurprd08.prod.outlook.com
 (2603:10a6:205:d::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ramana.Radhakrishnan@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM4PR08MB2788;
 6:tUdm3DG3tLAIuiWp1E32jT2qZYLxKgdnERyuwOieBWirA8//Qk6Dwkb4+1SucuiM4IiH1V1YnJ0enu/R6ZH6kKXqC4Yy0WyyOt/k319K/C8O27TLhb1kHesLltV8D1ufbLhasDT+DCw999vquOMgwfUQLtEfCeIebYURGAeAPYplceBVpJ9BDI5dzXYCHGVGrunxYKsPlxXgCvcSzvvJcf4zLw98xCVpnkpksgbRpPEGXiwWDgZQkxvzUOHAJa7o+c/LjLLa8HTB45+IR3H98B0zzqMzAXnBD1aBlxvCp0JMV4S9kl/0JFZFG00jbwRanTr4K/tDqsDXSULjULpcNaYpcMeC8Az4AA2VgJm7XLsAqD707i0od3NOIm+VAQowkZeUvHRLEK8rIeEA31reMCsL6u/oQGRIkt1KsZgMtV29ACJNa3EUc6m0lGsmQcVOWYjZRfIfu6H001WCG0AQng==;
 5:JXGQdOzJiInNyGS5fsT+PD7UKxg0pVkRNZlKgnafMEZhiIt56z2bkDL7Isy0IJQNTI0DDPE7LfoYky2djkgbak1XwfeD1SBEK/u0NVo512ip25FFipRRSjL27q5vYYP86fHdZSV7IWTPWzMNAhmaDAtNvaObdI008woQooWciT8=;
 7:LHdDTR/TKJ7OPM0pED39+yv9ADwRc0NVy5d6bGVEUlxm4PB2YxXxbvZ3B7S0fHYs/WWS1zPE3R8+o1TzVPe5CTTwpgCws7RHvgKMxC6SXuuskjStZmyThgo4nmNCHQnTyRtd1ZBkzJf/YES+bZmv5g==
x-ms-office365-filtering-correlation-id: 09a760ba-78d5-4088-2bb4-08d6590867b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB2788; 
x-ms-traffictypediagnostic: AM4PR08MB2788:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM4PR08MB278846CC3D29986D22A276C781AE0@AM4PR08MB2788.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM4PR08MB2788; BCL:0; PCL:0; RULEID:; SRVR:AM4PR08MB2788; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(53936002)(386003)(76176011)(6916009)(68736007)(3846002)(186003)(102836004)(6486002)(6116002)(575784001)(26005)(86362001)(2906002)(229853002)(6506007)(93886005)(54906003)(58126008)(305945005)(7736002)(316002)(25786009)(14454004)(72206003)(11346002)(446003)(486006)(476003)(478600001)(2616005)(256004)(44832011)(31686004)(65956001)(65806001)(99286004)(31696002)(52116002)(8936002)(81156014)(8676002)(66066001)(97736004)(65826007)(5660300001)(36756003)(106356001)(105586002)(4326008)(64126003)(6512007)(81166006)(6436002)(6246003)(71190400001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB2788;
 H:AM4PR08MB2788.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r85tmIv8WnczS+GT4W+IHkUAiVz3tTmVxFwe1UIDCy15VDl6QG0JcgoA4Fe60G44XhWkAwVdkc8PmqhARrjZUAGKnpOD/ZqCVy0DOaDNndEDZmPB07Z2v6f5zmlU4TDJ0E4Sqkng82EpVvx33jiOlNuDfodsAikXh5ypc2wFU+H5DqgPt893c3VyDCsL0zj98gULDWSZiXEXMrA0woofWV4J1r/IjTGKKzBLteBGQfOM+Z13vUa5bINwankvPqAc/wbtUdahsfXVKXHcgOolZVIIbU4RJvzym689CebD8BxwLF4012Km4ctH9C8sNEQK8mG7dUyiKdMg+gRqJ1N5YWOdK/QedZdI5V2rWsg3jA8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <96A57546DFB5954E98CA113E7BCDBDD2@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a760ba-78d5-4088-2bb4-08d6590867b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:16:35.9171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2788
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021653_790078_95F0208C 
X-CRM114-Status: GOOD (  17.47  )
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
 "linux-hardened@lists.openwall.com" <linux-hardened@lists.openwall.com>,
 nd <nd@arm.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>,
 "uros@gcc.gnu.org" <uros@gcc.gnu.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Just building the defconfig with a compiler that implements this
> should be sufficient, like below:
> 
> export ARCH=arm64
> export CROSS_COMPILE=[/path/to/]aarch64-linux-gnu-
> make defconfig
> make Image modules
> 

You probably need this patch on top of my patchset to GCC this morning.


regards
Ramana


This is a tiny patch to add the -mstack-protector-guard=sysreg to
indicate the type of the stack protector guard to the compiler.

Signed-off-by:  Ramana Radhakrishnan  <ramana.radhakrishnan@arm.com>
---
  arch/arm64/Kconfig  | 2 +-
  arch/arm64/Makefile | 3 ++-
  2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index faab97226dbb..6151327cfa16 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1250,7 +1250,7 @@ config RANDOMIZE_MODULE_REGION_FULL
  config STACKPROTECTOR_PER_TASK
  	def_bool y
  	depends on STACKPROTECTOR
-	depends on $(cc-option,-mstack-protector-guard-reg=sp_el0)
+	depends on 
$(cc-option,-mstack-protector-guard=sysreg,-mstack-protector-guard-reg=sp_el0)

  endmenu

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e1494ba5d0e7..be60d64afae6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -63,7 +63,8 @@ stack_protector_prepare: prepare0
  			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
  				include/generated/asm-offsets.h))

-KBUILD_CFLAGS	+= -mstack-protector-guard-reg=sp_el0
+KBUILD_CFLAGS	+= -mstack-protector-guard-reg=sp_el0 \
+	-mstack-protector-guard=sysreg
  endif

  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
-- 
2.17.1
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
