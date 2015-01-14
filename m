From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jan 2015 15:44:53 -0800
Subject: [PATCH v3 4/4] pinctrl: qcom: Add support for reset for apq8064
In-Reply-To: <CAOZdJXXRgrYUEcX4f5zRuKgX-Dtbpvf-SV4-8rjuohv3=0NJhQ@mail.gmail.com>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>	<1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>
 <CAOZdJXXRgrYUEcX4f5zRuKgX-Dtbpvf-SV4-8rjuohv3=0NJhQ@mail.gmail.com>
Message-ID: <54B6FF75.70500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 03:38 PM, Timur Tabi wrote:
> On Fri, Aug 29, 2014 at 9:30 AM, Pramod Gurav
> <pramod.gurav@smartplayin.com> wrote:
>> +static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>> +{
>> +       int i = 0;
>> +       const struct msm_function *func = pctrl->soc->functions;
>> +
>> +       for (; i <= pctrl->soc->nfunctions; i++)
> Shouldn't this be
>
>             i < pctrl->soc->nfunctions
>
> As it stands, if nfunctions == 0, this function crashes.
>

I think so. Can you send a patch? Plus it would be nice to move i = 0 in
the for loop at the same time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
