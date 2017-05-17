From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 May 2017 19:52:59 +0200 (CEST)
Subject: [PATCH 1/2] ARM: dts: imx23-sansa: Remove 'enable-active-low'
 property
In-Reply-To: <CAOMZO5BOu=qKuokq6st_=BOjxO9=nX6VGaTdWX444xCX3oddUA@mail.gmail.com>
References: <1495039381-23126-1-git-send-email-fabio.estevam@nxp.com>
 <764037594.21665.1495040359199@email.1und1.de>
 <CAOMZO5BOu=qKuokq6st_=BOjxO9=nX6VGaTdWX444xCX3oddUA@mail.gmail.com>
Message-ID: <1348922230.22889.1495043579279@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Fabio Estevam <festevam@gmail.com> hat am 17. Mai 2017 um 19:06 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Wed, May 17, 2017 at 1:59 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > GPIO_ACTIVE_LOW = 1, GPIO_ACTIVE_HIGH = 0
> 
> Correct.
> 
> > So this doesn't look save to me.
> 
> gpio regulator driver does not look for the gpio flag field, so this
> change is safe.
> 
> That's the reason there is a property called 'enable-active-high'.
> 
> When 'enable-active-high' is passed the gpio regulator is active high.
> If the property is absent then it is active low.
> 
> This is explained in
> Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> 
> Passing GPIO_ACTIVE_LOW describes the gpio regulator correctly in this case.
> 

Thanks for this explanation, this wasn't clear to me from the subject / commit log.
