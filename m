Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAD_ENC_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC896C37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEE02089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bZeKG/Pt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JePuWtGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEE02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GZWeF4syn89tXfyoJzpPVFoa8GUAu0UfTzA9KSGkQr8=; b=bZeKG/PtJlwcbf
	r5zFeOd++HCm4WtW/s00IarcU3DSxz8uzBk9ee14kbBx1pcsyT1SmB72BjKWNAlXG68/ymt9lAc7M
	zVkPtYnW145G5AS2I22oxU1Jn02YjDSn+sImKEnR4+o5ZKIuDzfUk1FxVXitQhNyimcnnDFgeZG5n
	cmObNZltBvk6MjZfmN93JPKYiiY7lBjjvAHT7EP2Z2DLkXwaxCPE//cd952Nx66ADwTpTfc+xd9HM
	vEkpkl7VvxAz2ZpxylX6IIhLZnN8+NBNqWHu2OnEtI2zyFUg4alUz7Pzb/Dx2E+O9T6rkbin7Of6y
	hM4KoZc6HSXh8UqSbYfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkdO-0007SX-MO; Tue, 22 Jan 2019 01:13:46 +0000
Received: from mail-by2nam01on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe42::62e]
 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkdL-0007Rq-Ee
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+FAeGlh+R459tXPLmrf1oYGlF6egEsMt1A2KwmF56Y=;
 b=JePuWtGpUl4AwORUdRhbQQDEfHKMljzcsrb5o8oMBU8Ts485dZs7d5Q3aO5uw/3etyp5VaOZWMkp0ap+WNVejVKIAo/3UAz0+upLbOjlTCIvDXlVz+ugIubt/Hw43jVPGouL/Ppc0rwiMKzcEFBCGE+tXKLBAsidsYYAwdYK38o=
Received: from CY4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:903:18::12)
 by DM5PR0201MB3509.namprd02.prod.outlook.com (2603:10b6:4:76::39)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Tue, 22 Jan
 2019 01:13:39 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CY4PR02CA0002.outlook.office365.com
 (2603:10b6:903:18::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27 via Frontend
 Transport; Tue, 22 Jan 2019 01:13:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Tue, 22 Jan 2019 01:13:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1glkdF-0008E3-SP; Mon, 21 Jan 2019 17:13:37 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1glkdA-0002CT-Mh; Mon, 21 Jan 2019 17:13:32 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0M1DV4Y005639; 
 Mon, 21 Jan 2019 17:13:32 -0800
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyunk@smtp.xilinx.com>)
 id 1glkd9-0002C8-PV; Mon, 21 Jan 2019 17:13:31 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
 id 347432C73A0; Mon, 21 Jan 2019 17:12:41 -0800 (PST)
From: Hyun Kwon <hyun.kwon@xilinx.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: soc: xilinx: Add the dt binding for Xilinx
 AI Engine
