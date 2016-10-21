From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:30:47 +0200
Subject: mbox-name vs. mbox-names (was: Re: [PATCH v4 1/5] mailbox: dt: Supply
 bindings for ST's Mailbox IP)
Message-ID: <CAMuHMdXqOZ=eKJ=SkY4TM=fu8qnZ2gLmh-2iH0jB2pAu_v2vNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 9:21 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/sti-mailbox.txt    | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> new file mode 100644
> index 0000000..b61eec9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> @@ -0,0 +1,51 @@
> +ST Microelectronics Mailbox Driver
> +
> +Each ST Mailbox IP currently consists of 4 instances of 32 channels.  Messages
> +are passed between Application and Remote processors using shared memory.
> +
> +Controller
> +----------
> +
> +Required properties:
> +- compatible           : Should be "st,stih407-mailbox"
> +- reg                  : Offset and length of the device's register set
> +- mbox-name            : Name of the mailbox

All other mailbox drivers use "mbox-names". Oops, it's in v4.9-rc1...

Can we still fix that?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
