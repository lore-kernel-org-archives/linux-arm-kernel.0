From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 13 Jul 2010 17:21:59 -0600
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTin69tN3NQHD2wvkA0G-lj3f9tSZEnhzdyJdTh9m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 5:14 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Tue, 2010-07-13 at 17:04 -0600, Grant Likely wrote:
>
>> - I haven't figured out a way for the fragment to force an option to
>> ? be "n", or to set a value, for example "CONFIG_LOG_BUF_SHIFT=16".
>> ? This may require changing the syntax.
>> - It still doesn't resolve dependencies. ?A solver would help with this.
>> ? For the time being I work around the problem by running the generated
>> ? config through 'oldconfig' and looking for differences. ?If the files
>> ? differ (ignoring comments and generateconfig_* options) after oldconfig,
>> ? then the <board>_defconfig target returns a failure. ?(but leaves the
>> ? new .config intact so the user can resolve it with menuconfig). ?This
>> ? way at least the user is told when a Kconfig fragment is invalid.
>
> The solver would fix the whole issues with the defconfigs , we wouldn't
> need this Kconfig change .. From my perspective we shouldn't be fooling
> around with anything but the solver approach ..

The solver would complement Kconfig fragments, but it doesn't
implement all the functionality.  For instance, it doesn't help a
board config picking up a bunch of options from an SoC or Architecture
config file, especially things that are developer/maintainer choices
as opposed to hard requirements).  Solver on its own is an incremental
improvement over what we currently have, but it doesn't solve the
whole problem.

> It just doesn't feel like Kconfig was meant to do this, it feel like
> somewhat of an abuse ..

Why?  It uses the Kconfig language itself to specify additional
constraints on the final configuration.  Seems to be the essence of
elegance to me.  :-)

g.
