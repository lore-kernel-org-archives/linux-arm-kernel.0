From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Jul 2012 13:03:51 +0200
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
In-Reply-To: <201207121554.03240.arnd@arndb.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de> <201207121554.03240.arnd@arndb.de>
Message-ID: <50000097.9010902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> They look like they mostly export register settings which is usually
>> questionable since we might want to abstract bindings so they can be
>> useful for a number of drivers.

I'm not exactly sure what you mean by this. These bindings are specific 
to the ST-Ericsson driver and are localised, hence the 'stericsson,' 
vendor prefix. If you think other drivers might be able to make use of 
them then we can make them official i2c bindings and drop the 'stericsson,'.

>> Arnd, since you committed the patches, can you please comment? I'd
>> prefer to drop this DT conversion for now, otherwise we might have to
>> support this possibly rushed bindings forever? LinusW, what do you
>> think?

We would never have to support them forever. Even if they were deemed to 
be incorrect, or some other vendors wanted to use the same bindings, we 
would just send a patch fixing them.

> I've dropped the ux500/dt branch for now. and will wait for a new one
> to get submitted as a replacement. There were other things wrong with
> the submission that Lee already knows about, so I think it's better
> to do this the proper way now.

Okay, I've pulled the i2c patches out. I'll re-send the pull-request 
(less the i2c stuff) when we have an Ack from Sam on the AB8500 
documentation patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
