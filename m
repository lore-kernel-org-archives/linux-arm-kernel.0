From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 22 Oct 2010 10:09:03 -0400
Subject: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
In-Reply-To: <20101022110457.GA14136@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
	<20101021145249.GA13095@void.printf.net>
	<AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
	<20101022095814.GA13073@void.printf.net>
	<20101022110457.GA14136@void.printf.net>
Message-ID: <AANLkTikg3-5whd65aZmK4sJSg+vvNke0fSkqSQJ1B5vf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 7:04 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Oct 22, 2010 at 10:58:14AM +0100, Chris Ball wrote:
> [...]
>> +#ifdef CONFIG_PM
>> +static int sdhci_pxa_suspend(struct platform_device *dev)
>> +{
>> + ? ? struct sdhci_host *host = platform_get_drvdata(to_platform_device(dev));
>> +
>> + ? ? return sdhci_suspend_host(host, state);
>> +}
>> +
>> +static int sdhci_pxa_resume(struct platform_device *dev)
>> +{
>
> These prototypes are not correct, leading to:
>
> ?CC [M] ?drivers/mmc/host/sdhci-pxa.o
> drivers/mmc/host/sdhci-pxa.c: In function ?sdhci_pxa_suspend?:
> drivers/mmc/host/sdhci-pxa.c:205: warning: initialization from incompatible pointer type
> drivers/mmc/host/sdhci-pxa.c:207: error: ?state? undeclared (first use in this function)
> drivers/mmc/host/sdhci-pxa.c:207: error: (Each undeclared identifier is reported only once
> drivers/mmc/host/sdhci-pxa.c:207: error: for each function it appears in.)
> drivers/mmc/host/sdhci-pxa.c: In function ?sdhci_pxa_resume?:
> drivers/mmc/host/sdhci-pxa.c:212: warning: initialization from incompatible pointer type
> drivers/mmc/host/sdhci-pxa.c: At top level:
> drivers/mmc/host/sdhci-pxa.c:222: warning: initialization from incompatible pointer type
> drivers/mmc/host/sdhci-pxa.c:223: warning: initialization from incompatible pointer type
>
> when compiled with CONFIG_PM=y.
>
> --
> Chris Ball ? <cjb@laptop.org> ? <http://printf.net/>
> One Laptop Per Child
>

Sorry, forgot open CONFIG_PM.
Updated patch, thanks
