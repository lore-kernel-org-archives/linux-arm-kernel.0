From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Oct 2012 11:34:07 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
Message-ID: <20121030113407.GA24335@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 09:12:52PM +0100, Linus Walleij wrote:

> The answer is that it does not know. Because drivers have
> different needs. Depending on how the hardware and
> system is done.

...

> I'm not making this up, it is a very real phenomenon on the
> Ux500 and I don't think we are unique.

> Moving this handling to bus code or anywhere else
> invariably implies that resource acquisition/release order
> does not matter, and my point is that it does.

Doing this in the buses is definitely wrong, as you say it's not bus
specific.  I do however think we can usefully do this stuff in a SoC
specific place like a power domain, keeping the SoC integration code
together and out of the drivers.  IME the SoCs where you need to do
different things for different IPs shoudl mostly still get some reuse
out of such an approach.
