From: bisson.gary@gmail.com (Gary Bisson)
Date: Wed, 3 Dec 2014 15:00:43 -0800
Subject: [PATCH][imx/fixes] ARM: clk-imx6q: fix video divider for rev T0
 1.0
In-Reply-To: <CAOMZO5Dagh7dXTm0vZ-OYRE_X5hz8yKXedpjuV8v9Ncb8sJa8g@mail.gmail.com>
References: <1417636085-14822-1-git-send-email-bisson.gary@gmail.com>
 <CAOMZO5Dagh7dXTm0vZ-OYRE_X5hz8yKXedpjuV8v9Ncb8sJa8g@mail.gmail.com>
Message-ID: <CADCpmyP9-fq1=DYGr0vxvmhSTNLWfq40t0rL9cger-+_wBT6TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Dec 3, 2014 at 2:06 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Gary,
>
> On Wed, Dec 3, 2014 at 5:48 PM, Gary Bisson <bisson.gary@gmail.com> wrote:
>> The post dividers do not work on i.MX6Q rev T0 1.0 so they must be fixed
>> to 1. As the table index was wrong, a divider a of 4 could still be
>> requested which implied the clock not to be set properly. This is the
>> root cause of the HDMI not working at high resolution on rev T0 1.0 of
>> the SoC, giving the following error:
>
> Patch looks good, but just a minot comment: I would suggest removing this line:
>
>> mxc_sdc_fb fb.27: timeout when waiting for flip irq
>
> as it is not part of mainline.

You are right, this is a good point, let me send a v2.

Thanks,
Gary
