Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03785C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:50:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ED6217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jm9KMG2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ED6217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/E3wjTX2qlGDFBfLMy0Bdx9MSbvCecCQfG1YDmgjsHU=; b=jm9KMG2GY0jWsB2oRLW6BWjTD
	YaUChJDW9bOqayY3NWrrWFwXsOr8Yf56GG/Tlm4WiGxTbt6fcpr2ZtrtswTKB6Sa3RxdPOlKJQCXl
	2c6O6GzTmFd8BS7YV3XVv40wkqR/IAfq9WGH64jbUY0FOSCMTFV8Mop5FLU+6EmMiehWmdrMQmHkW
	SiHP2hmrDz4GBn2Ti/L5HRyQ7vm5pu0LaxAj5gQBJi70Ma9VacNHH8jwHYBEwMvACnXKXKG7qgLqe
	oPOdWp0mlMQiJq55/rxFVHQomMIItDHJeV+cmDsbe+Fo+FIMolZNXsQbbXAKiV4YKF/pZYxjKBNwe
	fy3qtL1WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf9wN-0006Wb-4Y; Thu, 03 Jan 2019 20:50:07 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf9wJ-0005mh-EZ
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:50:04 +0000
Received: by mail-ed1-f68.google.com with SMTP id d39so30084674edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 12:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rI9uISVGVVHqNmyfmz3DgDa0kUGfsZ+ichOdFy8rec0=;
 b=J3ftl4e1hiMmTnuPKA6vL/6dehtH6LOG114K+QhRcpEJDXqAU0o3Lpo8rS48WJhEeF
 dZ+lcQyT/kHIKDKtn39uDwgoa6AscnIXPStRhmvI9Jmh99VFJHf1ghBDdqvkzcqivISU
 sJzicz07a5uj+xPGBubjJ/acsTSHHLK97x84jKwBDJ7Teoc0ycvamrCG0b1XbhFP3L8o
 jHO8w6byMdlCAb5fNhauEEmT++DY9jgeoeHjxuDVenQ+r7J1f//hiQG/6abttL4/2Z9e
 wWqjea+sr42rTz3i2cX2xiXAiKWyxNKWHkKWRkpur/U7SJC6z6IhAQXWUmhDJmxJhmZX
 8O4Q==
X-Gm-Message-State: AA+aEWb4Lal0TLTuTjBv3hM0pGl3gEppAMXRdwi0TuFK3ZAo1R9sKObn
 Y7AxijcJonbM15q1GpHvxPyHQMAbRxk=
X-Google-Smtp-Source: AFSGD/WLYV03334aMKjzD7t9W9iWS3grz3VXwHEFKHunHr0pqloTc+lHS519wpqVDfsOV1psuTSsdQ==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr44096499edk.272.1546548600182; 
 Thu, 03 Jan 2019 12:50:00 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id f20sm23506313edf.19.2019.01.03.12.49.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 12:49:59 -0800 (PST)
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
To: Wolfram Sang <wsa@the-dreams.de>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
 <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
 <20190103185917.zfcw24n5w4n4qu2q@ninjato>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <03b8e4ab-412e-24cf-9c79-5939896b3008@redhat.com>
Date: Thu, 3 Jan 2019 21:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190103185917.zfcw24n5w4n4qu2q@ninjato>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_125003_495314_E2D73088 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 03-01-19 19:59, Wolfram Sang wrote:
> 
>> I share your desire to have the check for this shared in core code,
>> but I'm afraid that just is not going to work.
> 
> Okay, so this series is definately not it. Probably the previous one
> which exposes helpers is not a bad idea after all. Because it is
> ulitmately the driver's decision when to use the helpers...

Agreed.

Regards,

Hans


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
