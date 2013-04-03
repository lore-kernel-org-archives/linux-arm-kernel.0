From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 15:23:03 -0600
Subject: [PATCHv5 0/7] arm: vt8500: Add support for pinctrl/gpio module
In-Reply-To: <CACRpkdZAtgpfA5rZ_C=eKDDOE9aDm=3k1QDava=EGL2BaoV+0g@mail.gmail.com>
References: <1364970291-17721-1-git-send-email-linux@prisktech.co.nz>
 <CACRpkdZAtgpfA5rZ_C=eKDDOE9aDm=3k1QDava=EGL2BaoV+0g@mail.gmail.com>
Message-ID: <515C9DB7.9000908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 07:40 AM, Linus Walleij wrote:
> On Wed, Apr 3, 2013 at 8:24 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> 
>> v5 changes:
>> Changed as requested by Rob Herring:
>> Added of_find_property_value_of_size() to drivers/of/base.c to remove some
>> code that was being duplicated.
>>
>> Changed as requested by Stephen Warren:
>> Redid the kfree(maps) code as devm_kzalloc would cause issues. We now kzalloc
>> maps all at once, and configs as required. A call to wmt_pctl_dt_free_map() is
>> used to kfree the allocated blocks if we fail early.
> 
> This v5 series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess it will go in through the VT8500 tree eventually?
> 
> Maybe you could put Stephen's BCMring patch on top when sending
> it in (also Acked-by) so we can avoid having that dangling.

s/bcmring/bcm2835/ :-)
