From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Fri, 21 Oct 2016 14:45:33 -0400
Subject: [PATCH 0/5] Support for LEGO MINDSTORTMS EV3
In-Reply-To: <1477075018-20176-1-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
Message-ID: <20161021184533.GA20430@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 01:36:52PM -0500, David Lechner wrote:
> This patch series adds support for LEGO MINDSTORTMS EV3[1]. This is a TI AM1808
> based board.
> 
> This patch series has been tested working (along with some hacks to fix the
> GPIOs) on an EV3.
> 
> There are still quite a few additional new drivers that need to be submitted
> to get everything working. This patch series just adds support for the parts
> that already have mainline kernel drivers.
> 
> I have a plan/driver in progress for many of the components[2], but I could use
> some advice on a few particulars.
> 
> Bluetooth: This needs a driver to sequence a GPIO to take the Bluetooth chip
> out of shutdown *after* the Bluetooth clock has been configured and started.
> Is there a generic driver that can do this sort of thing? Or, if not, which
> subsystem should the new driver go in?
> 
> Input and output ports: These ports are capable of hotplugging various devices,
> such as sensors and motors. I have written a driver for these that can detect
> most devices. I created a new subsystem for this called `lego-port`. However,
> I am wondering if the existing phy or extcon subsystems might be a good fit for
> this sort of thing.

Both this cover and patch 5/5 has MINDSTORTMS instead of MINDSTORMS in
a few places (including the subject line).

-- 
Len Sorensen
