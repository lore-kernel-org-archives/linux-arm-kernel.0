From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Feb 2015 22:08:44 +0300
Subject: [PATCH 2/6] ASoC: max98088: Add DT bindings
In-Reply-To: <1424283959-16289-3-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-3-git-send-email-afaerber@suse.de>
Message-ID: <54E4E33C.9040301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/18/2015 09:25 PM, Andreas F?rber wrote:

> "maxim,max98089" will be used for the Spring Chromebook.

> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>   sound/soc/codecs/max98088.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
> index 805b3f8cd39d..69a21d1946e3 100644
> --- a/sound/soc/codecs/max98088.c
> +++ b/sound/soc/codecs/max98088.c
> @@ -2009,10 +2009,18 @@ static const struct i2c_device_id max98088_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
>
> +static const struct of_device_id max98088_of_match[] = {

    If I don't mistake, gcc will complain about this variable being unused if 
CONFIG_OF=n.

> +	{ .compatible = "maxim,max98088" },
> +	{ .compatible = "maxim,max98089" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max98088_of_match);
> +
>   static struct i2c_driver max98088_i2c_driver = {
>   	.driver = {
>   		.name = "max98088",
>   		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(max98088_of_match),

    You probably don;t need of_match_ptr(). Either that or do something with 
the match table, like enclosing into #ifdef or annotating with '__maybe_unused'.

[...]

WBR, Sergei
