From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:45:54 +0200
Subject: [PATCH 07/32] ARM: ux500: Supply address location names for the
 DMA40 DMA controller
In-Reply-To: <20130425091744.GF4623@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbCMjC22WbgE_-Co-hvT704n696Ox8t_6_d2aoxmZyybA@mail.gmail.com>
 <20130425091744.GF4623@gmail.com>
Message-ID: <CACRpkdbhygnrtosb5PRQ_5JbURpeH7pM-xj-m1wLP8Yq3HCLcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 11:17 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Apr 2013, Linus Walleij wrote:
>
>> On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > The DMA40 controller uses two sets of base addresses. In order to have
>> > them automatically setup as resources by the Open Format framework we
>> > have to set names for them. The names have to be the same as the ones
>> > used to fetch them back out of the resource structure.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> This is OK with Arnds suggested changed, but I want the patch
>> split off from this series and put into a device-tree-specific patch
>> series so I can apply this to a branch where I try to keep
>> all patches to the device tree files. (ux500-devicetree).
>
> Do you want to take this one separately?
>
> Feel free and I'll remove it from this set.

The problem I'm facing in the ux500 tree is that different changes
to the device tree files are colliding like hell.

So I really need those changes (to those files) to come in
separately. Usually the changes are orthogonal anyway, and
the DT stuff "could" be maintained as if it was out-of-tree.

At the core of that is basically that the DT files have a higher
evolutionary pace than the kernel code and that is straining the
merge model.

Yours,
Linus Walleij
