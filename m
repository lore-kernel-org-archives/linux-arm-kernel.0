From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 04 Jun 2015 00:46:54 +0530
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <CACRpkdaxWsi8t6aUFJK-KCmQF1gEOLiOE8=fgDRxQDSi4G6FgQ@mail.gmail.com>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
 <CACRpkdaxWsi8t6aUFJK-KCmQF1gEOLiOE8=fgDRxQDSi4G6FgQ@mail.gmail.com>
Message-ID: <556F52A6.3060104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 02 June 2015 06:42 PM, Linus Walleij wrote:
> On Thu, May 28, 2015 at 3:03 PM, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>
>> From: Rob Herring <robh@kernel.org>
>>
>> Since there is some problematic i2c slave devices on some
>> platforms such as dkb (sometimes), it will drop down sda
>> and make i2c bus hang, at that time, it need to config
>> scl/sda into gpio to simulate "stop" sequence to recover
>> i2c bus, so add this interface.
>>
>> Signed-off-by: Leilei Shang <shangll@marvell.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> [vaibhav.hiremath at linaro.org: Updated Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Double signed-off?
>

Thanks for your review.

Based on review comments on the list, i will have to change this patch
to use generic gpio reset implementation available in i2c-core.

Having said that, I am still sure whether GPIO lib (request/free)
would handle pinctrl configuration.

Thanks,
vaibhav
