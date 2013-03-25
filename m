From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Mar 2013 20:09:08 +0100
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <51509873.1010408@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
Message-ID: <20130325190908.GC631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Please could you add a comment in the code about which piece is
> > specific to ARM, because its not obvious to me. Its not like there is
> > a reference to WFI for example. It looks like this code could go in
> > drivers/cpuidle/cpuidle.c
> 
> Yes, I agree. At the first glance, the code, as it is, could go in this
> file but more ARM specific code will be moved to this ARM generic code
> driver like device tree description and couple idle states. The init
> function would be more arch specific then.

Hi Daniel

There was a discussion about device tree bindings when i posted
the kirkwood cpuidle driver, now in drivers/cpuidle/cpuidle-kirkwood.c.

The conclusion was that pseudo devices, like cpuidle, do not have DT
bindings. They can check of_machine_is_compatible(), like
cpuidle-calxeda.c does, or they are platform drivers, which is what
cpuidle-kirkwood.c is.

Even if DT binding was allowed, it again should not be ARM specific.

Are coupled idle states ARM specific?

     Andrew
