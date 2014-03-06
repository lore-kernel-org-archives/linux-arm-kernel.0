From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 06 Mar 2014 19:16:28 +0000
Subject: [PATCH 2/3] ARM: at91: at91sam9g45: change at91_adc name
In-Reply-To: <1394038675-15809-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1394038675-15809-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5318C98C.1070702@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/14 16:57, Alexandre Belloni wrote:
> We can't use "at91_adc" to refer to the at91_adc driver anymore as the name is
> used to match an id_table.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
As stated in previous email, I'll take this along with the fix that 'broke'
this, if I get an Ack from one of the at91 maintainers.

Thanks,

Jonathan
> ---
>   arch/arm/mach-at91/at91sam9g45_devices.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index cb36fa872d30..88554024eb2d 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -1203,7 +1203,7 @@ static struct resource adc_resources[] = {
>   };
>
>   static struct platform_device at91_adc_device = {
> -	.name		= "at91_adc",
> +	.name		= "at91sam9g45-adc",
>   	.id		= -1,
>   	.dev		= {
>   				.platform_data	= &adc_data,
>
