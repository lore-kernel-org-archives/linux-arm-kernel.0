From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Mon, 21 Nov 2016 19:42:26 +0100
Subject: [linux-sunxi] [PATCH v6 0/5] drm: sun8i: Add DE2 HDMI video
 support
In-Reply-To: <20161121191416.706b80c25d476fa002a001b1@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
 <1c9a02ff-ce6c-7ad7-36fa-8a2ea0b7675e@megous.com>
 <20161121191416.706b80c25d476fa002a001b1@free.fr>
Message-ID: <900661e6-15cb-ec5a-2908-3fd802aca65d@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 21.11.2016 v 19:14 Jean-Francois Moine napsal(a):
> On Mon, 21 Nov 2016 01:54:53 +0100
> Ond?ej Jirman <megous@megous.com> wrote:
> 
>> Dne 20.11.2016 v 12:32 Jean-Francois Moine napsal(a):
>>> This patchset series adds HDMI video support to the Allwinner
>>> sun8i SoCs which include the display engine 2 (DE2).
>>> The driver contains the code for the A83T and H3, but it could be
>>> used/extended for other SoCs as the A64, H2 and H5.
>>
>> Hi,
>>
>> I'm trying to test your patches on Orange Pi PC, and I've run into a few
>> issues: (I'm using sunxi-ng with the same patches as last time, to make
>> it work with your driver)
>>
>> 1] I just get pink output on the monitor - there's some signal, but it's
>> pink (or more like magenta).
>>
>> dmesg ouput indicates no error:
>>
>> [    1.887823] [drm] Initialized
>> [    1.888503] sun8i-de2 1000000.de-controller: bound
>> 1c0c000.lcd-controller (ops 0xc0a63894)
>> [    2.057298] sun8i-de2 1000000.de-controller: bound 1ee0000.hdmi (ops
>> 0xc0a63b54)
>> [    2.057304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [    2.057307] [drm] No driver support for vblank timestamp query.
>> [    2.690862] Console: switching to colour frame buffer device 240x67
>> [    2.723059] sun8i-de2 1000000.de-controller: fb0:  frame buffer device
> 	[snip]
> 
> My H3 boards work correctly, except the Orange PI 2 when it cannot read
> the EDID (but it is OK after reboot).
> 
> Did you check if the EDID was correctly read?

EDID is correctly read (I verified that it is the same as with the v5
version of the driver), but there's one difference I noted. v5 says dpms
is Off, while v6 says dpms is On.

> Which resolution do you expect?
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/1453ca53/attachment.sig>
