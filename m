From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 17 Jul 2017 15:05:44 -0400
Subject: [PATCH 2/3] net: ethernet: bgmac: Make IDM register space optional
In-Reply-To: <CAKUFe6ad027MAg-A3XO7i1=c-Q623JqMPCKV_+Hi+ZpUojBn-Q@mail.gmail.com>
References: <1499972649-6200-1-git-send-email-abhishek.shah@broadcom.com>
 <1499972649-6200-3-git-send-email-abhishek.shah@broadcom.com>
 <CAC3K-4o=WRqBv_vTf7QGDYjWzMmVog=63ZbiHbHAuW7zJcsHFQ@mail.gmail.com>
 <CAKUFe6ad027MAg-A3XO7i1=c-Q623JqMPCKV_+Hi+ZpUojBn-Q@mail.gmail.com>
Message-ID: <CAC3K-4rgVYkjGq_WTHoO6=fvSH0TuHOpdDpukbvK+5LxhLm4BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 2:37 PM, Abhishek Shah
<abhishek.shah@broadcom.com> wrote:
> Hi Jon,
>
>> This also will need to be added to
>> drivers/net/ethernet/broadcom/bgmac-bcma.c.  Otherwise, the driver
>> will no longer work for those platforms.  Since this was already
>> accepted, please push out a fix ASAP.
>>
> I do not see how the bcma driver [bgmac-bcma.c] will no longer work.
> The whole idea behind introducing this  BGMAC_FEAT_IDM_MASK bit
> was to keep bcma driver's functionality intact.
>
> The BGMAC_FEAT_IDM_MASK bit is explicitly set by the bgmac-platform driver
> and is unset inside the same if the idm register base is provided.
>
> For BCMA driver case, I do not touch BGMAC_FEAT_IDM_MASK bit, i.e. it
> is *not* set.
> And if it is not set, each idm operation done in bgmac.c will take place.
> Please explain if I am missing something here.

Sorry, I had it flipped in my mind.  Please disregard.

>
>
> Regards,
> Abhishek
