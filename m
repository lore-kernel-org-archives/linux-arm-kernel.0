From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 07:39:41 +0000
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120220073941.GC22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2012 at 11:27:42PM -0700, Stephen Warren wrote:
> Update gpio.txt based on recent discussions regarding interaction with the
> pinctrl subsystem.
> 
> Previously, gpio_request() was described as explicitly not performing any
> required mux setup operations etc.
> 
> Now, gpio_request() is explicitly as explicitly performing any required mux
> setup operations where possible. In the case it isn't, platform code is
> required to have set up any required muxing or other configuration prior to
> gpio_request() being called, in order to maintain the same semantics.

So what if you need to have the pin as a GPIO, manipulate it as a GPIO,
and then hand it off to a special function, and then take it back as
a GPIO before you shut the special function down ?
