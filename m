From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 16:20:04 -0600
Subject: Tegra board file deprecation schedule
In-Reply-To: <CAOMZO5Cnd9knDUuc4aZrPrtk5YKUwpr-oJhUnu=z94=9CfY1ug@mail.gmail.com>
References: <4F9B0E7C.1060408@wwwdotorg.org>	<CAOesGMh3NY4cQERSQY-p0QsMtcCXyhkdGSGnnrckcz8-DPjbBw@mail.gmail.com>	<4F9B1568.9070704@wwwdotorg.org>
 <CAOMZO5Cnd9knDUuc4aZrPrtk5YKUwpr-oJhUnu=z94=9CfY1ug@mail.gmail.com>
Message-ID: <4F9B1B94.2030909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2012 04:00 PM, Fabio Estevam wrote:
> On Fri, Apr 27, 2012 at 6:53 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> The only one sticking point might be that the Harmony regulator
>> initialization needs to wait for the regulator driver to be probed, but
>> happen before the PCIe driver is registers. Perhaps we could hook up
>> some temporary bus notifiers to handle that. But since PCIe will likely
>> be fixed in 3.6, we could probably just wait for that on Harmony.
> 
> Does EPROBE_DEFER help in this case?

That's certainly the solution when everything is instantiated from
device tree, but I'm not sure it'll solve everything when doing the
regulator stuff from temporary code in the board file, which won't be
part of a driver probe.
