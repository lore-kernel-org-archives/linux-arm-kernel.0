From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Jul 2014 13:29:56 +0800
Subject: [PATCH] ARM: dts: imx: correct sdma compatbile for imx6sl and
 imx6sx
In-Reply-To: <CAOMZO5CkFufrNTf=uG0qHxZuqf1B-=QP2UBM0R_6dk6peT+7NQ@mail.gmail.com>
References: <1404456361-8197-1-git-send-email-shawn.guo@freescale.com>
 <CAOMZO5DWYxcXi8yRf7Toi-1CCnXgd2z+LQHWpu3yyNTiGPJarg@mail.gmail.com>
 <20140704145500.GJ30239@dragon>
 <CAOMZO5CkFufrNTf=uG0qHxZuqf1B-=QP2UBM0R_6dk6peT+7NQ@mail.gmail.com>
Message-ID: <20140707052955.GK30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 12:47:46PM -0300, Fabio Estevam wrote:
> On Fri, Jul 4, 2014 at 11:55 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> >> However, I still have a question: wouldn't it be better to describe
> >> the compatible string as:
> >> compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma", "fsl,imx35-sdma"; ?
> >
> > No, it wouldn't be better or necessary.
> 
> I have some trouble understanding when/if the three elements need to
> be passed into the compatible string.
> 
> For example: on mx6sl ssi node:
> 
>                 ssi1: ssi at 02028000 {
>                     compatible = "fsl,imx6sl-ssi",
>                             "fsl,imx51-ssi",
>                             "fsl,imx21-ssi";

I would say either one below is correct. 

 - compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi", "fsl,imx21-ssi";
 - compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";

But when commit 98ea6ad2edd2 (ARM: dts: imx6: use imx51-ssi) updates the
compatible, it might be better to just replace "fsl,imx21-ssi" with
"fsl,imx51-ssi".

> 
> However on mx6sx node we have:
> 
>                 ssi1: ssi at 02028000 {
>                     compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
> 
> Which one is correct? Care to explain?

This one is incorrect now.  The "fsl,imx21-ssi" should be replaced by
"fsl,imx51-ssi" per commit above.  Care to send a patch for it?

Shawn
