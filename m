From: slash.tmp@free.fr (Mason)
Date: Tue, 10 Nov 2015 13:44:48 +0100
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <yw1xh9kv5c60.fsf@unicorn.mansr.com>
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr> <yw1xtwov5gh1.fsf@unicorn.mansr.com>
 <5640C4BF.2010204@free.fr> <yw1xpozj5ezj.fsf@unicorn.mansr.com>
 <5640D1F3.1010100@free.fr> <yw1xh9kv5c60.fsf@unicorn.mansr.com>
Message-ID: <5641E6C0.8090507@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2015 18:13, M?ns Rullg?rd wrote:

> Add something like this:
> 
> static const struct of_device_id tangox_sdio_dt_ids[] = {
> 	{ .compatible = "sigma,tangox-sdio" },
> 	{ }
> };
> 
> static struct platform_driver tangox_platform_sdio0 = {
> 	.probe		= sdhci_tangox_probe,

It looks like one side effect of this transformation is that
the probe function cannot be __init anymore? Is that correct?

For this one particular driver, it weighs 944 bytes. (I guess
a few kilobytes wasted is no big deal...)

Regards.
