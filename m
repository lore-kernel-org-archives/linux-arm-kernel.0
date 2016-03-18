From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 18 Mar 2016 16:05:43 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318143059.GD8005@lunn.ch>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <20160318143059.GD8005@lunn.ch>
Message-ID: <56EC1947.2030201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Le 18/03/2016 15:30, Andrew Lunn a ?crit :
> I don't know crypto to well. Is there a good test case? Something
> simple to setup and run. I can test on kirkwood and Dove using the
> hardware i have.
>

You can test it by using the crypto test manager: 
CONFIG_CRYPTO_DEV_MARVELL_CESA=y and CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n


It will enable some cryptographics tests when the driver will be loaded,
if everything works as expected, you should not have errors.


You can also test it by using the tcrypt driver :

$ modprobe tcrypt mode=<code>

You mode 402,403 and 404 for hash and mode 500,501,502 for cipher.

Note: some tests might fail for cipher because not all mode of 
operations are supported (like ofb or cfb).


Regards,
Romain
