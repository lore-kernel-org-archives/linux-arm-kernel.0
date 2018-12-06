Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:06:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F73920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tbxwIG6m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ChCPscR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F73920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qnv5UGqF2mE/1Mfpj8XZtN11OHY3ciqbTCdJvl+p3lw=; b=tbxwIG6mncirg9
	gOf0zwbBSo1+JPEjSNmpaOPJOXe/kPyLHWdtlbhAocvIelVL53s14W76hjnxIqNSDL8mkIeTAx2Hd
	chvJ8MV+6kFZ9vpV+UWDmWsqIOHdwA7CIQA7OqGPvv1cS2NzNCcrOJh4iXJlWBgMCBtisxMtL9KC/
	OeMB/ISwZ7AMMl8t2Fiv12qnOO5NVWENNq14lLMoi9hOl/prUf5ZOLOcZTwUd+wjVbxkV9n8iMa+4
	LTderRUVdYpwnshatv95evH3ptdW8T8vJQ4oxEzZ4sBG11J2EE4PN2Rs5wosdrjoNps7GDKNTSd9C
	L4cN18pDInkdWdMGfwkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUy2E-0005bJ-LD; Thu, 06 Dec 2018 18:06:02 +0000
Received: from mail-eopbgr680106.outbound.protection.outlook.com
 ([40.107.68.106] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUy28-0005aW-9H; Thu, 06 Dec 2018 18:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7Ym/28FbfYFjo8Kau28UHz6Ma0/EBHpbuB4MA9ZmNI=;
 b=ChCPscR8Uxg6RfyDn0myrIV5KblnRMkUTNTTOz+L5BxblnB0gj4q09RvthSo1nfv8tE4T8W6yRsU6Aekf5vh6njYZrmlg2vhqz/XGVfu5s4jYXsxPuQaEWG5gQ71mIMSm0mfUdGMZAiZ/E1DsZ33DePsHZClPmEkRxaYd2gzuHE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1261.namprd22.prod.outlook.com (10.174.162.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 18:05:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 18:05:42 +0000
From: Paul Burton <paul.burton@mips.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Thread-Topic: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Thread-Index: AQHUjFTCvBEAjV0a3kG9cBZbfyErZqVxwdEAgABCHIA=
Date: Thu, 6 Dec 2018 18:05:41 +0000
Message-ID: <20181206180539.fezd6bqce36tgmie@pburton-laptop>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:300:ae::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1261;
 6:Kqbme/8dGXWDFEDuuT4QXLURsuOs5QbQ5Xq+jYG4BwjoQPSZnhV3jRlhRdQfuctJXIXPe3a9VsI23WnOlExtXpkwvnNq7wQhjuI3TkzXBOUa/JVLaLoSpI9v5Ii6wKPFDN6BOs1qD7cXXM8pwuOkn9jLbXltvvpZK8LJTWriTok5Rt3inDJCQhTitxWipEpiyvLWTyUkVpWukEwpCMk2ZvUD1P1AMB766mV3YinUAJ9MfxDJ6EbproA3FqyYVIpLriGqbUBZt1VtlrnXN8eUsoWY+t7MqRZVqWXNRuGrFuvprgjGTYznk4u0a4Dxc+EumglvPRgrVjIi48xKdw7neI8AQnG3N7I2NBIFA8HYgNXbH/BBET7kPBjz2fsLrwlT/xotXTpZyA1v3rrRmlQV7rnrKV3JIMreLgayu8/uZHFtAwhBgeAN9JZNdtCBVZ42JVsLYvzwgV26Ne5e/jNRrA==;
 5:NSOUjRz/gGVHSxNMh3SdoQ1iiEUm7fkrXVSK7S/kEUJLHBRev0JOa3E4iRLKo53Lxepw0dJZA+EuXHNOeSfDipsRCuzLW3mXnUP64AgAH/0qb573VJ63idjHf0Pp1Edg3e3gTzqo9SC6Mn3yY3eCQ6VJN/KPELUmgEbaexkKBTc=;
 7:i1Jr10EGoyYrJhAUUD5mSSXByVqCW64AouzJ+51Scb4b512wCU5iWtIbI+iQQHSCKmBkF6QoM9EkoktMkOVCkxQ3jlbHzmbF0+lsmRGR+P7u/36vwBNquNYZKxPXNPlNAKp6uc4VNi8pfvw8tdhRAA==
x-ms-office365-filtering-correlation-id: 457d6553-5b22-4360-7723-08d65ba56ee3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1261; 
x-ms-traffictypediagnostic: MWHPR2201MB1261:
x-microsoft-antispam-prvs: <MWHPR2201MB1261BE283313A550AF3B7908C1A90@MWHPR2201MB1261.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR2201MB1261; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2201MB1261; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(136003)(39840400004)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(105586002)(1076002)(2906002)(6116002)(6916009)(316002)(58126008)(25786009)(66066001)(4326008)(26005)(3846002)(186003)(305945005)(81156014)(386003)(6246003)(6506007)(42882007)(102836004)(97736004)(33896004)(81166006)(7736002)(5660300001)(7406005)(76176011)(14454004)(476003)(52116002)(53936002)(486006)(229853002)(44832011)(7416002)(68736007)(71200400001)(11346002)(446003)(6436002)(8676002)(71190400001)(99286004)(33716001)(6512007)(256004)(6486002)(106356001)(508600001)(54906003)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1261;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RBODwkcEs7rhB+DcAO1i/msJXgIAGxA7LhCkciKDHchazPyulsxRChueCtbEa2P1WfPn+T+L6it5OcP9Pw7TyhburN49/FE9lrL6++iMpb6avG1ebwmmvLvqJUsvb92qXLWXxJ70na/PQ7dmAANPsRE+BvaUez6hM43mM3gHagVuwF6tqvogBMZfO0UTFjLI7zlaUWBmf6s2oiAZmN4gjD7MsQqSe2S7J+gEH2Yjw2aC39MugmQLJlLWpgNr0TM2DKcTfq2PqottulWd4cZnAjKuLMOcJV1iRhfUkHcDsBuMu0CBLW+pZeTGtTwyIzzGuEM3/XRyLrQ1QqTWmg+R2t43Y4ZKofXG2jZETd1BJCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <502BAAE9FE2E6E45B9CE975E9FA539FF@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457d6553-5b22-4360-7723-08d65ba56ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 18:05:41.5853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_100556_371635_EC3D7149 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Rich Felker <dalias@libc.org>, "Gustavo A. R.
 Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Michal Simek <monstr@monstr.eu>,
 Vineet Gupta <vgupta@synopsys.com>, Randy Dunlap <rdunlap@infradead.org>,
 Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Jason Wessel <jason.wessel@windriver.com>,
 "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
 Ley Foon Tan <lftan@altera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christophe & Daniel,

On Thu, Dec 06, 2018 at 02:09:02PM +0000, Daniel Thompson wrote:
> On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> > MIPS is the only architecture modifying arch_kgdb_ops during init.
> > This patch makes the init static, so that it can be changed to
> > const in following patch, as recommended by checkpatch.pl
> > 
> > Suggested-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> From my side this is
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Since this is a dependency for the next patch I'd be happy to take via
> my tree... but would need an ack from the MIPS guys to do that.

For both patches in this series:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
