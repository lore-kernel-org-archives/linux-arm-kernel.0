From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 15 Jun 2011 21:07:52 +0800
Subject: [PATCH 1/3] pxa2xx vpac: pcmcia - free gpios on exist rather than
	requesting them again.
In-Reply-To: <201106061643.51869.marek.vasut@gmail.com>
References: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
	<1307370255-15963-2-git-send-email-jic23@cam.ac.uk>
	<201106061643.51869.marek.vasut@gmail.com>
Message-ID: <BANLkTi=xjR=ZSs5WPDGk3i7b6=+vZfvy_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/6 Marek Vasut <marek.vasut@gmail.com>:
> On Monday, June 06, 2011 04:24:13 PM Jonathan Cameron wrote:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>> ?drivers/pcmcia/pxa2xx_vpac270.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pcmcia/pxa2xx_vpac270.c
>> b/drivers/pcmcia/pxa2xx_vpac270.c index 435002d..413dc7d 100644
>> --- a/drivers/pcmcia/pxa2xx_vpac270.c
>> +++ b/drivers/pcmcia/pxa2xx_vpac270.c
>> @@ -75,10 +75,10 @@ static int vpac270_pcmcia_hw_init(struct
>> soc_pcmcia_socket *skt) static void vpac270_pcmcia_hw_shutdown(struct
>> soc_pcmcia_socket *skt) {
>> ? ? ? if (skt->nr == 0)
>> - ? ? ? ? ? ? gpio_request_array(vpac270_pcmcia_gpios,
>> + ? ? ? ? ? ? gpio_free_array(vpac270_pcmcia_gpios,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(vpac270_pcmcia_gpios));
>> ? ? ? else
>> - ? ? ? ? ? ? gpio_request_array(vpac270_cf_gpios,
>> + ? ? ? ? ? ? gpio_free_array(vpac270_cf_gpios,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(vpac270_cf_gpios));
>> ?}
>
> Please add my
>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
>

Applied.
