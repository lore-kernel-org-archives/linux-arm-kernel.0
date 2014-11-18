From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 18 Nov 2014 11:39:47 -0800
Subject: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <546A6962.9090801@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
 <546A6962.9090801@linaro.org>
Message-ID: <CAJAp7OgjOiKNzPxBWYPNt15QCHqMd36w5xysRXRv_2iCMFrQZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 1:32 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 10/25/2014 01:40 AM, Lina Iyer wrote:
>
> Hi Lina,
>
> [ ... ]
>
>> +static inline void spm_register_write(struct spm_driver_data *drv,
>> +                                       enum spm_reg reg, u32 val)
>> +{
>> +       if (drv->reg_data->reg_offset[reg])
>> +               writel_relaxed(val, drv->reg_base +
>> +                               drv->reg_data->reg_offset[reg]);
>
>
> Why not use writel and don't use 'wmb' below ?
>

Hi Daniel,

writel() provides ordering before the write, not after. Please have a
look at the definition.

Regards,
Bjorn
