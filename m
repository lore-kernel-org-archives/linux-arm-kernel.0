From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 12 Oct 2012 13:40:30 +0300
Subject: [PATCH 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAOh2x=m8OVNfMm5Fn+cr9Gxuh6oyt+8d4n-bkG8Xiw5zGncLiA@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350020375.git.viresh.kumar@linaro.org>
 <91e41b4cc972d298f714cbd6f400569a9710304c.1350020375.git.viresh.kumar@linaro.org>
 <1350030203.10584.139.camel@smile>
 <CAOh2x=m8OVNfMm5Fn+cr9Gxuh6oyt+8d4n-bkG8Xiw5zGncLiA@mail.gmail.com>
Message-ID: <CAHp75VffAwZjfQLf=wS+nBhiRoMFOoyPeUCfrzF1G=+Kh7HHTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 1:36 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Fri, Oct 12, 2012 at 1:53 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Fri, 2012-10-12 at 11:14 +0530, Viresh Kumar wrote:
>
>>> +     while (++i < dw->sd_count) {
>>> +             if (!strcmp(dw->sd[i].bus_id, param)) {
>>> +                     found = 1;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>> +     if (!found) {
>>> +             last_dw = dw;
>>> +             last_bus_id = param;
>>> +             return false;
>> Because of return here you could eliminate 'found' flag at all.
> how?

while (++i < dw->sd_count) {
               if (!strcmp(dw->sd[i].bus_id, param)) {
       chan->private = &dw->sd[i];
       last_dw = NULL;
       last_bus_id = NULL;

       return true;
               }
       }

               last_dw = dw;
               last_bus_id = param;
               return false;

-- 
With Best Regards,
Andy Shevchenko
