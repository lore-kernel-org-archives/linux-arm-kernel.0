From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 09:24:29 -0700
Subject: [PATCH 16/21] usb: chipidea: msm: Restore wrapper settings after
 reset
In-Reply-To: <20160630085436.GA18426@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-17-stephen.boyd@linaro.org>
 <20160629082648.GK25236@shlinux2>
 <146722762509.16253.13062209537472705701@sboyd-linaro>
 <20160630085436.GA18426@shlinux2>
Message-ID: <CAJOFmgysbHqCzkW6NLnJ+o7D8F7ZGv+A2MjVYTV06=_jC_jJ+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2016 at 01:54, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Wed, Jun 29, 2016 at 12:13:45PM -0700, Stephen Boyd wrote:
>> Quoting Peter Chen (2016-06-29 01:26:48
>> > Why not using ci->platdata->vbus_extcon directly?
>>
>> Because ci->platdata->vbus_extcon is assigned after the child platform
>> driver probes, and we have no idea when that will happen from the
>> ci_hdrc_msm driver probe. If we try after ci_hdrc_add_device() we'll
>> race with the driver probe and only get the pointer sometimes.
>
> ci->platdata->vbus_extcon->edev is assigned at ci_get_platdata which is
> called before ci core device is created.
>

Ok.
