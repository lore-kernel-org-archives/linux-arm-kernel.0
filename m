From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 01:40:09 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
Message-ID: <1370475609.20454.44.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tor 2013-06-06 klockan 00:26 +0100 skrev luke.leighton:

>  no john - they've only added it to the multiplexed sections of the
> drivers which they themselves have written.  such as
> drivers/usb/sun{N}i_usb/*.[ch], drivers/block/nand/sun{N}_i,
> arch/arm/mach-sun{N}i and so on.

And a number of SPI device drivers, USB device drivers, vendor provided
device drivers, ......

> the script.fex system deals with the pinmux issue in a very neat way that:
> 
>   a) has very little impact on the rest of the kernel tree [citation
> needed!  i'm saying that: could someone please confirm if it's true]

Not really the case. Actually the opposite. DT have this as well, and
integrated in device probing. Allwinner need to hack every driver used
to add their gpio requests to have pinmuxing triggered.

It is just layered a bit differently when using DT.

Regards
Henrik
