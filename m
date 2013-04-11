From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 11 Apr 2013 09:54:44 -0600
Subject: [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <1364488523-20310-4-git-send-email-p.zabel@pengutronix.de>
 <CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
Message-ID: <5166DCC4.6050206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 04:35 AM, Olof Johansson wrote:
> On Thu, Mar 28, 2013 at 9:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> This driver implements a reset controller device that toggles gpios
>> connected to reset pins of peripheral ICs. The delay between assertion
>> and de-assertion of the reset signal can be configured.
...
> Since this is a platform driver and not just an OF driver, shouldn't
> you provide a way to specify the same configuration data through a
> platform_data structure as well?

I believe the only practical use-cases for this driver are /currently/
for device-tree platforms. Shouldn't we add the platform_data support
only when some platform actively uses it?

In the past when reviewing new drivers, I pushed for platform drivers to
always implement the platform_data structure up-front, and support using
that if present rather than "falling back" to DT. However, Grant then
shot that down saying that there was no point adding dead code...

(this will also feed into the discussion about simple-framebuffer, which
also only needs DT support right now, but could in theory be extended to
support platform_data in the future if somebody wants).
