From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Jul 2013 19:18:37 +0400
Subject: [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <51E6B5CD.1010001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-07-2013 10:12, Barry Song wrote:

> From: Rongjun Ying <Rongjun.Ying@csr.com>

> this makes users be able to add a bt-sco node in dts instead of
> hardcoding a platform device in mach.

> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>   sound/soc/codecs/bt-sco.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
> index a081d9f..39e7ebe 100644
> --- a/sound/soc/codecs/bt-sco.c
> +++ b/sound/soc/codecs/bt-sco.c
[...]
> @@ -58,6 +66,9 @@ static struct platform_driver bt_sco_driver = {
>   	.driver = {
>   		.name = "bt-sco",
>   		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = bt_sco_of_match,
> +#endif

		.of_match_table = of_match_ptr(bt_sco_of_match),

will get rid of #ifdef here.

WBR, Sergei
