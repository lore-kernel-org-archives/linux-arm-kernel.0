From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 16:54:08 +0200
Subject: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture Select,
 Right Capture Select
In-Reply-To: <20180502210800.1971-9-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
Message-ID: <20180503145408.yymk2ndt4sm2yt4i@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 02, 2018 at 11:08:00PM +0200, Danny Milosavljevic wrote:
> Add Left Capture Select and Right Capture Select for Allwinner A10 and
> Allwinner A20.
> 
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 45dcb80a1da9..1a4ba3bae5da 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -706,6 +706,25 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
>  			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
>  			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
>  
> +static const char * const sun4i_codec_capture_source[] = {
> +	"Line",
> +	"FM",
> +	"Mic1",
> +	"Mic2",
> +	"Mic1,Mic2",
> +	"Mic1+Mic2",
> +	"Output Mixer",
> +	"Line,Mic1",
> +};

Shouldn't that be defined in a more generic way? As far as I know,
there's no way to tell what the difference between "Mic1,Mic2" and
"Mic1+Mic2" would be from the userspace.

I guess the larger issue is that you'd need to have controls that are
common to both channels (ie that would change the routing of both
mixers), but aren't sharing the same controls structure since the
label would be different.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/12a3203c/attachment.sig>
