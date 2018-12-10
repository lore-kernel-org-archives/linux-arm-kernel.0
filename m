Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F374C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:03:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1A22081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eKjoEpvK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="uUndKzpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1A22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PwbGtK3oGZSjNq1sCAC/Oovte7ENYAHxlEXIUBhTfaY=; b=eKjoEpvKUgIs/3
	rj9ByM5x3ufsX58i/bJIZCSG06+qu3SyWzhomS8EVZTTXqaNf9ht2jzFj2QWmfBvZXdmxBtaG8det
	BCnKUt1RzJjXkxDIfRMIpH4cX2LfLodn7TzbSbr04XRX5WTEfwjqyx8dzQXWr08gdjn0k4lEv1P6d
	T1kpVS3Ah9sn4j3CCpjOZMv8Ktw3VLucWRVxQ8wPnV34FEi7yX0Cl5loei7LRF127d1YrOwGupsdE
	2aoJtJnaVkuO2rIj+7Rc69+lMOCHFsNJghQcmrqf1B/KpHPZxMMAIptSZjNcl6yy1sNg34eZF1ydS
	rnMhCRlwsGdXd3vsIWiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTeB-00013z-Kb; Mon, 10 Dec 2018 22:03:27 +0000
Received: from mail-am5eur03on072c.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::72c]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTe8-0000sQ-KY
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIhZ/gmxiCBsK4w03Gr+V0m+oygNxiWSzsaRJMB8Xug=;
 b=uUndKzpBi+8DAbwEgGwj11K8shwy41jVzdNiWhAqoQT8B1xqTVccBuO5SNF8wIUj9TXzBUhCHpGZk7tPa6Dzm+oq0FWiNHgFNwHFUgi/Lf7PsGriTLdLThxFyrc5glcZMETLubLMSLIRRhSPGCVTGFKRFk5r1dYy8rUa+i1RWvU=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4511.eurprd02.prod.outlook.com (20.178.12.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 22:03:09 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 22:03:09 +0000
From: Peter Rosin <peda@axentia.se>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Thread-Topic: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Thread-Index: AQHUkMv4GPStz0vv3EaV20zFHvdhyqV4hqkA
Date: Mon, 10 Dec 2018 22:03:09 +0000
Message-ID: <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0046.eurprd07.prod.outlook.com
 (2603:10a6:7:66::32) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR02MB4511;
 6:oaYVhTpAzAExfN+DqJSuR1cyeNzfaPxWS2FnpW0CkUHkbO2hICiZhOLVQlBBxDJQGpGFMz635DfMQPJ2Qe1waZbh711YRXN5eK7Q1EZGV4cHchX6JGD6sgeqV5S1YaMAUBHKOV9Lk3G94G2NzqSoC7mmbicWK2i7nCBo2vNTdpwMJOcTjKjUC37F4afDj/uuBDmiy24i0OSk58f4tzIAJTX+1hNSucMo6DepHfBzeI0aCmeaG5FP8PrfRxDTxD6I1n45h47c4d7QQDPFN2YQAJFRnCOVm7JvHj8SqSUd96FN05l411Ql6N4XxPRzDl0R+cDiRxYUoxgcfEEmpJ6BWDw0DozCVndIMEv0L+Jmsgw7Abv8R0DCQqUsQ3YUELh9o+USRIqXRpbkCH9qTeH2sKTousmFVDWhf7vyxNM019Oj8TQBO6zCaa3Z0er0mWI/D/RhmSjPqfddaiePW0DaLA==;
 5:p4i8VMK6x4qP7AgJIG/LhuJlWO1Ns4dAy+LL89Epk4DQTJDbu3keSctHv7nne2IE6wKYjLJa7Lqw9Ib1PYZKxCbqHJRKIRZOupEGNKATjzWumJXLPps3yOZeACgohySTtX4PRMAaugLt30dwkOccz9gLJqknp7L3KId5TrQvG+w=;
 7:DskFJ55wY0OGRx3uey9dLfBpxMAyRWL4xjdXd090rI46K0bIl+2IxPf2VGlfamXkobjZwqNhjwGUQCpNjhIlrKuHjyOE7nlW5o+hSbAz5ZjrK/hR1LYARzcbYJNoODQQXe06xiWcftw+bAQNKzcD7g==
x-ms-office365-filtering-correlation-id: c0c2ecc5-d2aa-4350-04c1-08d65eeb4554
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR02MB4511; 
x-ms-traffictypediagnostic: VI1PR02MB4511:
x-microsoft-antispam-prvs: <VI1PR02MB4511DB31A59D28B3DA36987FBCA50@VI1PR02MB4511.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR02MB4511; BCL:0; PCL:0; RULEID:; SRVR:VI1PR02MB4511; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39830400003)(376002)(346002)(199004)(189003)(14444005)(6506007)(446003)(2616005)(229853002)(65806001)(53546011)(186003)(76176011)(68736007)(102836004)(65956001)(66066001)(486006)(11346002)(2501003)(52116002)(64126003)(99286004)(476003)(386003)(26005)(53936002)(6512007)(6116002)(3846002)(256004)(14454004)(4326008)(105586002)(31686004)(106356001)(7736002)(8936002)(4001150100001)(305945005)(36756003)(97736004)(5660300001)(6246003)(81166006)(74482002)(2906002)(81156014)(86362001)(25786009)(575784001)(8676002)(58126008)(316002)(54906003)(71190400001)(110136005)(71200400001)(6436002)(31696002)(508600001)(6486002)(65826007)(42262002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR02MB4511;
 H:VI1PR02MB5119.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xMAw1DpD8TQqasCPdZZOcdbtENaTKrNUTK+euGEKve7/kWB8JkUX+FKJMjQnla1RYTBDs84m9LQeUX+KuYnXV3oXRRyJE5ZPNUht0+fjxUhWACXzOnjotSY5L1uWNben06BiiL8BmCpn1ju+UM+9z6h+ggDLUr2upBDn3nMwNb3wEqo9kDml6lZroe5ngmSLaa6urxoUSe6QTMCMBBlwG6a1CvnVkStcsGGvb6D6Wyr7ImLS7oktYBgmWv291EEzErCmHAm/oMTNW1SSsjT5R4VOKA9LZ1eosZLhrrvT2/HVxKgYFyx6ZghAqk1k9KC0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <0B06DF676AEA734FB34D0ED6F8043D42@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c2ecc5-d2aa-4350-04c1-08d65eeb4554
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 22:03:09.6325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4511
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_140324_680043_D2BF3CE8 
X-CRM114-Status: GOOD (  21.62  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-10 22:02, Wolfram Sang wrote:
> Some drivers open code handling of suspended adapters. It should be
> handled by the core, though, to ensure generic handling. This patch adds
> the flag and an accessor function.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c | 1 +
>  include/linux/i2c.h         | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 28460f6a60cc..9f89e258c8ff 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1232,6 +1232,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	if (!adap->lock_ops)
>  		adap->lock_ops = &i2c_adapter_lock_ops;
>  
> +	adap->is_suspended = false;
>  	rt_mutex_init(&adap->bus_lock);
>  	rt_mutex_init(&adap->mux_lock);
>  	mutex_init(&adap->userspace_clients_lock);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..9852038ee3a7 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -680,6 +680,7 @@ struct i2c_adapter {
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> +	unsigned int is_suspended:1;	/* owned by the I2C core */

When more stuff is added to this bit field (which always happens at
some point) updates to all members of the bit field will have to use
the same root-adapter-locking, or we will suffer from RMW-races. So
this feels like an invitation for future disaster. Maybe a comment
about that to remind our future selves? Or perhaps the bit field
should be avoided altogether?

Cheers,
Peter

>  
>  	int nr;
>  	char name[48];
> @@ -762,6 +763,14 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  	adapter->lock_ops->unlock_bus(adapter, flags);
>  }
>  
> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap,
> +					      bool suspended)
> +{
> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	adap->is_suspended = suspended;
> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +}
> +
>  /*flags for the client struct: */
>  #define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
>  #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
