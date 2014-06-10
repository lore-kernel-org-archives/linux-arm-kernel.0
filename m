From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 10 Jun 2014 14:11:31 +0200
Subject: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
In-Reply-To: <1402397497-26737-3-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <1402397497-26737-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0hUT0QPGWeDM9WoxnobaL5eoNi5UFrUUZrQ1gSBCX=aVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Tomasz Figa <t.figa@samsung.com>
>
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
> archs/platforms,

Actually, this isn't correrct.  It is limited to the platforms that
use Device Trees now.

Moreover, it is not consistent with the way we add devices to the ACPI PM
domain, which is the ACPI counterpart of this.

Rafael
