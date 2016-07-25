From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 25 Jul 2016 15:50:44 -0700
Subject: [PATCH 05/14] PM / doc: update device documentation for devices
 in IRQ safe PM domains
In-Reply-To: <1466624209-27432-6-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Wed, 22 Jun 2016 13:36:40 -0600")
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <7htwfd49iz.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Update documentation to reflect the changes made to support IRQ safe PM
> domains.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/devices.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..a622136 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices, by default, operate in process context. If a device can operate in

minor nit: By "devices" here, I think you mean the runtime PM callbacks for
devices?  If so, it should be explicit, otherwise it's not clear what it
means for devices to operate in process context.

Kevin
