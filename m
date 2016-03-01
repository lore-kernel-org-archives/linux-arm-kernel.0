From: kdasu.kdev@gmail.com (Kamal Dasu)
Date: Tue, 1 Mar 2016 11:14:51 -0500
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <CAC=U0a0FR8u3=zYU7xDW4dJxbwFUY4RHxMdK9zoEHdXcWyNDPg@mail.gmail.com>
References: <CAC=U0a0FR8u3=zYU7xDW4dJxbwFUY4RHxMdK9zoEHdXcWyNDPg@mail.gmail.com>
Message-ID: <CAC=U0a0sq4F4YLiJ7W57ZBktpWkGjUHLcTScoZ0v_Lxoth5=Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

I found a minor checkpatch issue with the change while applying the
patch to my local branch.

WARNING: line over 80 characters
#11: FILE: drivers/i2c/busses/i2c-brcmstb.c:589:
+       dev->bsc_regmap = devm_kzalloc(&pdev->dev,
sizeof(*dev->bsc_regmap), GFP_KERNEL);

Kamal

On Thu, Feb 25, 2016 at 2:32 PM, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>> We want the size of the struct, not of a pointer to it. To be future proof,
>> just dereference the pointer to get the desired type.
>
> Thanks for catching and fixing this.
>
>>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> Kamal
