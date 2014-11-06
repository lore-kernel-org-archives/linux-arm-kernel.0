From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Nov 2014 16:17:48 -0600
Subject: [PATCH] usb: gadget: udc: pxa27x: fix build warning when !OF
In-Reply-To: <87ppd0xfwo.fsf@free.fr>
References: <1415249759-6219-1-git-send-email-balbi@ti.com>
 <545B196F.2020303@zonque.org> <87ppd0xfwo.fsf@free.fr>
Message-ID: <20141106221748.GD27324@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 06, 2014 at 08:55:35PM +0100, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
> > On 11/06/2014 05:55 AM, Felipe Balbi wrote:
> >> in case kernel is built without CONFIG_OF there
> >> will be a build warning (see below) due to of_match_ptr()
> >> being defined to NULL.
> >> 
> >> Because of_match_ptr() is pretty pointless anyway,
> >> let's just remove it and fix the warning.
> >
> > The alternative, of course, would be to wrap the udc_pxa_dt_ids
> > declaration in IS_ENABLED(CONFIG_OF), but I'm not sure whether it's
> > worth it.
> 
> Ah, wasn't the patch named "[PATCH v1] usb: gadget: pxa27x_udc: fix
> warning in non device-tree build" sent October the 29th fixing this
> issue (in [1]) ?

I seem to have missed that, let me replace the patches and use yours.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/64c867f2/attachment.sig>
