From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 8 Aug 2012 20:08:24 +0000
Subject: [PATCH 1/8] arm: vt8500: Add device tree files for
 VIA/Wondermedia SoC's
In-Reply-To: <5022B342.7080606@wwwdotorg.org>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-2-git-send-email-linux@prisktech.co.nz>,
 <5022B342.7080606@wwwdotorg.org>
Message-ID: <76F764B079F92A4E843589C893D0A022D1DCA8F3@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>It appears more typical to use "-" rather than "_" in the filename to
>join SoC and board names.

Fixed.

>I guess "_ref" means "reference". Is that how the boards are commonly
>known? Are you sure there will never be another reference board for
>these SoCs? Given the "model" values in the file, something more like
>vt8500-bv07.dts might be more appropriate?

I'm fairly certain there will never be another reference board, as these
SoC's seem to disappear after a few months and a new one comes out.
Most of the models are chinese in origin with no real identifying names.
Having said that, I have renamed the dts files to a less 'generic' name.
vt8500-bv07.dts, wm8850-mid.dts.
wm8505-ref is the same as I can't find any other identification for it, and
everyone else I've had contact with who has one has the same board
design.

>> +     /*
>> +      * Display node is based on Sascha Hauer's patch on dri-devel.
>> +      * Added a bpp property to calculate the size of the framebuffer
>> +      * until the binding is formalized.
>> +      */
>> +     display {

>Maybe it's better to just hold off on adding this node, to wait until
>the binding is complete so this file doesn't churn? Certainly it sounded
>like Sascha was going to change the binding a little in response to
>comments it received.

My understanding with Sascha's patch is that it won't include a pixel
format property and therefore we won't be able to use his binding properly
until its revisited. Without this node, we have no display output available
other than uart - and that's only available if you modify the hardware.

This patchset will make arch-vt8500 nearly unusable without this node as
we would have to leave the framebuffer code out as well.

Always open to suggestions,

Regards
Tony Prisk
