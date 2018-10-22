From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Oct 2018 09:35:32 -0300
Subject: [PATCH 1/2] ARM: dts: ccimx6ulsbcpro: Add support for AUO
 G101EVN010 display
In-Reply-To: <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
 <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <CAOMZO5Ad8DMSq+bs21fqpcDqwzDnEgvnRgEsGUiLxUw87K1QAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Mon, Oct 22, 2018 at 7:34 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

> +       g101evn010: display at 0 {
> +               bits-per-pixel = <16>;
> +               bus-width = <18>;
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency = <68930000>;
> +                               hactive = <1280>;
> +                               vactive = <800>;
> +                               hfront-porch = <120>;
> +                               hback-porch = <0>;
> +                               hsync-len = <8>;
> +                               vback-porch = <10>;
> +                               vfront-porch = <0>;
> +                               vsync-len = <6>;
> +                               hsync-active = <1>;
> +                               vsync-active = <1>;
> +                               de-active = <1>;
> +                               pixelclk-active = <0>;

The recommendation is not to put the panel timings in the dts file anymore.

You could add an entry for this panel into the simple-panel driver and
then reference its compatible string in the board dts.
