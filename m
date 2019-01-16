Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3475020866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e6N+ZHBt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ea3Vw7jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3475020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zq5TxOEKlGsJ/KSuLJUNAbpP0FiPDDo+DV9IPL52fw0=; b=e6N+ZHBtQYj3gr
	M2DfD8PNhnvBBe1ZKrzaQmlU/g4j6nb3W6Fj2fJpfyfC73HcLfNbnTggudY1PSUvk8EKlgKrlfal0
	U58PLIAMwhj6RtZl/olfXjP9/BJgNCLB1twGVHvw+Uck4FYC+qCp30brnDPv3GEOoQW0VaYlGO9b+
	+wFypiVVVbDdiBd2yobSNt1z+nEIOar2o0MMQkVFEbWg3UCS1XxMJo9FOmv56wsAp88kTRzurDV33
	q7P6aRMpIRV+GHS+6jHBFVx6GFxRghSsKnXbUmQYGZKf/0ysRNfywPpRvNfZ2/2mUtEvjm3GmEapp
	99elokKR4f/EohG6Ir7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpx6-0001pd-NO; Wed, 16 Jan 2019 18:30:12 +0000
Received: from mail-ve1eur01on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::605]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpx2-0000jD-Bo
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdut22e0eEqgbV9pYHrJQO7bQarqNjcHk5IoK4M6L0g=;
 b=Ea3Vw7jg6tgcP2I2Cf/r9iibbSKVEh2LMfU6MIpS8l9sdujMHmpqeNid8IUa89E8Gj+4g4K7E/2ftH6q698v7iVLGe65X5EbhaSN9cHKeBZshvZmgO0PIGSO79d1fnqi5ocDZa+2R/YGWI5HK2W6Gswj+0sU5LNueGDrp7FIzYw=
