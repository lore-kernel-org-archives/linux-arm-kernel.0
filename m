From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jan 2013 09:58:44 +0800
Subject: [PATCH v3 2/3] gpio: pca953x: add support for pca9505
In-Reply-To: <51045261.5020709@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkda-N0GrKOeaz4Hji0ef9pSRNPCxW_jLGR28iX-sk0-=tg@mail.gmail.com>
 <51024422.2060503@free-electrons.com>
 <CACRpkdbe1fGVLNyJ+U+ozE32p+_fc-eQ4W1F8OeYC+fryu_dQQ@mail.gmail.com>
 <51045261.5020709@free-electrons.com>
Message-ID: <CAD6h2NSD0zW9aLkgzisEQ5s4UWMXqDG4ghDXrUX53Da4ZqOXAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2013 06:02, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 01/25/2013 09:51 AM, Linus Walleij wrote:
>> On Fri, Jan 25, 2013 at 9:36 AM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>
>>> Well, at the beginning I thought adding support for pca9505 was just a matter
>>> of a couple of lines to add. Then I realized that I need to handle the 40 bits
>>> case, and I ended up refactoring all access to the registers. So now I am on it,
>>> it seems I am volunteer to continue to improve this driver.
>>
>> I like the sound of this ;-)
>
> I was about to fix the issues you have pointed but I didn't find anything like
>
> #ifdef CONFIG_ARCH_PXA
>         if (cpu_is_pxa25x()) {
> #ifdef CONFIG_CPU_PXA26x
>                 count = 89;
>                 gpio_type = PXA26X_GPIO;
> #elif defined(CONFIG_PXA25x)
>
>
> in the pca953x driver! I think you messed up with another patch set!
>
> I saw that Haojian Zhuang have sent a patch set for gpio-pxa and
> among this set the patch "[PATCH 06/10] gpio: pxa: define nr gpios
> in platform data" seemed to exactly what you've expected.
>

PCA953X is a GPIO expander that is relied on I2C bus. It's a device in
the cirucit,
not in the PXA chips. So there's no cpu related code in this driver.

Gregory's concern is that he found that this device is used on pxa27x
platform, and
he don't have the hardware to test. I also don't have pxa27x platform.
I think that
he can ping the volunteers in the mailing list.

Regards
Haojian
