From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 4 Apr 2012 09:44:38 +0530
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <201204031933.56131.arnd@arndb.de>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <CAOh2x=mk3PeozELWNGrJzjTjF6_T4f0uWgwP9rALD9xOHd=9zQ@mail.gmail.com>
 <CAOh2x==ZbB5L=susFvsjmDRVKtfDiXd4Bq+MPnPVegnPAPmGsg@mail.gmail.com>
 <201204031933.56131.arnd@arndb.de>
Message-ID: <4F7BCAAE.9050306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2012 1:03 AM, Arnd Bergmann wrote:
> Maybe I wasn't clear enough. I did not mean that code should be duplicated
> here. Instead, you should keep the probe function and export it, with some
> modifications, and do the same for the other common functions. This works
> well for a lot of other drivers in a similar situation. It would result
> in a function like

No. You were very clear earlier too. :)

> static int __devinit spear320_pinctrl_probe(struct platform_device *pdev)
> {
> 	return spear3xx_pinctrl_init(pdev, &spear320_machdata);
> }
> 
> static struct of_device_id spear_pinctrl_of_match[] __devinitdata = {
>        { .compatible = "st,spear320-pinmux" },
>        {},
> };
> 
> static struct platform_driver spear_pinctrl_driver = {
>        .driver = {
>                .name = DRIVER_NAME,
>                .owner = THIS_MODULE,
>                .of_match_table = spear_pinctrl_of_match,
>        },
>        .probe = spear320_pinctrl_probe,
>        .remove = __devexit_p(spear_pinctrl_remove),
> };

I was worrying about duplicating above code. :)
Anyway, i have already fixed up my code as you suggested.

-- 
viresh
