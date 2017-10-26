From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Oct 2017 12:29:11 -0200
Subject: [PATCH v4] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with
 unit name and no reg property
In-Reply-To: <1508946042-17671-1-git-send-email-marco.franchi@nxp.com>
References: <1508946042-17671-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5DunnnMQ7yXr-OnJd51qGE39UheUDvSuvBmpomt2W2UDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marco,

On Wed, Oct 25, 2017 at 1:40 PM, Marco Franchi <marco.franchi@nxp.com> wrote:

>                         fec: ethernet at 63fec000 {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;

This does not look corret.

You should these lines under 'mdio':

mdio {
     #address-cells = <1>;
     #size-cells = <0>;
   .....

Take a look at arch/arm/boot/dts/imx6ul-14x14-evk.dts for an example.