Received: from VI1PR08MB4110.eurprd08.prod.outlook.com (20.178.127.212) by
 VI1PR08MB3005.eurprd08.prod.outlook.com (52.133.14.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 18:30:00 +0000
Received: from VI1PR08MB4110.eurprd08.prod.outlook.com
 ([fe80::145a:b30b:415d:d985]) by VI1PR08MB4110.eurprd08.prod.outlook.com
 ([fe80::145a:b30b:415d:d985%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 18:30:00 +0000
From: Marc Zyngier <Marc.Zyngier@arm.com>
To: Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net"
 <jason@lakedaemon.net>
Subject: Re: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
Thread-Topic: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
Thread-Index: AQHUnatcHXmsWWwn7UqNgnfxfE5J9KWyV5+A
Date: Wed, 16 Jan 2019 18:30:00 +0000
Message-ID: <5be38277-3348-a6d9-4b67-3ead308c009a@arm.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-8-lokeshvutla@ti.com>
In-Reply-To: <20181227061313.5451-8-lokeshvutla@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To VI1PR08MB4110.eurprd08.prod.outlook.com
 (2603:10a6:803:e7::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marc.Zyngier@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR08MB3005;
 6:xtJtj5Ki0UC0b6pM4U4s0TnnmDpeDRPEN7yryJkqgLqcI7N6BUZwiwJSwslsasG5oqVA3hTTPeoGT78D5eSKW5+izI78XFLgJccPpi/q7JEVTQ+4AUkh8gQCdtYYPEj9eLPiSx1PCDCz4SUDDuMTH7eaGLu9XtZ71EfchSCiXxsXrGFY2nQMkHW2x0bDeheVj1cp6uQElWXZvmbnVro0muzI/7b6COgbsddcCHa1NVe7FkXj+EqY0Q76hc95d/JRe0oA8trwzsjtTUnsTqfaLiq49y9eCFIvUh0/oklf+Vi5IK4xWw929hBL2GVHXY5Pe/Yyaw+gKdBOFMwvQGpqGI9xdCSIvnLG746WqoEyDml8RR9WcnVXtu4bKpEPyz+pRmn479P6x656+GAqEGYx1/qK3tV7TbEkm1oRAwUPbcONGp/fqCnZv48kHMfA5LDIRWIA1u5xtGm52yD/+egM9w==;
 5:ObbECwnofxf8DQfC2nfbTqKYJp73KZX6VSB+TF9+1oclu/ZiBwe+2hZisONlMZGmUH2jRerOWkjZNC+osJJwkvObdKu6x1yJAVevamBrjKnTJyPK/3YvSxZyA9Xj8llz8uOQ2//lhtierS9ENcOrKuU2CQEOUAYhvklIawIx7AYcHZ16v3DKSgf8Xfd7Ba7+PhAniU7A249Fv5TEPopilQ==;
 7:GS5Yf90q5gUoj+jmxDCCUX4U3ZI+3WT89FNTyk0noizjdhV5ofdHoQRHctdFDjH2oH/yKjXRQyyOIeSFL9pajMtDfxIHV0s6LMUADWQyJNeAixI1FqULNek/UahqNDtHw5fKwYh1xcdr/bPbXIGCxg==
x-ms-office365-filtering-correlation-id: 6dc37863-2896-4b27-55bb-08d67be09f50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB3005; 
x-ms-traffictypediagnostic: VI1PR08MB3005:
x-microsoft-antispam-prvs: <VI1PR08MB3005AC43984899A6C1466CA08C820@VI1PR08MB3005.eurprd08.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(40434004)(189003)(199004)(110136005)(14454004)(54906003)(2501003)(71190400001)(58126008)(7416002)(65806001)(2906002)(478600001)(5660300001)(65826007)(316002)(8676002)(81166006)(81156014)(71200400001)(7736002)(99286004)(65956001)(66066001)(6486002)(6436002)(229853002)(8936002)(305945005)(105586002)(106356001)(11346002)(2616005)(446003)(5024004)(14444005)(486006)(256004)(53936002)(4326008)(31686004)(68736007)(6512007)(476003)(64126003)(102836004)(52116002)(36756003)(76176011)(217873002)(31696002)(86362001)(3846002)(6246003)(97736004)(72206003)(6116002)(44832011)(186003)(6506007)(25786009)(386003)(26005)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3005;
 H:VI1PR08MB4110.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bIkREMUvgKEwN0TC1utglPQkCXPfwV0acZHWytnCAOmeBtGwbmvI/N8B/VHIxT5khRVK598iehMVggkN+Rp2L07md1Y0x1+xHst/aqKdzx0l8ywp03BJJQsBgOeal7au5soKctdqQyWI8/WVWYoYKI1i4dKw0DB7+praYgqEDJ8XCHsCB3uXcP5AqbJO6cFJ9LZBjENz090UY+5PNlJYq12wtPqMRrEeT2T/DdOmoqSFlZXC1D3zGNWS0Wnu/1xcTjwwkduWryc+QIyVJ4c3yyBmULRCyGVgdFoWgixnoGbYOU0EOBSxtttad6oHyv80Sre4BxwEZA0vHjZI+8EL44RqaGrPyaHg5VQjVdCODfW8dmyepvdcesK1oxTHAesPqO5swvn5F3BnCebfLrj2D2dZX966EcUE87TVMz5gZ4A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <B546F36F8956E44E96B785BFE1F9DDC5@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc37863-2896-4b27-55bb-08d67be09f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 18:29:58.7111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3005
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_103008_463746_EF464D0F 
X-CRM114-Status: GOOD (  25.66  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 27/12/2018 06:13, Lokesh Vutla wrote:
> Previously all msi for a device are allocated in one go
> by calling msi_domain_alloc_irq() from a bus layer. This might
> not be the case when a device is trying to allocate interrupts
> dynamically based on a request to it.
>
> So introduce msi_domain_alloc/free_irq() apis to allocate a single
> msi. prepare and activate operations to be handled by bus layer
> calling msi_domain_alloc/free_irq() apis.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  include/linux/msi.h |  3 +++
>  kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
>  2 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 784fb52b9900..474490826f8c 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -301,8 +301,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>   struct msi_domain_info *info,
>   struct irq_domain *parent);
> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
> + struct msi_desc *desc,  msi_alloc_info_t *arg);
>  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>    int nvec);
> +void msi_domain_free_irq(struct msi_desc *desc);
>  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index ad26fbcfbfc8..eb7459324113 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>  return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
>  }
>
> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
> + struct msi_desc *desc,  msi_alloc_info_t *arg)
> +{
> +struct msi_domain_info *info = domain->host_data;
> +struct msi_domain_ops *ops = info->ops;
> +int i, ret, virq;
> +
> +ops->set_desc(arg, desc);
> +
> +virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
> +       dev_to_node(dev), arg, false,
> +       desc->affinity);
> +if (virq < 0) {
> +ret = -ENOSPC;
> +if (ops->handle_error)
> +ret = ops->handle_error(domain, desc, ret);
> +if (ops->msi_finish)
> +ops->msi_finish(arg, ret);
> +return ret;
> +}
> +
> +for (i = 0; i < desc->nvec_used; i++) {
> +irq_set_msi_desc_off(virq, i, desc);
> +irq_debugfs_copy_devname(virq + i, dev);
> +}
> +
> +return 0;
> +}
> +
>  /**
>   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>   * @domain:The domain to allocate from
> @@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  struct irq_data *irq_data;
>  struct msi_desc *desc;
>  msi_alloc_info_t arg;
> -int i, ret, virq;
> +int ret, virq;
>  bool can_reserve;
>
>  ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
> @@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  return ret;
>
>  for_each_msi_entry(desc, dev) {
> -ops->set_desc(&arg, desc);
> -
> -virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
> -       dev_to_node(dev), &arg, false,
> -       desc->affinity);
> -if (virq < 0) {
> -ret = -ENOSPC;
> -if (ops->handle_error)
> -ret = ops->handle_error(domain, desc, ret);
> -if (ops->msi_finish)
> -ops->msi_finish(&arg, ret);
> +ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
> +if (ret)
>  return ret;
> -}
> -
> -for (i = 0; i < desc->nvec_used; i++) {
> -irq_set_msi_desc_off(virq, i, desc);
> -irq_debugfs_copy_devname(virq + i, dev);
> -}
>  }
>
>  if (ops->msi_finish)
> @@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  return ret;
>  }
>
> +void msi_domain_free_irq(struct msi_desc *desc)
> +{
> +irq_domain_free_irqs(desc->irq, desc->nvec_used);
> +desc->irq = 0;
> +}
> +
>  /**
>   * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>   * @domain:The domain to managing the interrupts
> @@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>   * enough that there is no IRQ associated to this
>   * entry. If that's the case, don't do anything.
>   */
> -if (desc->irq) {
> -irq_domain_free_irqs(desc->irq, desc->nvec_used);
> -desc->irq = 0;
> -}
> +if (desc->irq)
> +msi_domain_free_irq(desc);
>  }
>  }
>
>

I can see some interesting issues with this API.

At the moment, MSIs are allocated upfront, and that's usually done
before the driver can do anything else. With what you're suggesting
here, MSIs can now be allocated at any time, which sounds great. But how
does it work when MSIs get added/freed in parallel? I can't see any
locking here...

It is also pretty nasty that the user of this API has to know about the
MSI descriptor. Really, nobody should have to deal with this outside of
the MSI layer.

The real question is why you need to need to allocate MSIs on demand for
a given device. Usually, you allocate them because this is a per-CPU
resource, or something similar. What makes it so variable that you need
to resort to fine grained MSI allocation?

Thanks,

M.
--
Jazz is not dead. It just smells funny...
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
