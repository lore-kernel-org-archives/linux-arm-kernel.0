From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 15 May 2015 22:16:24 +0200
Subject: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
In-Reply-To: <3513646.XX80DTTJbc@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-3-git-send-email-pali.rohar@gmail.com>
 <3513646.XX80DTTJbc@wuerfel>
Message-ID: <201505152216.24622@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 22:12:41 Arnd Bergmann wrote:
> On Friday 15 May 2015 21:50:07 Pali Roh?r wrote:
> >                 }
> >         
> >         }
> > 
> > +       /* include the terminating ATAG_NONE */
> > +       atag_size = (char *)atag - (char *)atag_list +
> > sizeof(struct tag_header); +       setprop(fdt, "/", "atags",
> > atag_list, atag_size);
> > +
> > 
> >         if (memcount) {
> >         
> >                 setprop(fdt, "/memory", "reg", mem_reg_property,
> >                 
> >                         4 * memcount * memsize);
> 
> The property should probably have a DT binding, and be named
> "linux,atags".
> 
> It may also help to check if the "linux,atags" property already
> exists and not create it otherwise. That way we can put it into the
> n900 dts file and have it updated by the compat code, but not expose
> the atags on other platforms unless they opt in.
> 
> 	Arnd

Maybe what would help: Is there a way to tell decompressor/kernel to not 
touch atag memory and then after kernel/board-code starts it save copy 
of atags? I think it is not possible right now, but correct me if I'm 
wrong...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/bf454953/attachment.sig>
