From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 10:40:29 +0000
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20141215104029.GE11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:55:14AM +0800, Yakir Yang wrote:
> Required properties:
> - compatible: platform specific
> - cpu-of-node: the device node of cpu_dai
> - codec-name: the dw-hdmi codec's device name
> - codec-dai-name: the dw-hdmi codec's dai name

This is not actually a separate physical device from the main dw-hdmi
device.  What you are doing is merely describing the Linux kernel
internals in DT, which is not what DT is supposed to be about.  DT is
supposed to describe the hardware in an operating system independent
manner.

Including details like this (because ASoC needs a separate DT node) is
the wrong approach.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
