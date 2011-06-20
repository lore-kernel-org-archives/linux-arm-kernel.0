From: balbi@ti.com (Felipe Balbi)
Date: Mon, 20 Jun 2011 19:06:51 +0300
Subject: [PATCH] s3c2410_udc: fix custom UDC command handling
In-Reply-To: <BANLkTi=tuh028X-Rr9i8ZF_B_Q6VBK2-Lw@mail.gmail.com>
References: <BANLkTimWM2oew2f9uWxoD1kw1=2bSYFFuw@mail.gmail.com>
	<Pine.LNX.4.44L0.1106201105430.2113-100000@iolanthe.rowland.org>
	<20110620151522.GN14262@legolas.emea.dhcp.ti.com>
	<BANLkTi=5S6bWs3jr9hTsg2=LXh4xKAprUA@mail.gmail.com>
	<20110620153645.GQ14262@legolas.emea.dhcp.ti.com>
	<BANLkTik-zdp57zTjrafR0jXGoJiq2hrm3g@mail.gmail.com>
	<BANLkTi=tuh028X-Rr9i8ZF_B_Q6VBK2-Lw@mail.gmail.com>
Message-ID: <20110620160650.GA26623@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2011 at 05:57:31PM +0200, Skacore Systems wrote:
> Oh and I've finally cloned the mainline git. So here it's the last
> try. I hope the TI people will not sabotage the Samsung's drivers any
> way longer !!!

Now you're just making an ass of yourself.

what do you think you will get making such kind of statements ? I just
happen to be hired by TI, there's no such thing as TI trying to sabotage
Samsung's drivers.

I'll fix this one out myself just to make you stop bothering me, but
don't expect me to put your patches in my priority list. If you really
think TI is sabotaging samsung's drivers, look at the big re-factor we
are doing on the entire Gadget framework, involving not only Samsung's
drivers but all the others.

Even though you cloned the tree you still make a mistake which will
prevent me from applying the patch without manually editting it.

On top of that, you decided not to follow our netiquette or our patch
formatting rules just because you think it's "nonsense". If you really
think that, why do you even bother sending the patch to this mailing
list ?

> diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
> index 100f263..b6e1ca5 100644
> --- a/drivers/usb/gadget/s3c2410_udc.c
> +++ b/drivers/usb/gadget/s3c2410_udc.c
> @@ -1567,7 +1567,7 @@ static void s3c2410_udc_command(enum
> s3c2410_udc_cmd_e cmd)

there shouldn't be this line break here.

>                 return;
> 
>         if (udc_info->udc_command) {
> -               udc_info->udc_command(S3C2410_UDC_P_DISABLE);
> +               udc_info->udc_command(cmd);
>         } else if (gpio_is_valid(udc_info->pullup_pin)) {
>                 int value;

tabs where converted into spaces too.

Next time, instead of been such an ass, spend some time learning the
process we use to do development. You'll see things will go smoother.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110620/8cd60a22/attachment.sig>
