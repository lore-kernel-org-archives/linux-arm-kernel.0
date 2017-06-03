From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 3 Jun 2017 22:33:25 +0800
Subject: [PATCH 10/19] drm/sun4i: hdmi: Rename internal DDC clock to avoid
 name collision
In-Reply-To: <20170602193012.xwuziggyx6evmusz@flea.lan>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-11-wens@csie.org>
 <20170602193012.xwuziggyx6evmusz@flea.lan>
Message-ID: <CAGb2v64Vgdjm1MAwn+L0PVc0CA0QOCn=0RONKoGDWLpzVBzvmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 3, 2017 at 3:30 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jun 02, 2017 at 06:10:15PM +0800, Chen-Yu Tsai wrote:
>> The DDC parent clock on the A31 SoC is also conveniently named
>> "hdmi-ddc", which results in a name collision when the hdmi driver
>> registers its internal DDC divider clock.
>>
>> Rename the internal clock to "hdmi-ddc-divider".
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
>> index e1071838f487..9a6b6243e977 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
>> @@ -125,7 +125,7 @@ static int _sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent,
>>       if (!ddc)
>>               return -ENOMEM;
>>
>> -     init.name = "hdmi-ddc";
>> +     init.name = "hdmi-ddc-divider";
>
> Can't we rename the CCU clock instead? Having the clock called
> hdmi-ddc being the actual clock output on the DDC bus feels more
> natural.

Do you have any suggestions? The manual labels the conflicting one
in the CCU as "HDMI_DDC"...

ChenYu
