From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 May 2017 01:49:58 +0800
Subject: [linux-sunxi] Re: [RFC PATCH 02/11] drm: sun4i: add support for
 H3 mixers
In-Reply-To: <20170519174729.q5qk2vqlibzx3zrv@flea.home>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-3-icenowy@aosc.io>
 <20170519174729.q5qk2vqlibzx3zrv@flea.home>
Message-ID: <695DFDD0-1925-433C-AB88-B90EE461C203@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?20? GMT+08:00 ??1:47:29, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Thu, May 18, 2017 at 12:43:45AM +0800, Icenowy Zheng wrote:
>> From: Icenowy Zheng <icenowy@aosc.xyz>
>> 
>> Allwinner H3 SoC has two mixers, one has 1 VI channel and 3 UI
>channels,
>> and the other has 1 VI and 1 UI.
>> 
>> Add support for these two variants.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ---
>>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> index cb193c5f1686..d658a3a8159a 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> @@ -390,11 +390,29 @@ static const struct sun8i_mixer_cfg
>sun8i_v3s_mixer_cfg = {
>>  	.ui_num = 1,
>>  };
>>  
>> +static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
>> +	.vi_num = 1,
>> +	.ui_num = 3,
>> +};
>> +
>> +static const struct sun8i_mixer_cfg sun8i_h3_mixer1_cfg = {
>> +	.vi_num = 1,
>> +	.ui_num = 1,
>> +};
>> +
>>  static const struct of_device_id sun8i_mixer_of_table[] = {
>>  	{
>>  		.compatible = "allwinner,sun8i-v3s-de2-mixer",
>>  		.data = &sun8i_v3s_mixer_cfg,
>>  	},
>> +	{
>> +		.compatible = "allwinner,sun8i-h3-de2-mixer0",
>> +		.data = &sun8i_h3_mixer0_cfg
>> +	},
>> +	{
>> +		.compatible = "allwinner,sun8i-h3-de2-mixer1",
>> +		.data = &sun8i_h3_mixer1_cfg
>> +	},
>
>So the only difference between the two is the number of ui planes?

Not only., but currently we only implemented this.

More functions differ, but we still don't support them...

>
>Why not create a property to give the number then, instead of a
>compatible?
>
>Maxime
