From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 11:32:27 -0600
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
Message-ID: <5165A22B.4070200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 02:12 AM, Prabhakar Lad wrote:
...
> Following is the proposed fix/hack let me know if its OK.
> 
> Regards,
> --Prabhakar
> 
> ->>>>>>>>>>>>>>>>>>>
> 
> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> index ee72f1f..78fb42d 100644
> --- a/drivers/pinctrl/core.h
> +++ b/drivers/pinctrl/core.h
> @@ -46,6 +46,7 @@ struct pinctrl_dev {
>         struct pinctrl *p;
>         struct pinctrl_state *hog_default;
>         struct pinctrl_state *hog_sleep;
> +       bool bits_per_mux;

This clearly isn't correct; any change to solve this problem should only
touch the internals of the pinctrl-single driver, not the pinctrl core.
