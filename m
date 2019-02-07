Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD0EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA24C2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxoCud8l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="MtdOJoNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA24C2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T5xHNUq42W9f/Vv72mgrRPz0veH1qhcyPBaxM7KtH98=; b=SxoCud8ldHMczP
	2uHOHH6BvlQczKPYDYmFm1414PonCPt8sm/jq9wnnLV5ILkJ5sRQrvfLKf3XC9uh38GYUIB0iUZa4
	iG7jgDaQ2qA2BPFItYOXhF7jnEdXLk+icD9iY+5DhNCVnKQI3dbHNPvbJASIMs5ITrlWG3idzvEXb
	joKQav7XF07DE2tfUpeJWfKJVj7o1IL/ezAyNlQ4Ll40ESQ4YfAkxzVRT37951HzJ5Fd0xeUuWhI0
	RLeWYEXz15ZH7WkT1jptyy9YmgAZcgglZN2FLiTie/0c85KF6WDYuRDHNgnpF7tjuF2AB1mZ8y3jg
	sKod/cFfgzCrecPhh5Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grogA-0003Te-V4; Thu, 07 Feb 2019 18:45:42 +0000
Received: from mail-eopbgr790127.outbound.protection.outlook.com
 ([40.107.79.127] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grog7-0003Sk-VZ
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 18:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogK8PJCWrRmTGGLX05NwNaxXwnQRfZrQWSgqJDClqP4=;
 b=MtdOJoNuaFy+bML4wTF4sygroRbryBaNx8NrD/Z5KKxAGh+Nw0NTxL5gkFWtrNQj2y3iLah9d2Q488P0XJI/Gns4NPnCP1XF9DZAF4l/GQutfXI1qKrwjA0HVPFBzbsareBe4pPI4HnCdDxsyZ0YbhYSqsVcMnpLnLMFwwsUXQg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 18:45:34 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:45:34 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "kishon@ti.com" <kishon@ti.com>, "m-karicheri2@ti.com"
 <m-karicheri2@ti.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Thread-Topic: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
Thread-Index: AQHUvtjusOUgN2+phkW0ohl7bu9V7qXUrOqA
Date: Thu, 7 Feb 2019 18:45:34 +0000
Message-ID: <1549565133.3075.53.camel@impinj.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com>
In-Reply-To: <20190207110924.30716-9-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3771;
 6:4D4lrA854c7G+0dHHrT+q7ffv07cIuJCOKaew2PrejLjQY3NdUU1D3PYtk5KJ3BXFX2t7le4+zubQicNsfFWDD9g+VVivW4y9NinAQB0eIvi8K1OQ/lPOHTHn2e26vpcDkoi+sI6eWy8CT04g21y8HsJY2cUj7VE5zmR2UHLesECMxz1V+8mdSakX5uKkn16EageV/BIUtXfyIZxtvJwGyStJWMaglyKkQ7pwSUBpRsHXULl0DlEt/Iy81gsmDHZ9YEz20klHR4SQzU0b/NE4ls4q2Xnk2WvP/12PZwAL11GYz+WSIp8ZNN+Kx8OTPBo/BJn2x7fRx5C4bljLf2OTR9DYk0eSWkwnVxW4fRfpNkKK/eFonEuv9okkvpAVFALC2vUa8DHxvTktA9rMu3WfixFVakpMHqpHSizqKGqbBifEzPOhnfojRxU4rImgysqkywyQWE2r3eBGrqZ9kuY0Q==;
 5:AAlFoiFxmVpbn6fsOasnJuYz4z2f3FU5GvWghjvTd+Rgh2qGX0rf2RiXVY0Yd7Gt4ciws/zNEDa6uEuS42cKTJF5djywG5jFo+6mXIIac//k9KypSgsP0LPUJgvJSywhE8ZAomXYPsiT1e+Mc50o9k6eUd+oEchQcuH7FG7mJyjOkxzD9zCe7Yqq8gCGGbbZKAm9BiFYSWVIyxLshShlAA==;
 7:5LmJLF21U1YVL1LifBnualGmn6RK+zcHkQ1PjFfJ0+KMTiiNdJ6PdiKrc6+leyNbBolgtnZ8he8sY/NdiL6a3GOdBA+KeUykYUqEgRtIto7rm9jRm7jQ8nbcAqdrYev1f3JVW4CnSGhE2wPTs5TSIQ==
x-ms-office365-filtering-correlation-id: fd4c9f55-6da3-4f3a-7787-08d68d2c71ac
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3771; 
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-antispam-prvs: <MWHPR0601MB3771D869331D9EDDB951F9A7D3680@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39850400004)(189003)(199004)(76176011)(486006)(305945005)(2501003)(25786009)(186003)(6512007)(71200400001)(26005)(71190400001)(99286004)(6436002)(2616005)(6246003)(476003)(446003)(11346002)(68736007)(7736002)(2201001)(53936002)(229853002)(6486002)(66066001)(4326008)(8936002)(2906002)(97736004)(54906003)(14454004)(110136005)(6506007)(3846002)(81156014)(8676002)(105586002)(102836004)(81166006)(106356001)(36756003)(6116002)(14444005)(316002)(256004)(478600001)(103116003)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3771;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PWh3C31cbKSXtYmJ9s4t0dfDjo9aPBOkzf23EPa4aQNTSI29RInAnGO/snqB75eGkfPPLUEypVXe6sGu5AM6HQwj2va7I4VYSF+1RawWt3IyMA9cK1ETbv32ub74vDkm4DpvV/E+UyKNWWGl8iuqsZyjnGl3/gQymotWabYRV42Lnha378ocgqE/y5JhTdOWEjp7MnGP0sjXbdtbroQNNGVB35npbN7dGXpgqqvfiiB1KWbAcwdkb53ehcGf3VPMnXj5Jn8hPm/2B7FSdwwehI59Si+JmF0Ow+p35ijFJRkMN5ZkXXhFmj2sWqcExMcdmiWl1DhxK7HUSba7K3/wk331dIPr3jvbEGOxyRe6z/Jue7KUfEn9xE86yetbkGvriwpWZQCYVOE1BR02PKiv+qhHDlr4YCPh5or/qydQcwI=
Content-ID: <A5FC425849E5474AA3C97681FF948F57@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c9f55-6da3-4f3a-7787-08d68d2c71ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:45:34.3498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_104540_021749_04A708C2 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-07 at 16:39 +0530, Kishon Vijay Abraham I wrote:
> Now that Keystone started using it's own msi_irq_chip, remove
> Keystone specific callback function defined in dw_pcie_host_ops.
> 
> @@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>  
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>  
> -	if (pp->ops->msi_irq_ack)
> -		pp->ops->msi_irq_ack(d->hwirq, pp);
> -
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }

After this patch, the entire function now looks like:

dw_pci_bottom_ack(struct irq_data *d)
{
        struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
        unsigned int res, bit, ctrl;
        unsigned long flags;

        ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
        res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
        bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;

        raw_spin_lock_irqsave(&pp->lock, flags);

        dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);

        raw_spin_unlock_irqrestore(&pp->lock, flags);
}

The spin lock isn't necessary anymore since there is nothing but a
single register write inside the critical section.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
