From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 23:28:38 -0800
Subject: [PATCH v5 2/2] input: samsung-keypad: Add device tree support
In-Reply-To: <1318264197-6698-3-git-send-email-thomas.abraham@linaro.org>
References: <1318264197-6698-1-git-send-email-thomas.abraham@linaro.org>
 <1318264197-6698-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAOesGMic39gaYt9rsyebBJDS=cKAmmOP1BdunzAEiL+wcf0HKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I came across this searching for other proposed device tree bindings
based on what I wanted to do for Tegra.

Comments below.

On Mon, Oct 10, 2011 at 9:29 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> +- Keys represented as child nodes: Each key connected to the keypad
> + ?controller is represented as a child node to the keypad controller
> + ?device node and should include the following properties.
> + ?- keypad,row: the row number to which the key is connected.
> + ?- keypad,column: the column number to which the key is connected.
> + ?- linux,code: the key-code to be reported when the key is pressed
> + ? ?and released.

[...]
> + ? ? ? ? ? ? ? key_1 {
> + ? ? ? ? ? ? ? ? ? ? ? keypad,row = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? keypad,column = <3>;
> + ? ? ? ? ? ? ? ? ? ? ? linux,code = <2>;
> + ? ? ? ? ? ? ? };
> +
> + ? ? ? ? ? ? ? key_2 {
> + ? ? ? ? ? ? ? ? ? ? ? keypad,row = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? keypad,column = <4>;
> + ? ? ? ? ? ? ? ? ? ? ? linux,code = <3>;
> + ? ? ? ? ? ? ? };
> +
> + ? ? ? ? ? ? ? key_3 {
> + ? ? ? ? ? ? ? ? ? ? ? keypad,row = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? keypad,column = <5>;
> + ? ? ? ? ? ? ? ? ? ? ? linux,code = <4>;
> + ? ? ? ? ? ? ? };


The above is good if all you want to specify is a few keys. If you
want a full keyboard specification, it gets very verbose.

I would prefer a simpler binding, something along the lines of:

linux,keymap = < row col code ... >;

Where it's just an array of the above, so your example would be:
linux,keymap = < 0 3 2
                 0 4 3
                 0 5 4 >;

Same amount of data, it would be more or less as easy to read but a
_much_ more compact representation when you need to provide 100+ keys.


-Olof
