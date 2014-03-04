From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Tue, 4 Mar 2014 20:17:41 +0100
Subject: [PATCH v2 02/11] drivercore: Bind/unbind power domain on
 probe/remove
In-Reply-To: <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CA+gwMceHSD6-dqsehDuwhVLwdNxdaRVteA=EA9UvhYMjB+xKWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, Mar 3, 2014 at 5:02 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On a number of platforms, devices are part of controllable power
> domains, which need to be enabled before such devices can be accessed
> and may be powered down when the device is idle to save some power.
> This means that on systems that support power domain control using
> generic power domains subsystem, it is necessary to add device to its
> power domain before binding a driver to it and remove it from its power
> domain after its driver is unbound to make sure that an unused device
> does not affect power domain state.
>
> Since this is not limited to particular busses and specific
> archs/platforms, it is more convenient to do the above directly in
> driver core, just as done with pinctrl default configuration. This patch
> adds necessary code to really_probe() and __device_release_driver() to
> achieve this and maintain consistent stack-like ordering of operations
> happening when binding and unbinding a driver.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

patches 01 and 02
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
on i.MX6 GK802.

regards
Philipp
