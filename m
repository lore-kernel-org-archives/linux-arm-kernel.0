From: roy.franz@linaro.org (Roy Franz)
Date: Fri, 30 Aug 2013 07:16:20 -0700
Subject: [PATCH 14/16] Add strstr to compressed string.c for ARM.
In-Reply-To: <CACxGe6uruyU_=sfXtnJ17+JkNozUVkgwwLu_A-3=h1KtkegQ9g@mail.gmail.com>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-15-git-send-email-roy.franz@linaro.org>
 <20130830134325.51DC83E102A@localhost>
 <20130830134754.GX6617@n2100.arm.linux.org.uk>
 <CACxGe6uruyU_=sfXtnJ17+JkNozUVkgwwLu_A-3=h1KtkegQ9g@mail.gmail.com>
Message-ID: <CAFECyb-qVOk0ysYgFP9KkBFrLbiyWCZU=nssq6H4x9W-wb91Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 7:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Aug 30, 2013 at 2:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Aug 30, 2013 at 02:43:25PM +0100, Grant Likely wrote:
>>> On Fri,  9 Aug 2013 16:26:15 -0700, Roy Franz <roy.franz@linaro.org> wrote:
>>> > The shared efi-stub-helper.c functions require a strstr
>>> > implementation.
>>> > Implementation copied from arch/x86/boot/string.c
>>> >
>>> > Signed-off-by: Roy Franz <roy.franz@linaro.org>
>>>
>>> Okay, but at some point arch/arm/boot/compressed/string.c should be
>>> reworked into a common place.
>>
>> Only if the common place can be built with arch specific compile options,
>> like -fpic, without impacting the rest of the kernel.
>
> agreed. It would be a bit of a science project to see how feasible.
>
> g.

The strstr implemtation here is pretty generic, but some architectures like
x86 use inline ASM for some of these string functions, so there are
some additional
complications to unifying this code across architectures.

Roy
