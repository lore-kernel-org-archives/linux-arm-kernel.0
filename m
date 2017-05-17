From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 May 2017 14:06:56 -0300
Subject: [PATCH 1/2] ARM: dts: imx23-sansa: Remove 'enable-active-low'
 property
In-Reply-To: <764037594.21665.1495040359199@email.1und1.de>
References: <1495039381-23126-1-git-send-email-fabio.estevam@nxp.com>
 <764037594.21665.1495040359199@email.1und1.de>
Message-ID: <CAOMZO5BOu=qKuokq6st_=BOjxO9=nX6VGaTdWX444xCX3oddUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, May 17, 2017 at 1:59 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> GPIO_ACTIVE_LOW = 1, GPIO_ACTIVE_HIGH = 0

Correct.

> So this doesn't look save to me.

gpio regulator driver does not look for the gpio flag field, so this
change is safe.

That's the reason there is a property called 'enable-active-high'.

When 'enable-active-high' is passed the gpio regulator is active high.
If the property is absent then it is active low.

This is explained in
Documentation/devicetree/bindings/regulator/fixed-regulator.txt

Passing GPIO_ACTIVE_LOW describes the gpio regulator correctly in this case.
