From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Aug 2012 13:20:03 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <20120823113922.GZ7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
Message-ID: <20120823121936.GA1047@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I say I don't understand the motivation for this change.  All the modern
> DT bindings are perfectly happy handling this without an explicit shim
> in the device tree to bodge things for Linux, adding them in seems like
> it'd be a retrograde step.  What benefit do you believe this brings?

How do the all the other DT:ed audio drivers handle the PCM then? More
importantly, how would you like to see it handled? Ola has NACKed this
patch and explained why:

"I'm sorry but this patch is breaking the design of ASoC. The ASoC-
platform is the DMA-block (in combination with the MSP-block), and
there should be a platform-driver for the DMA/PCM. The platform-driver 
then has a DAI which is the MSP. The ASoC DAI-link-struct should have
one driver for each of these, so the dummy-driver for PCM should be
there."

So I don't really know where to go with it. Any ideas?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
