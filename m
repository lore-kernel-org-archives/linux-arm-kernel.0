From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:47:21 +0100
Subject: [PATCH] ARM: sun7i: dt: Add new MK808C device
In-Reply-To: <CAEKpxBnRyhD8Xiu7uTomM=z4Xm4CH8WVTYjZH73yDgYzwMqn5w@mail.gmail.com>
References: <1425131004-8551-1-git-send-email-codekipper@gmail.com>
 <20150303071342.GB4713@lukather>
 <CAEKpxB=-vtjMckh3ZHoy0mezE9U1EtKzmttdXRD5ZNztZvB_ag@mail.gmail.com>
 <20150304203400.GR4911@lukather>
 <CAEKpxBnRyhD8Xiu7uTomM=z4Xm4CH8WVTYjZH73yDgYzwMqn5w@mail.gmail.com>
Message-ID: <20150308174721.GL5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 07, 2015 at 09:41:54AM +0100, Code Kipper wrote:
> > Don't your device has any brand on the case or the PCB?
> 
> There is nothing on the PCB to reference a manufacturer, the actual packaging
> and case are from the earlier MK808B and mention A9. There was only a
> small sticker on the side to show that the contents was a MK808C.
> I guess 'unknown' isn't a valid vendor name,

Not really.

I really don't know what's the policy to apply in such a case when we
have a device that has no identified vendor.

We need to give a vendor name, because the compatible is used to tell
two devices apart, in the case where we would have to apply quirks for
a particular devices.

And if we have two devices (say a Marvlell and an Allwinner one), with
the same name, and without any vendor, we're screwed.

Maybe falling back to the SoC vendor, in our case, would make sense?

Arnd? Rob? Mark? An opinion on this?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/218a94be/attachment.sig>
