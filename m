From: dianders@chromium.org (Doug Anderson)
Date: Thu, 27 Aug 2015 19:03:20 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <7hmvxc45w2.fsf@deeprootsystems.com>
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
 <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
 <7hmvxc45w2.fsf@deeprootsystems.com>
Message-ID: <CAD=FV=VTR-PBcXXX1jHNw65x_cMP9CKwVWBs+XCcFqFPp7msjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Thu, Aug 27, 2015 at 5:24 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> That is not really workable: the attach and detach happen in
>> probe/remove path; if you do not have driver for the device you will
>> miss the clocks for it.
>
> And in my proposal, I suggested that clocks without drivers are
> good candidates to list in the domain, with the caveat that the be
> called out (documented) as being device clocks that are missing a
> driver, so when a driver shows up they can be moved accordingly, and in
> a way that actually describes the hardware.

What happens if someone disables the driver using the CONFIG subsystem?

What happens if this is a device that someone has set to 'status =
"disabled";' in the device tree?

Even if the device is disabled in one of those two ways, we still need
the clocks to be turned on.  ...so if we turn on/off the VIO domain we
need to turn on the EDP clock even if there's no EDP in the current
board / config.  We might turn on/off VIO for one of the other devices
in the VIO domain for one of the other devices in VIO that we are
using.

-Doug
