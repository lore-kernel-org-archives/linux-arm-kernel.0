From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Nov 2013 14:36:41 +0000
Subject: [PATCH 1/3] mfd: tps6586x: add version detection
In-Reply-To: <20131127143429.GN3296@lee--X1>
References: <cover.1385508112.git.stefan@agner.ch>
 <ef881d39f78b75b4badeebb5be0264edc3906d86.1385508112.git.stefan@agner.ch>
 <20131127130954.GF3296@lee--X1>
 <cd69295e946b48451f449eacc02efa4a@agner.ch>
 <20131127135547.GK3296@lee--X1>
 <cfb203a896eda67c106794d89e668d56@agner.ch>
 <20131127143429.GN3296@lee--X1>
Message-ID: <20131127143641.GO3296@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-adding the list.

Please remember to 'reply to all' when discussing patches.

> > >> Hm, when the device is not answering on that request, the probe method
> > >> should fail I would say. This means that the device is missing most
> > >> likely. However, I should set the device version to TPS6586X_ANY if I
> > >> happen to end up in the default case.
> > > 
> > > I would say that returning an error is the sound thing to do, but I'm
> > > missing the point of TPS6586X_ANY, as it doesn't appear to be used in
> > > this context.
> > > 
> > 
> > Yes, its mainly used in the regulator code later on. I do assign voltage
> > table to TPS6586X_ANY, if its the appropriate table for any version of
> > the device. 
> 
> <snip>
> 
> > Ok, will change this. Setting the version to TPS6586X_ANY in the default
> > case is anyway not a good idea since it would suppress unknown versions.
> 
> Perhaps I should suggest to make TPS6586X_ANY a positive number then,
> as a negative value to me indicates more of an error than a generic
> parameter.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
