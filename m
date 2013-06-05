From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 06 Jun 2013 01:56:01 +0400
Subject: [PATCH 2/2] ARM: shmobile: r8A7779: fix Ether device name
In-Reply-To: <20130604051352.GW23054@verge.net.au>
References: <1369645206-3682-1-git-send-email-horms+renesas@verge.net.au>
 <1369645206-3682-3-git-send-email-horms+renesas@verge.net.au>
 <20130528040043.GL13532@quad.lixom.net> <20130604051352.GW23054@verge.net.au>
Message-ID: <51AFB3F1.40603@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/04/2013 09:13 AM, Simon Horman wrote:

>>> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> While recasting the commit "ARM: shmobile: R8A7779: add Ether support", I made a
>>> typo in the platform device's name: used underscore instead of hyphen.
>> Minor nit: if this has been merged, then including the SHA is useful too.
> Thanks, I have updated the changelog to:
>
> ARM: shmobile: r8A7779: fix Ether device name
>
> While recasting the commit dace48d04dee46a3409d5e13cd98031522e46377
> ("ARM: shmobile: R8A7779: add Ether support"), I made a
> typo in the platform device's name: used underscore instead of hyphen.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [horms+renesas at verge.net.au Add SHA of referenced commit to changlog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index b0b3948..c14a69b 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -443,7 +443,7 @@ void __init r8a7779_add_standard_devices(void)
>   
>   void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
>   {
> -	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
> +	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
>   					  ether_resources,
>   					  ARRAY_SIZE(ether_resources),
>   					  pdata, sizeof(*pdata));

     Actually, if these patches aren't going into 3.10, I think it makes 
sense to drop them,
since I'll be renaming the device and pushing this change thru the 
net-next tree RSN...

WBR, Sergei