Date: Mon, 21 Jan 2019 17:12:16 -0800
Message-ID: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(189003)(199004)(478600001)(2201001)(50226002)(110136005)(63266004)(8936002)(103686004)(51416003)(106466001)(42186006)(316002)(336012)(16586007)(6666004)(356004)(107886003)(52956003)(90966002)(186003)(26005)(4326008)(81166006)(81156014)(2906002)(47776003)(426003)(36756003)(8676002)(50466002)(106002)(126002)(486006)(305945005)(48376002)(476003)(6266002)(2616005)(44832011)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR0201MB3509; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT022;
 1:8cvC3l+gcrIMeGubYVZ6POmfzNGCmMCWjdSJRq+VSZjIHjTX5CjfWGYlA4t2Mcd6WHAZY+RHWJeKOVHEaa33oCuSjhkqTA/m3owIFFRP8EdBwZqXx3XKdN4eI1fnY5CoyZRxJ3a97cVz+ZjRRNd0tw==
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc0609b-e6a4-4ed0-ca65-08d68006d711
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);
 SRVR:DM5PR0201MB3509; 
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3509;
 3:duFxBF7mNcLBzbYmsaV5N3ScYXrUlD78BZ3DHl9+ISaArkBiN6fNXnNEf4OOUzgQJZMrYXCX/p+ILo6jREf4PIDatWa3T/5WcVXjRSxmlJBcHOXIVE3/6P3d03TCGs+yFrGVCCsSsbhvCa+gZXU8uCvvm+HL8a9VfFEC023xIPrdGA4xCCP/LjtfdDloWWHva2d7+8MV1SblOeNRExYabjgQRA9NSIhF+qNV2ShiKFzpI0Pi5WbIzFykTJCDIqN1My0eJ5nKEQ4m8sxYuP4PIMR4EPO/sCqpVFMhjlPhK0caYle3bl/Ara2F9so2ONu2nh9KLw05IVtgjrohRvBgNlcQtKKqQT6uc8gd48gyEKr6vcFNNn6y3H9V1bWuuLN6;
 25:ceEK8WAfxN7sHjhHfRYYp3bhvZQ2rGgg2kn7azxu4c+6lAQJ4dugQxuLrwQI0Pu//iFUxwQM9fapgAuH/kokvgHflmGEtVvg9crpkjYBdldpw9rJ1NRJ4RRE1FFcNpyk9bHZhEu/8T4ePXtl7kfWtYF1c/U5B0jlwYl9whjOVakvyJFh8VGsYdbbdR98n8aOS51SH3kXL+3JSAsVdBJww/VTKYHPYbzXjRkg7OQ8e16uD33w0Sp/bG2M09ZXJMcAMm+lWsFGnyFMZhdiokVv8aefQ/rQair6QJ/A0mlYYTHD3hFpyaf9FeCWbmVbhrllVUk3oguEWsHEsWA142foAQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3509:
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3509;
 31:Nm3TmPy7fZAI0NMj/blwEA7CGvQGXKaUD2sJGC2YqbG1vz7O5D9OqRY8LYGR45sDH2Gijn0inGj3bcN+lyf2/gef2iORrG5M1cjzhW1PPM8XfLP6U8NlepeCEImAmaId++aPzG6oJkLZ3MXHlF0z+q1FSMeDhvdLiZDj3yDAANVYOzzQgqyG+HB7ReoS0mCq8Q06/rH0e4Lndb4vBD/FnqiUkeM0a51wyg3i29UKEAQ=;
 20:N0J/bxLwRLM9fpDqoMcJ2zUQYj50rnIoZc597K/9scDahStDJ7zGw8kuuyG8fFIDQucnTHf15swHE8U+BrRwS4W+ls8pIrKqNJg4SndRLrYsN61A3dHdXIZJPX6KUuITHUMM4CqUKMgoqLPhAdi+eUhIVIDfNlMKigmQdgdF/WzDyomls5tkfaGpoN+cFbxvuowceIQUq0AfaRGSh7q3Mo517LpDVihTXjh7KoS4rMSbBulsTBZ9OHqda/SQT9yITjbaQg0OKYcM6xzqJB+e8l0Kgwysqk83yNLrr74+9A8ujfEUMT/Vr2FBUH6zN6g9Bnypw1sFv0j57wbHhL1wEYZIAgi8Sq8NS8xkxf1yA0VfBReVNiGevPGCRC2B/hHaXu99MdVilNGwMrXZlL4cXfIgr1GebkhKtajXr/j7iTkYnw1S9LcbZ3Nq3mawZpuhYfPpfIgm49CH7Q6Ce4/OrcJRqe5HJBlEbp8Z3O20TB6jtNW90dq1P3pkCLu4Qr3d
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3509C7D82457E07D32C02169D6980@DM5PR0201MB3509.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3509;
 4:BUqzvANFbUBWw2SbSbAQY/lFR2ndXdSrNWvnXIsUBxybNRK97j7Bc47c5XHYyxaBHD+aGNZk8XSPUidzVMgu7Qqi7UXTb320e0wDluSQQXXyX/G/4wg9kgTTBjvAxVpRGAurhvMWxjVwWwlt7mZqFNFyHyejg1LNwvjbHA5oTl7lP2DMDaF6TkKC1sP2c4RCNW1Ib/xgGSQ5OIdFT8TUJp3OUFqX0IO2epTahq3Y9AbgdZff8Ox6I2x/Vd8nSTOJ62PGWVsY1IjDG5yv8fp2DCbYUHEZ/pHu/uXmvhjzll4=
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM5PR0201MB3509;
 23:n2GZRVKPXXt2f06mkpBcsfAG+0OYaeATIIb0dj1?=
 =?us-ascii?Q?SR0YPc3K3MG9cmyPGmpmUA4PSaRO2TIVF+jDDy8M6YNw+JyrvD94df3tgCT3?=
 =?us-ascii?Q?mv66CvOn552tNhOhzPBdgRBSdrAMGkYE5iXJYvijuiYqiMk1BNGckHEAO2qS?=
 =?us-ascii?Q?89XfEl1BxtxTvr0mFMiEOo8Uyeoi2mnPDY9iJftGhX+nyzWS/u1yGxuANKhv?=
 =?us-ascii?Q?g0nU/IGX2ug5ENAFz273KX4Rafi7bjd69uqjrMPCsF0liEisOtm2o+l5OwCW?=
 =?us-ascii?Q?tDoCH+zFfDsITVojYgm9CiH6p9aLdPIvKtzylQhithkQ276+oPZFEoF/LqRM?=
 =?us-ascii?Q?mX5qLjbe8OR0ptQ+iVcYWfBl9uWvKSQDZhxxtY/foCiBHYDj55lWvDR8bqjm?=
 =?us-ascii?Q?QCkaZTmFvdU6kjw0pElAwp7BZ7um1QZEyIvt3O2Ke7Fp017KcyOZ3Oq3urYn?=
 =?us-ascii?Q?hVCZ2XrsIPddMRtS4m9TGAj/Q51jEYdNw+KV/AQCJCDv8oXPCZu0Mm6blvNO?=
 =?us-ascii?Q?Tqh6JyggXw9KU8+u0/XubMsyXbxnye6m0Gluldqqxd40LclbFGbc8guTIMfF?=
 =?us-ascii?Q?dmclQJjqLhZ2ol3fbtgvd90uih4JDOsNT0Jx33SidpvwlSCazHfhX/pO5RNw?=
 =?us-ascii?Q?iimY0/i9J1mw5uIVfGImidCGaa2qIfFpq7ki+PIfqKoWe6XiAQZrdnk69PUi?=
 =?us-ascii?Q?A2lvdMBtcVRt59UgjvKT5EuyaTjsR0e0xEA4en9CLCthBofxnN6nQFrX2MII?=
 =?us-ascii?Q?jc1efrfgzAHDorGe2DqiM4BC+JPonRdbR6SzmR6+NmlgIm1v2hE4KD+DyOD/?=
 =?us-ascii?Q?dGZ7/P0Y8kSIXo40HJzArRvKDwrTZvaLdjeDvpmknBJ+u+RXhrw5impb0uFB?=
 =?us-ascii?Q?M1WEW2QWbED4dxWtzd81wKdPmPAOb7Y9PhLSNZIrOvJxYASQNBJDX0iydSnh?=
 =?us-ascii?Q?+3dtAaAAy91r1r3Gj9CTDw5iQ7b833fEo4YdAB+J3UMF1l4cF9lU9uArfmYl?=
 =?us-ascii?Q?V3vP/0aLXo2UWs+PFRuRdG/hmXwKYWmq0835Hf0w+xFrDupa6r0VpqYALzYd?=
 =?us-ascii?Q?6GuOE/Ak=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MQev77JinmaoRjpEQ29oc9KlwsQyeGFLGAiAJuUmFLuXKOA3lK6bS1QkjshRMDqPd3Tb/EVRdKDHbJwUp6pbg01S5tLmMRbmwV5qNDoEGAP/5TNN7Ht8vKS/LksOC70xR5aEjLQDSNbUB4zRmmep4+K8kUHkKVOixYy9L2B8IIDJl11bOy5b3mmKrjORutH4kWqUtQXHLXXswIi2H+4xskGd0nQ2+ykhYz0C1RxEq4DcNG/5fs++2FZQzZiCBBEIXy9v3Wy587TDbAm3NkFSw83dqLANrEJvhbD2Ky+KlJJAyizrCzaLZhpCr7TmD+2/0ZFN+7PQPkaKY5St+ld/pjJ1T2nt3ND9Iuk/Kc3E08Uv1dbsDMuzW+TlF0/IwmeoJVT9i6buPBseQP+lYVKO9c6nUf+CNcKGYJEUeNKCO5A=
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3509;
 6:Tv3pMqz0G6TWZ0+1H5Ws0i3FEa6je3Uiti5mxicXcpYHOxkZIzCC0IlOOSTH1d/v14iL3zfv7gNpJCBYzmah/TeD4XacldZPP7bRqh55j7kntnR+W5aM28Bi4iEj/VNP7sjHWIXTVS0O+JPBR3Voc66FJ4Cf3ZLTxGGEWjcEvLmySGLugKUrVKXITGwPNlsO4GdApkhsj0XLDw60R/cUmvBgH8IKeThFaEVc9JdGwqG2Dlvf2//9fH2kWJOoki+R7pQioTYi+WCt7WMUwPRUeRZpMFVHRxKAq8qi3zSr97DmM4TNnYApmQuQEwGwbkv3yHb8Q9QlsMT4eozaPdJVnlcaKpUbWIAhvp83BWZMiXomHbXEuanrPmOIjAXxBqSKqd5vcNS8YsVsXSYALXDIqUrr+2OccaBykgVoF93NcyI/+TTALoqgtHuHoMZa+5htteW1sVn8OTBz0NLCphKLkQ==;
 5:BGriApn4epWcbQ9yDw3qyCEy+tyRMqcUGvFKqmUdCal+fLfyWcGytR+0spkOBNlUJsB6nslwFAb0jbuy1dT1dM4iEM9vI4Vln/xg2ZIREqVJKUupPvE8S9YwvPoSGIEioWbAih9uCRvNRO2FehqfvLsjV8dmo1xq8SZqI0kfRy8gmvcUseLB77Wm1kApzsgb01rJq7emFueNggEMApJZRg==;
 7:BruoP5h+3RQQ2bQyhJNirjFyg/0t0mzukyCSoCyKT2D0WL2p/LBi28VLUO3smOvaEUj3SnP3ih1xFC7kJpxXSAgSxSIwX4bXGF03bSaagZCflMFX0YmL08mIe/pVUXDpFupqJ3cPntZYxrSPUvQ9HQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 01:13:38.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc0609b-e6a4-4ed0-ca65-08d68006d711
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_171343_546858_3679A938 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the dt bindings for Xilinx AI Engine, which is a tile processor
with many cores. The compatible string, 'xlnx,mathengine' is kept for
backward compatibility as it's the legacy name.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 .../devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt | 19 +++++++++++++++++++
 MAINTAINERS                                           |  5 +++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
new file mode 100644
index 0000000..fade9d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
@@ -0,0 +1,19 @@
+Xilinx AI Engine
+----------------
+
+The Xilinx AI Engine is a tile processor with many cores (up to 400) that
+can run in parallel. The data routing between cores is configured through
+internal switches, and shim tiles interface with external interconnect, such
+as memory or PL.
+
+Required properties:
+
+- compatible: Must be "xlnx,ai_engine", or "xlnx,mathengine" for legacy name.
+- reg: Physical base address and length of the registers set for the device.
+
+Example:
+
+	ai_engine@80000000 {
+		compatible = "xlnx,ai_engine";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 32d44447..d119d1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16040,6 +16040,11 @@ F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
 F:	include/linux/uio_driver.h
 
+USERSPACE I/O (UIO) DRIVER FOR XILINX AI ENGINE
+M:	Hyun Kwon <hyun.kwon@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
+
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
 L:	util-linux@vger.kernel.org
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
