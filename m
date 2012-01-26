From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jan 2012 16:17:44 +0000
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <4F217100.6020105@samsung.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
 <4F1FEF55.8030604@samsung.com>
 <20120125133254.GJ3687@opensource.wolfsonmicro.com>
 <4F217100.6020105@samsung.com>
Message-ID: <20120126161744.GB19703@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 04:28:00PM +0100, Karol Lewandowski wrote:
> On 25.01.2012 14:32, Mark Brown wrote:

> >Well, they're different things.  Device tree isn't Linux specific at
> >all.

> There is no official platform-agnostic regulator API, nor DT-bindings
> document I'm aware of.  Thus, I don't see why, while transitioning to

The binding for the regulator API is supposed to be the one true
platform agnostic binding, none of the device tree stuff is supposed to
be Linux specific.

> DT, should we lose ability to describe certain hardware configurations.

We don't loose anything, a single voltage constraint that didn't set
apply_uV was always meaningless.  I keep meaning to make the core
complain about things like that and people specifying voltage ranges
without SET_VOLTAGE.

> On 25.01.2012 12:22, Mark Brown wrote:
> > The big problem there seems like specifying voltages in the first
> > place, if we know what device it is we should already know what's
> > going on.

> Driver which handles said regulator might know what's going on, but
> that might not be case for its consumers.  Should we limit ability to
> query given parameter just because its value is hardcoded in hardware?

I'm sorry, this makes no sense.  Setting a value in the constraints is
not going to have any impact on the value reported by the driver, it
never has.

> Consequently, if it's property of hardware that it provides fixed
> voltage somewhere shouldn't it be possible to describe this fact
> in DT?

If the device has a fixed voltage output the driver should just know
this without having to read the information from device tree, device
tree is for configuration.  If the device has some hardware fixed
configurability it should define this in a sensible fashion in the
bindings (which may for example be a case of specifying the values of
the passive components for ease of use).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120126/3c99420f/attachment.sig>
