From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Mon, 22 Jan 2018 11:56:12 +0100
Subject: Sunxi display white flash
In-Reply-To: <20180122101338.3u77ozjwgm6q7bpy@flea.lan>
References: <cd353e6a-685f-904e-beb6-f56a905f0ae9@micronovasrl.com>
 <20180122101338.3u77ozjwgm6q7bpy@flea.lan>
Message-ID: <d5e521dc-64b4-2c79-9421-31a735abec6a@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 22/01/2018 11:13, Maxime Ripard ha scritto:
> Hi,
> 
> On Fri, Jan 19, 2018 at 11:55:42PM +0100, Giulio Benetti wrote:
>> I was wondering if it does make sense to reset TCON during
>> sun4i_tcon_bind.
> 
> In theory, yes, we should remove it.
> 
>> What I experience is a screen white flash, this is because uboot
>> already initialized display and enabled backlight.
>>
>> IMHO, I would make TCON total reinit selectable via Kconfig and
>> enabled by default, even if I don't like at all not to reset
>> peripheral before using it, and assuming uboot did it for us before.
>>
>> What do you think?  Do you have some other idea to workaround this?
>>
>> Maybe checking if peripheral has already been set before, if Yes,
>> avoid to reinit it.  Could it make sense?
> 
> And this makes a lot of sense. Except that you need to recreate the
> whole DRM state from the TCON, HDMI and backend registers in order to
> work properly. This is definitely something we can do at some point,
> but it's also a quite huge amount of work.

Ok, I thought it was lighter to implement,
I didn't think about the overall consequences on TCON, HDMI etc.
Considering that we only experience that initial white flash,
IMHO it seems acceptable at the moment.

> 
> Maxime
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
