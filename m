From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 16:39:18 +0100
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <CAN1soZy7jB_H0meVyh_H8nmbaSDmiDpjBYi_WO=pmjYzEf9r6Q@mail.gmail.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
 <4F732C97.2030804@compulab.co.il>
 <20120328152743.GW3232@opensource.wolfsonmicro.com>
 <CAN1soZy7jB_H0meVyh_H8nmbaSDmiDpjBYi_WO=pmjYzEf9r6Q@mail.gmail.com>
Message-ID: <20120328153918.GX3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 11:37:37PM +0800, Haojian Zhuang wrote:
> On Wed, Mar 28, 2012 at 11:27 PM, Mark Brown

> > These don't look like good fixes, you should be specifying the
> > dev_name() for the consumer device? ?Presumably it's two separate
> > consumers and should be .0 and .1 or something?

> Could you do a quick update on dev_name() according to Mark's comment?

> -REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
> +REGULAOTR_CONSUMER(ldo10, dev_name(&pxa_device_mci.dev), "vcc sdio");

No, you're missing the point again.  As I said previously the whole
point of this interface is that you don't have to have access to the
struct device.  This should be the string *returned* by dev_name(), not
a direct call to dev_name().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/7ab84218/attachment.sig>
