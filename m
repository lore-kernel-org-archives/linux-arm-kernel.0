From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 25 Mar 2013 16:48:10 +0530
Subject: [PATCH 2/2] media: davinci: vpbe: venc: move the enabling of
 vpss clocks to driver
In-Reply-To: <CA+V-a8tShKHreai51GHsyfHvW5yCvEiEcTTks7Tsy0s54bEekQ@mail.gmail.com>
References: <1363938793-22246-1-git-send-email-prabhakar.csengg@gmail.com>
 <1363938793-22246-3-git-send-email-prabhakar.csengg@gmail.com>
 <514FE307.5090201@ti.com>
 <CA+V-a8tShKHreai51GHsyfHvW5yCvEiEcTTks7Tsy0s54bEekQ@mail.gmail.com>
Message-ID: <51503272.9070301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2013 3:45 PM, Prabhakar Lad wrote:
> Hi Sekhar,
> 
> On Mon, Mar 25, 2013 at 11:09 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 3/22/2013 1:23 PM, Prabhakar lad wrote:
>>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>
>>> The vpss clocks were enabled by calling a exported function from a driver
>>> in a machine code. calling driver code from platform code is incorrect way.
>>>
>>> This patch fixes this issue and calls the function from driver code itself.
>>>
>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>> ---
>>>  Note: This patch is based on the comment from Sekhar
>>>       (https://patchwork-mail1.kernel.org/patch/2278441/).
>>>       Shekar I haven't completely removed the callback, I just added
>>>       the function calls after the callback. As you mentioned just to
>>>       pass the VPSS_CLK_CTRL as a resource to venc but the VPSS_CLK_CTRL
>>>       is already being used by VPSS driver. I'll take this cleanup task later
>>>       point of time.
>>
>> Fine by me.
>>
> Can I have your ACK on this patch ?

The 'fine' from me was for the approach, not not patch ;). Seriously
though, since this patch is only touching media/ I haven't really done a
detailed enough review of it. In any case, it should be OK to merge this
without my ack.

Thanks,
Sekhar
