From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Mar 2017 08:53:34 -0500
Subject: [PATCH 05/15] ARM: dts: imx: fix PCI bus dtc warnings
In-Reply-To: <20170322081942.GM3443@dragon>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-5-robh@kernel.org>
 <20170322081942.GM3443@dragon>
Message-ID: <CAL_JsqKmbLP07zKN1SJAoe0xHjzjn80HQDRvqASXvhnUOBgAyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 3:19 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Mar 21, 2017 at 09:03:03PM -0500, Rob Herring wrote:
>> dtc recently added PCI bus checks. Fix these warnings.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>
> Applied with a couple of changes below.

Thanks. BTW, forget to mention there's still one i.MX warning I did
not fix. It's with the "sky2 at 8" PCI device node. The unit address is
completely wrong. The comment says bus #8 which doesn't seem right
either. The unit address should be "<device num>[,<function]". There
should be a reg property which also has the bus number.

Rob
