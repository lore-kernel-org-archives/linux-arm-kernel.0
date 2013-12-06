From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 14:00:15 +0100
Subject: [PATCHv7][ 2/2] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1386266109-16071-2-git-send-email-denis@eukrea.com>
References: <1386266109-16071-1-git-send-email-denis@eukrea.com>
 <1386266109-16071-2-git-send-email-denis@eukrea.com>
Message-ID: <20131206130014.GB30625@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 06:55:09PM +0100, Denis Carikli wrote:
[...]
> +Optional properties:
> +  - default-state: The initial state of the backlight.
> +    Valid values are "on", "off", and "keep".
> +    The "keep" setting will keep the backlight at whatever its current
> +    state is, without producing a glitch. The default is keep if this
> +    property is not present.

I'm not sure if "on", "off" and "keep" are a good choice for this
binding. Having strings for these tristate values seems suboptimal.
Other bindings have chosen a representation that, transposed to this
use-case, would read something like this:

	- default-state: The initial state of the backlight. Valid
	  values:
	  - 0: off
	  - 1: on

	If the "default-state" property is not present, the default
	will be to keep the current backlight state.

Which is in fact the exact behaviour that your binding describes, but
it's much more intuitive in my opinion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/fd9e72af/attachment.sig>
