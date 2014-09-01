From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 1 Sep 2014 17:55:21 +0300
Subject: [PATCH 1/4] gpio: syscon: add soc specific callback to assign
 output value
In-Reply-To: <CACRpkdaq2=f92yEEZgGHOtixDk35O9tmN2PZkSPKrGwGVDS_mQ@mail.gmail.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>	<1407946582-20927-2-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdaq2=f92yEEZgGHOtixDk35O9tmN2PZkSPKrGwGVDS_mQ@mail.gmail.com>
Message-ID: <540488D9.3040602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 08/29/2014 09:19 AM, Linus Walleij wrote:
> On Wed, Aug 13, 2014 at 6:16 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> Some SoCs (like Keystone) may require to perform special
>> sequence of operations to assign output GPIO value, so default
>> implementation of .set() callback from gpio-syscon driver
>> can't be used.
>>
>> Hence, add optional, SoC specific callback to assign output
>> gpio value.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Hm :-/
> 
> I didn't realize this wasn't a quite so straight-forward a
> syscon GPIO driver.

Yep. At first glance, everything seemed more simple.

> 
> Now I start to think that it looks kludgy to bolt this onto
> the other driver and think we may need to go back to the
> other version which puts it as a separate driver. I guess
> that is what you refer to as v1?
> 
> I have a hard time to make my mind up about these
> syscon things, sorry :-(
> 
> Now I have to ask you: which way do you prefer to do it,
> if you can choose freely? The initial driver or augmenting
> the syscon driver (patch v1)?

Honestly, I think, It is better to keep Keystone 2 functionality in 
standalone file [1], as it allows to simply manage this code using
build system, avoid ugly #ifdefs in code (as you note on patch 3)
and keep commits history more clear and HW specific (very helpful in 
case of any issues). 

But, as you agree now to take this syscon-based patches, I'll update & re-send them,
applying comments from Alexander to the patch 1 and your comments to the patch 3 :)

Thanks for your comments.

[1] https://lkml.org/lkml/2014/7/23/352

Best regards,
-grygorii
