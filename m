From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 18:22:42 +0800
Subject: [PATCH v3 04/14] drm/sun4i: tcon: Add support for demuxing TCON
 output on A31
In-Reply-To: <20170929102006.2wz7wrkpplxwynoh@flea>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-5-wens@csie.org>
 <20170929102006.2wz7wrkpplxwynoh@flea>
Message-ID: <CAGb2v65VhtEckRCXi4X5AjmC-5CSHavATu8fKyEHOivmYqZkww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 6:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 29, 2017 at 08:22:56AM +0000, Chen-Yu Tsai wrote:
>> On systems with 2 TCONs such as the A31, it is possible to demux the
>> output of the TCONs to one encoder.
>>
>> Add support for this for the A31.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index 7bf51abaee97..c949309d4285 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -112,6 +112,21 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>>  }
>>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>>
>> +static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)
>
> Would that make sense to make it a bit more generic, and pass the id
> to look for as an argument?

The reason to look for TCON0 explicitly is to access the muxing registers, which
are only available in TCON0. Other than that, there's nothing else
shared between
the two TCONs. So there's no particular reason to look for TCON1 explicitly.

ChenYu
