From: johan@kernel.org (Johan Hovold)
Date: Tue, 25 Nov 2014 15:07:00 +0100
Subject: [PATCH v5 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <1416918506-9366-2-git-send-email-romain.perier@gmail.com>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
 <1416918506-9366-2-git-send-email-romain.perier@gmail.com>
Message-ID: <20141125140700.GC19910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:28:25PM +0000, Romain Perier wrote:
> It reverts commit a4b4e0461ec5 ("of: Add standard property for poweroff capability").
> As discussed on the mailing list, it makes more sense to rename back to the
> old established property name, without the vendor prefix. Problem being that
> the word "source" usually tends to be used for inputs and that is out of control
> of the OS. The poweroff capability is an output which simply turns the
> system-power off. Also, this property might be used by drivers which power-off
> the system and power back on subsequent RTC alarms. This seems to suggest to
> remove "poweroff" from the property name and to choose "system-power-controller"
> as the more generic name. This patchs adds the required renaming changes and
> defines an helper function which checks if this property is set.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Acked-by: Johan Hovold <johan@kernel.org>

Mark, this is for the regulator tree.

Thanks,
Johan
