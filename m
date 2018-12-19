Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQ/UMTYd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aFGYuWMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=axIaCL4sJx+YTj77eso9oMPLvCwCGqSi7r1wd4wAL3A=; b=bQ/UMTYdBxnFWD
	9RDbweUsZm0un8H2wPCW96I7l1x3nbaLNwdIrgzH7Gye6rWMemeOrNcgRXKORH4bjv/aBLvM9FoyU
	L3lMV/DcJMq6/ciASknFPDHJ1GEuyWqTXI+lFl+5I0ZEZrlT8Tu8C4feyXLBqdeAc4Vl8sFVV9cHv
	cZ5PeDOP2hlp9gY4wAZC72DB5g3Ter2M32EIymTfGhVaOoeiF0SjbK6SQXRbieEHORJh+v3foCF1e
	sBCMXhpQ2EVpnGScMbMDlxswwe3+4r7uuAjcmiBjQMjYUzYkJC0d6AnarZaiihrIoeKk/wIupfhnx
	lgHxQa0v3pvOKtYEmYXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdkb-0007Kc-1g; Wed, 19 Dec 2018 15:27:09 +0000
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdkX-0007Jn-8s
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKzO2DKYdfPuaAt8X8cUBcMQtDyX88eYsSUGu337ZrA=;
 b=aFGYuWMv27+DypeTtTduEbtTmnqPf5JOxCeWOz6oG+VSSjevJOEs8jMjtWcYNQWJXL9jPxJDxJyVrVMD1d9jHbS9Y5YRXkv+K224WztZX+ZgVdX8eSwTSjURf+XQADBFTWo+ch0FtROl5IGyvEZ0+sf1QEimryUcfWGLYg9wcY0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3632.eurprd08.prod.outlook.com (20.177.61.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 15:26:52 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 15:26:52 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Topic: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Index: AQHUkYd+cKmKBO7HTkm9+VFCNK1nOqV/i8iAgATnfYCAAcQCgIAAA0QAgAAA6oA=
Date: Wed, 19 Dec 2018 15:26:52 +0000
Message-ID: <0bd88c97-c93b-2589-7ac6-49d30fd9ae97@arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
 <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
 <20181219152332.GC22067@e103592.cambridge.arm.com>
In-Reply-To: <20181219152332.GC22067@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3632;
 6:GVbf1o5MAGqaDPBprToEc16n0i6o69peIj8N0AZSZc9fYJjOedKpF7ixKH22KFgozkPAAp/uj759gEbKJOHz7hEQSAApnHJwj2IoIpwJ/gPPhXGY86LcwoYL8jmEp5LiIKhRyZHgNIGya+UMl56JCgeh2tIKSDonvs2MXdY6OzKR76gAsGqjdiAJ85W4kJV72H7C9OYR7zTgD1b9cq8ojWkn7XEXqU9a6k3kYvjOJiHUxB8ypf/TgPMGuQOF/dFN8yXh1sr6cNheCTd26Z6pK9U7Kx0iM0rqcG5eVE5GY+PqTKPeyEz/BE2YWnvQ3QUHN1N9cA++X+PYZRTSSOQQjAAc/Yh8lbp3k3fwnACWIspmdyaXhUNBh29lJ1z5XiZlI2tD0LzLbjK/mv4tvIwYY5ubTK+uCe9R6qu1SJ3OSWJlWkmKx2k6VGvO2941DGD31zUy9x/8QfFBNdtmaS6nig==;
 5:R/gmlwMqeIhPwMRqyiK8tQ+Vp3KQEdH1WHCEXgSI8YHyfhYVNqHVoNejCuyo51NR1km7EEf7Cb4SpFdMGslyoBK9AZBXwczQ0MHaEnNJpOCq4Q50LSsOhAWpyPXyjvQjiP6QZvFktQPltD5QdxkHmqsKxTRMfDLWqgpaslepfn4=;
 7:LJCyIiWy0otruAwHWiiSkqvrnIc/aBUjTu9hxHVNIM20ULxZ5BuRdwTqpcX4MB2Ew1F9ZHCTNJrArqyyheeasc1bOzq3ZcucwregvOOalRIjT0lAxDtnC4HGnx9ZB1hOlUR5dIA9771L9rMdD9CCZA==
x-ms-office365-filtering-correlation-id: f634f223-9d81-42d6-95d4-08d665c66657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3632; 
x-ms-traffictypediagnostic: VI1PR08MB3632:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3632DBD308074450DD419F69EDBE0@VI1PR08MB3632.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR08MB3632; BCL:0; PCL:0; RULEID:; SRVR:VI1PR08MB3632; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(76176011)(5660300001)(86362001)(93886005)(186003)(386003)(102836004)(53546011)(6506007)(65956001)(26005)(66066001)(65806001)(478600001)(72206003)(54906003)(58126008)(37006003)(14454004)(71190400001)(36756003)(71200400001)(99286004)(52116002)(6436002)(316002)(31696002)(65826007)(7736002)(31686004)(6862004)(6246003)(2616005)(476003)(305945005)(11346002)(446003)(81156014)(486006)(106356001)(105586002)(97736004)(44832011)(4326008)(6636002)(256004)(8676002)(229853002)(6512007)(6486002)(64126003)(68736007)(53936002)(25786009)(8936002)(14444005)(81166006)(6116002)(3846002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3632;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KA0GZKxVbQPLe8nR0jgbVuLLclillwcJSdn6BZke5WGXyoinVOBD+kW84bfuQq/GlKS4ElDpM2JWz7xtd9UoM0KZdLCbk4IKV+xlXzL801e/pnIOYoH+c/Ql26hz4WF3LXqy79W+BsoobBsvHvsryyBmnhsAWJGh8pB75pPE7moDxQ6YOHayEm0nX9EQk/psdxAqc7axO60h5rAWqu8TYu6Sfr/RPaeTV1B7QhfOBpbrzzUxFNtoSLudRcInZDsy//CIPIaDMwGgULnVeqxWG3+uwe1lIGzCGgdKASoangKqRgDX9cw6toUpo4URz/70
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <DA1E50E50B85C54AB8B99C103B86A96D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f634f223-9d81-42d6-95d4-08d665c66657
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:26:52.0700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072705_311484_6CEFD7AD 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: kbuild test robot <lkp@intel.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kbuild-all@01.org" <kbuild-all@01.org>, Alan Hayward <Alan.Hayward@arm.com>,
 nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/12/2018 15:23, Dave Martin wrote:
> On Wed, Dec 19, 2018 at 03:11:52PM +0000, Szabolcs Nagy wrote:
>> On 18/12/2018 12:14, Dave Martin wrote:
>>> On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:
> 
> [...]
> 
>>>>>> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>
>>>
>>> Since the new header is not meant to be included directly (and has a
>>> guard to that effect), we don't strictly need to do anything here.
>>>
>>> The way to include <asm/sve_context.h> in userspace is via
>>> <asm/sigcontext.h> or <asm/ptrace.h>, both of which include
>>> <linux/types.h> first.
>>>
>>
>> i think there is no need to explicitly prevent the inclusion of
>> the header.
>>
>> it is enough to have a comment that it's not supposed to be
>> included by user code (so the header can be later refactored).
>>
>> and then such automated header checks (or whatever other hacks
>> ppl do temporarily) can continue to work.
> 
> The guard is in linux-next now AFAIK.
> 
> Are you saying that it's likely to break something and needs to be
> removed, or it is unnecessary but harmless?

unnecessary but harmless.

(i assumed the header check bot would want to include every
header on its own and see if there are undefined symbols, but
if it works with the guard then fine)
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
