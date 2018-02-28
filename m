From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 17:34:19 +0100
Subject: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside
 encoder init functions
In-Reply-To: <20180228155559.lqm22dzeiptrwyxe@flea>
References: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180228155559.lqm22dzeiptrwyxe@flea>
Message-ID: <ee7bff10-527a-5481-598b-47e1d7a9eeb6@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 28/02/2018 16:55, Maxime Ripard ha scritto:
> Hi,
> 
> On Wed, Feb 28, 2018 at 01:51:58PM +0100, Giulio Benetti wrote:
>> sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
>> so it finds dclk_min_div and dclk_max_div set to 0 and fails
>> adding crtc.
>>
>> Move dclk_min_div and dclk_max_div to encoders init functions.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> I sent a similar patch there:
> https://lists.freedesktop.org/archives/dri-devel/2018-February/166666.html

I've missed that.
And where you put it is better, since it's called every time set_mode is 
called.

On lvds instead I don't see anything about this,
it should have the same potential problem.
Also I can't understand why it has been set min=7 and max=7 on lvds.
With those values I would obtain 77Mhz only.
And I can't find values on datasheet for minimum and maximum.

> 
> I guess eventually, we'll want to remove the usage of the clock
> framework entirely, but it's not really the scope of a fix.

Where would you handle dclk instead of tcon?

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> Maxime
> 
