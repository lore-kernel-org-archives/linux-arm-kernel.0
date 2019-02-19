Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F902C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB1021848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTGug5LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB1021848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GWQmY5YwkYWAPZqWifGbD6cmbIL1ZZW9Wu7jFivgi4w=; b=jTGug5LYpXp3decjiPgz+UumG
	/cNTLimMmPANwYJbOI2ynKUrbcLyjU2a7Dqv4H8VjdkT5bIDYmNEyAJp1ud2GPtZO55anjIpkQdnr
	jmw6rYDzff+Vtw2xFEjFQ5SvaNKVxn18/5+jwLL3s1axWnxIcDZnns3N51TNEOnUx+JK/PjbDLQK/
	Z4AyfsiMuK6kyCg2yZe41AT2lZYlu2SznSE52W/fXopEFtuueuEcZziob39+DrhE6mw7bDzj0Wtto
	JCqdLi31uVEXBMj0WLjG15jCOD7frY+msitCUz6yA5t9gZ7IGt79lscMfCwfgwpILcdlb58csk/O0
	PCw+LUqNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw03I-0003u5-LN; Tue, 19 Feb 2019 07:42:52 +0000
Received: from olimex.com ([184.105.72.32])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw03E-0003rj-MA
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:42:50 +0000
Received: from 195.238.85.143 ([195.238.85.143]) by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 18 Feb 2019 23:42:42 -0800
Subject: Re: [PATCH v2 1/8] leds: Add support for AXP20X CHGLED
To: Pavel Machek <pavel@ucw.cz>, Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-2-stefan@olimex.com>
 <20190215155732.nmtshldcjk2qyhx4@flea> <20190215183239.GB3280@amd>
From: Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <5fdac512-947d-fd46-d953-22d6fc837423@olimex.com>
Date: Tue, 19 Feb 2019 09:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215183239.GB3280@amd>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_234248_720592_87085F39 
X-CRM114-Status: GOOD (  19.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Stefan Mavrodiev <stefan@olimex.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2/15/19 8:32 PM, Pavel Machek wrote:
> Hi!
>
>> On Fri, Feb 15, 2019 at 01:50:06PM +0200, Stefan Mavrodiev wrote:
>>> +static ssize_t control_store(struct device *dev, struct device_attribute *attr,
>>> +			     const char *buf, size_t size)
>>> +{
>>> +	struct led_classdev *cdev = dev_get_drvdata(dev);
>>> +	struct axp20x_led *priv = to_axp20x_led(cdev);
>>> +	unsigned long val;
>>> +	int ret;
>>> +
>>> +	ret = kstrtoul(buf, 0, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/**
>>> +	 * Supported values are:
>>> +	 *   - 0 : Manual control
>>> +	 *   - 1 : Charger control
>>> +	 */
> ...
>>> +static struct attribute *axp20x_led_attrs[] = {
>>> +	&dev_attr_control.attr,
>>> +	&dev_attr_mode.attr,
>>> +	NULL,
>>> +};
>>> +ATTRIBUTE_GROUPS(axp20x_led);
>> I can't really say whether adding sysfs handles for this is the right
>> thing to do, but if it is you should document the interface.
> It is not. See "Add Intel Cherry Trail Whiskey Cove PMIC LEDs" thread
> in the last few days.

What I understood is that there will be changes in the LED core, exporting
a new sysfs entry "hw_control". Then I should set HW_CONTROL flag for the
device and add hw_control_get/set callback functions. And this can happen
when the LED core is updated. Right?

However I didn't understand how (in my case) hardware controlled pattern
will be selected?

Best regards,
Stefan Mavrodiev

>>> +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
>>> +		priv->ctrl = AXP20X_CHGLED_CTRL_CHARGER;
>>> +		priv->mode = (value < 2) ? value : 0;
>>> +	} else {
>>> +		priv->ctrl = AXP20X_CHGLED_CTRL_MANUAL;
>>> +	}
>> I'm not sure we want to make this a property of the device
>> tree. Changing the device tree isn't an option for some users, so we
>> need to make sure we can change it even if we can't change the device
>> tree.
> We want this to be configurable at run time. It can get default from
> the device tree.
>
> If we go for the "hardware" trigger, you'll get it for free.
>
> Best regards,
> 								Pavel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
