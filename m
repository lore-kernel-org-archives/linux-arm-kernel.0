From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 09:54:01 +0300
Subject: [PATCH v3 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <56318175.6000006@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <048021141f295b0e70c852134d4ac9cc6f7f1da4.1446018918.git.p.fedin@samsung.com>
 <56318175.6000006@samsung.com>
Message-ID: <006b01d11216$9831dc40$c89594c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +	for_each_child_of_node(np, child)
> > +		decode_sromc(srom, child);
> 
> You ignore the return value here so bank may be not configured but
> device probe will return 0.

 Yes, so that banks which are described correctly, will still be configured.

> Maybe clean up and fail the probe?

 I think it's not fatal, so cleanup is not necessary. May be dev_warn() in this case?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
