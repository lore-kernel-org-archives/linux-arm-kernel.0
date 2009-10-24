From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Sat, 24 Oct 2009 01:59:25 -0500
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <200910221410.28632.anarsoul@gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
	<200910221410.28632.anarsoul@gmail.com>
Message-ID: <2accc2ff0910232359t1bc7515avb7b208ffbd112807@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 6:10 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> ? ????????? ?? 20 ??????? 2009 17:19:30 ????? Vasily Khoruzhick ???????:
>> Fix for a bug that shows when the s3c2410 TS driver requests
>> a conversion from the s3c-adc driver and the machine goes into suspend.
>> In this case the touchscreen stops working.

>@@ -224,6 +225,7 @@ struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,

> 	client->is_ts = is_ts;

> 	client->select_cb = select;

> 	client->convert_cb = conv;

>+	client->selected = 0;

You don't need to clear client->selected. kzalloc takes care of this.
