From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 30 Jul 2012 08:40:58 +0200
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <20120730011426.GB30774@S2101-09.ap.freescale.net>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <20120728133215.GG2128@S2101-09.ap.freescale.net>
 <5015624D.50305@googlemail.com>
 <20120730011426.GB30774@S2101-09.ap.freescale.net>
Message-ID: <50162C7A.1060307@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2012 03:14, Shawn Guo wrote:
> On Sun, Jul 29, 2012 at 06:18:21PM +0200, Dirk Behme wrote:
>> Hmm, sorry if I missed anything, but how is adding a 'default ..
>> SOC_IMX6Q' related to any defconfig? If you want to deselect
>> SOC_IMX6Q using the way you like you'll get the standard 256 (if I
>> remember correctly).
>>
> I'm essentially questioning about the point of the patch.  It intends
> to save a little space for imx6q build without caring about imx3 and
> imx5.  That said, when imx6q is excluded from the build, we are still
> wasting those space.

It's my understanding that the ARCH_NR_GPIO Kconfig was introduced 
recently for optimization/conversion/cleanup reasons. So from my point 
of view it's in a first step better to use it for iMX6 than ignoring 
this optimization/conversion/cleanup.

But yes, it's even better to enable it for imx3/imx5, too. As I don't 
know these platforms, two questions:

- Do you like to propose a better macro than SOC_IMX6Q to cover 
imx3/imx6, too?

- Do imx3 and imx5 have the same GPIO number like imx6? I.e. 7 banks 
with 32 pins == 224 GPIOs?

> Looking at current users of this definition, you will find all of them
> are defining a number bigger than 256 for extending the maximum number.
> It might be a sign that having a gpio array which is a little bigger
> than necessary is not a concern on machines today.

Or it might be a sign that they *have* more than 256? I don't know. But 
what's the issue using a matching number if possible?

Best regards

Dirk
