From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Aug 2013 13:28:16 -0600
Subject: [PATCH 1/2] include: dt-binding: input: create a DT header
 defining key codes.
In-Reply-To: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52014E50.6030508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(CC'ing DT bindings maintainers too, hence quoting a bit of the patch)

On 08/06/2013 08:12 AM, Laxman Dewangan wrote:
> Many of Key device tree bindings uses the constant number as key code
> which matches with kernel header key code and then comment as follows
> for reference/better readability:
> 	linux,code = <102>; /* KEY_HOME */
> 
> Create a DT header which defines all the key code so that DT key bindings
> can use it as follows:
> 	linux,code = <KEY_HOME>;

This looks fine to me.
Reviewed-by: Stephen Warren <swarren@nvidia.com>

A comment in support of the patch: This is adding OS-specific content to
the DT. However, the bindings this header file supports are already
written that way. There's not really any alternative here, since some
numbering scheme had to be chosen for keycodes, and it may as well be
the same set as the first/primary OS that'll use the binding.

As far as merging it, this patch should probably go through the core DT
tree, perhaps in a topic branch so that e.g. Tegra an MVEBU can merge it
in to apply your subsequent patches (or we can just wait until the next
kernel release to merge them in).

>  include/dt-bindings/input/input.h |  525 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 525 insertions(+), 0 deletions(-)
>  create mode 100644 include/dt-bindings/input/input.h
> 
> diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
> new file mode 100644
> index 0000000..042e7b3
> --- /dev/null
> +++ b/include/dt-bindings/input/input.h
> @@ -0,0 +1,525 @@
> +/*
> + * This header provides constants for most input bindings.
> + *
> + * Most input bindings include key code, matrix key code format.
> + * In most cases, key code and matrix key code format uses
> + * the standard values/macro defined in this header.
> + */
> +
> +#ifndef _DT_BINDINGS_INPUT_INPUT_H
> +#define _DT_BINDINGS_INPUT_INPUT_H
> +
> +#define KEY_RESERVED		0
> +#define KEY_ESC			1
> +#define KEY_1			2
> +#define KEY_2			3
...
> +#define BTN_DPAD_UP		0x220
> +#define BTN_DPAD_DOWN		0x221
> +#define BTN_DPAD_LEFT		0x222
> +#define BTN_DPAD_RIGHT		0x223
> +
> +#define MATRIX_KEY(row, col, code)	\
> +	((((row) & 0xFF) << 24) | (((col) & 0xFF) << 16) | ((code) & 0xFFFF))
> +
> +#endif /* _DT_BINDINGS_INPUT_INPUT_H */
