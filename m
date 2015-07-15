From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 15 Jul 2015 22:08:23 +0300
Subject: [PATCH v2 2/2] pinctrl: driver for Conexant Digicolor CX92755
 pin mapping
In-Reply-To: <28c81769f3ed3e4c24ce00bbe2773009259ba3fe.1430823310.git.baruch@tkos.co.il>
References: <eaf294961247ac7c105156d6fae6d7389a4c0dfc.1430823310.git.baruch@tkos.co.il>
 <28c81769f3ed3e4c24ce00bbe2773009259ba3fe.1430823310.git.baruch@tkos.co.il>
Message-ID: <20150715190822.GH2332@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, May 05, 2015 at 01:55:10PM +0300, Baruch Siach wrote:
> This adds pinctrl and gpio driver to the CX92755 SoC "General Purpose Pin
> Mapping" hardware block. The CX92755 is one SoC from the Conexant Digicolor
> series. Pin mapping hardware supports configuring pins as either GPIO, or up to
> 3 other "client select" functions. This driver adds support for pin muxing
> using the generic device tree binding, and a basic gpiolib driver for the GPIO
> functionality.
> 
> This driver does not currently support GPIO interrupts, and pad configuration.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>    * Address review comments for Linus Walleij:
>      - Add a pointer to pinctrl_desc in struct dc_pinmap
>      - Drop the now redundant pinctrl_pin_desc field
>      - Adapt dc_get_group_{name,pins} to these changes, and add a comment
>        explaining the 1-to-1 pin-groups relation
>    * Staticise dc_pmxops
>    * Protect the GP_CLIENTSEL clct parameter with parenthesis

Ping?
Any chance of having this driver queued for 4.3?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
