From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 May 2014 07:24:39 -0500
Subject: [PATCH v3 1/2] input: Add new sun4i-ts driver for Allwinner
 sunxi SoC's rtp controller
In-Reply-To: <1399718826-16215-2-git-send-email-hdegoede@redhat.com>
References: <1399718826-16215-1-git-send-email-hdegoede@redhat.com>
 <1399718826-16215-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140510122439.GJ7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Thanks a lot for reposting this.

On Sat, May 10, 2014 at 12:47:05PM +0200, Hans de Goede wrote:
> Note the sun4i-ts controller is capable of detecting a second touch, but when
> a second touch is present then the accuracy becomes so bad the reported touch
> location is not useable.
> 
> The original android driver contains some complicated heuristics using the
> aprox. distance between the 2 touches to see if the user is making a pinch
> open / close movement, and then reports emulated multi-touch events around
> the last touch coordinate (as the dual-touch coordinates are worthless).
> 
> These kinds of heuristics are just asking for trouble (and don't belong
> in the kernel). So this driver offers straight forward, reliable single
> touch functionality only.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  15 ++
>  drivers/input/touchscreen/Kconfig                  |  10 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/sun4i-ts.c               | 262 +++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
>  create mode 100644 drivers/input/touchscreen/sun4i-ts.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> new file mode 100644
> index 0000000..e45927e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -0,0 +1,15 @@
> +sun4i resistive touchscreen controller
> +--------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-ts"

In between, I changed the compatible of this driver to sun4i-a10-ts to
match the pattern used everywhere else. You should probably update it
in your driver as well :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140510/a1d4ffc8/attachment.sig>
