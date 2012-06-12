From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:11:45 +0100
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
Message-ID: <4FD6F9C1.1020305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 22:01, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now the AB8500 has its own IRQ domain
>
> But that does not appear until patch 8 in this series? Are the patches in
> the wrong order? Or does this need rewording?

The patches are in the correct order. This needs to be done _before_ we 
provide the AB8500 with its own domain. I guess the line should 
reference future tense. We are only talking two patches in the future, 
is it that important? I will change the wording slightly if it is.

>> it needs to be initialised earlier
>> in the boot sequence. As the AB8500 relies on the DB8500 PRCMU we need to
>> reflect this change for the PRCMU driver too.
>
> Hm what shall we do when we run out of initlevels? I think this was the
> kind of thing that deferred probe should solve. Usually changing this kind
> of thing has side effects so I'm a bit hesitant.

Nothing seems to be broken by it. My Snowball still comes up and 
everything that worked before continues to do so. How would you like me 
to take this forward?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
