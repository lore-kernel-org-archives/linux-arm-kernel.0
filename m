From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 15:53:04 -0500
Subject: [PATCH 6/7] dt-bindings: i2c: i2c-gpio: Add support for named
 gpios
In-Reply-To: <20170917093906.16325-7-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-7-linus.walleij@linaro.org>
Message-ID: <20170920205304.shkguzlqco3m6weu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 11:39:05AM +0200, Linus Walleij wrote:
> From: Geert Uytterhoeven <geert+renesas () glider ! be>
> 
> The current i2c-gpio DT bindings use a single unnamed "gpios" property
> to refer to the SDA and SCL signal lines by index.  This is error-prone
> for the casual DT writer and reviewer, as one has to look up the order
> in the DT bindings.
> 
> Fix this by amending the DT bindings to use two separate named gpios
> properties, and deprecate the old unnamed variant.
> 
> Take this opportunity to clearly deprecate the "i2c-gpio,sda-open-drain"
> and "i2c-gpio,scl-open-drain" flags as well. The commit describes
> in detail what these flags actually mean, and why they should not be
> used in new device trees.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Augmented to what I and Rob would like]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Create a special section for the deprecated bindings
> - Also deprecate the open drain bool properties
> - Update the example to use the new style of bindings
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 32 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
