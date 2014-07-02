From: s-anna@ti.com (Suman Anna)
Date: Wed, 2 Jul 2014 14:42:44 -0500
Subject: [PATCHv5 05/15] hwspinlock/omap: add support for dt nodes
In-Reply-To: <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-6-git-send-email-s-anna@ti.com>
 <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
Message-ID: <53B460B4.9010200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 07/01/2014 07:48 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
>>  static int omap_hwspinlock_probe(struct platform_device *pdev)
>>  {
>> -       struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
>> +       struct device_node *node = pdev->dev.of_node;
>>         struct hwspinlock_device *bank;
>>         struct hwspinlock *hwlock;
>>         struct resource *res;
>>         void __iomem *io_base;
>>         int num_locks, i, ret;
>> +       int base_id = 0;
> 
> We shouldn't implicitly assume base_id is zero: let's explicitly
> protect against potential subsequent invocations of
> omap_hwspinlock_probe.
> 

Yeah, I did this since we only had 1 instance, and used the same value
as used in the non-DT legacy code. Once I fold back Patch 8 that adds
the hwlock-base-id property, this will be assigned by reading that property.

regards
Suman
