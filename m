From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 20:50:04 +0000
Subject: [PATCH] dts: cubox: Map gpio-keys and pps-gpio to gpio3 8
In-Reply-To: <1426538201-7571-1-git-send-email-george.joseph@fairview5.com>
References: <1426538201-7571-1-git-send-email-george.joseph@fairview5.com>
Message-ID: <20150316205004.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 02:36:41PM -0600, George Joseph wrote:
> The Cubox has a recessed button between the HDMI and RJ-45 connectors
> that wasn't mapped in the device tree.  Since the button is normally
> open and there's no external pull up/down, that pad (EIM_DA8) can be
> used for almost anything so I've mapped it to gpio-keys BTN_0 and
> pps-gpio.  Whichever driver claims it first wins.  If both drivers
> are build as modules, you can even switch between them at run time
> and the pinmux will adjust the pin configuration as required.
> If neither driver claims the gpio, it's still available in the normal
> gpio sysfs.

I wonder why we want to have the PPS support in mainline, given that
you would need to solder to the board to make use of that.  I can see
the point of the gpio-keys going into mainline, but not the PPS bit.
That's more like a local hack.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
