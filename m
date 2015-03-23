From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 23 Mar 2015 17:38:57 +0100
Subject: [PATCH 03/10] ata: at91: use syscon to configure the smc
In-Reply-To: <550FE6D7.6000107@atmel.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426545886-19162-4-git-send-email-alexandre.belloni@free-electrons.com>
 <550FE6D7.6000107@atmel.com>
Message-ID: <20150323163857.GA20732@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/2015 at 11:11:35 +0100, Nicolas Ferre wrote :
> Le 16/03/2015 23:44, Alexandre Belloni a ?crit :
> > Use syscon/regmap to configure the smc. This allows to avoid using
> > at91sam9_smc.h and to compile the driver in a multiplatform configuration.
> > 
> > The driver will still not probe until the proper DT bindings are added.
> 
> Alexandre, just for the record, can you describe the DT node that will
> match this?
> Is it one that will be added to
> Documentation/devicetree/bindings/mfd/atmel-smc.txt?
> 

I believe it should be documented when the full binding will be defined.
This binding will include a mandatory property:
 atmel,smc: phandle to the smc

and will look like:
 atmel,smc = <&smc>;


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
