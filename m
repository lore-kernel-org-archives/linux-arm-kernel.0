From: tomas.hlavacek@nic.cz (tomas.hlavacek at nic.cz)
Date: Wed, 23 Nov 2016 01:27:31 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479851991.26813.2@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch> <1479586147.10840.0@smtp.gmail.com>
 <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
 <1479851991.26813.2@smtp.gmail.com>
Message-ID: <1479860851.10840.11@smtp.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe!

On Tue, Nov 22, 2016 at 10:59 PM, tomas.hlavacek at nic.cz wrote:
> Anyway I took your patch and tried few things:
> - add pca9538 interrupt-controller
> - add IRQ for 88E1514 PHY - and there is a problem:
...

I thought it over and if I am not mistaken this is not going to work 
anyway, because pca9538 driver causes the GPIO driver to set 
IRQ_NESTED_THREAD, so we can not simply use one of the GPIO expander 
pins as IRQ source for 88E1514, because request_irq() on it will fail 
ultimately.

Tomas
