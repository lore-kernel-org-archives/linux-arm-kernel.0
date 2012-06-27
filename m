From: stigge@antcom.de (Roland Stigge)
Date: Wed, 27 Jun 2012 17:25:28 +0200
Subject: [PATCH v7] MTD: LPC32xx SLC NAND driver
In-Reply-To: <CAAAP30HemOV9svhVghLTWfZe95=P3CT-H7UsQ=xY6rC8=AfBsA@mail.gmail.com>
References: <1339064536-20553-1-git-send-email-stigge@antcom.de>
 <1340794007.29342.50.camel@sauron.fi.intel.com> <4FEAF90B.5030809@antcom.de>
 <CAAAP30HemOV9svhVghLTWfZe95=P3CT-H7UsQ=xY6rC8=AfBsA@mail.gmail.com>
Message-ID: <4FEB25E8.5060706@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 06/27/2012 02:26 PM, Alexandre Pereira da Silva wrote:
> I think it's best in case of *_raw to use nand base default functions,
> like in the MLC patch.

Problem here (specific for this SLC controller) is that it expects us to
access the data register via 16bit access while the actual data is only
8bit wide.

This can't be done with the default nand functions, neither with the
8bit nor 16bit variant.

Roland

PS: Nevertheless, I will post our SLC driver update series against the
l2-mtd branch.
