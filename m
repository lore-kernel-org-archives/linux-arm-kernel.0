From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Feb 2014 11:16:53 +0100
Subject: [PATCH 14/17] i2c: nomadik: Fixup deployment of runtime PM
In-Reply-To: <CAOMZO5CzUuQrmbk6FpFGR56jHBtW-1d_AGcdgB2xyMG0Nkf+Fw@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
 <CAOMZO5CzUuQrmbk6FpFGR56jHBtW-1d_AGcdgB2xyMG0Nkf+Fw@mail.gmail.com>
Message-ID: <CAPDyKFphK8Zo1i7=w-n-VbGWpmLvUZs_U2Ekq0NCeqVxZ7VKvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2014 15:45, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Feb 4, 2014 at 1:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> +static int nmk_i2c_runtime_resume(struct device *dev)
>> +{
>> +       struct amba_device *adev = to_amba_device(dev);,
>> +       struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
>> +
>> +       clk_prepare_enable(nmk_i2c->clk);
>
> Previously the code was checking the return value from
> clk_prepare_enable(). You should keep the check here.

Will fix in v2! Thanks for reviewing!

Kind regards
Ulf Hansson

>
> Regards,
>
> Fabio Estevam
