From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Thu, 15 Mar 2018 17:25:17 -0700
Subject: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
 <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
Message-ID: <CAKgT0UcfEwL9Jas149a=h3R4zeu4oA=uywJ9dpYD9kDdnpWQFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 4:30 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/14/2018 9:41 PM, Alexander Duyck wrote:
>>>  }
>>>
>> So you missed the writel in e1000_xmit_frame. You should probably get
>> that one too while you are doing these updates. The wmb() is in
>> e1000_tx_queue().
>>
>
> I brought wmb() outside along with the next descriptor assignment to be
> similar to the rest of the other code.
>
> if wmb() and writel() are not visible in the same function, let's not touch
> the code.

Maybe for e1000 we should just skip the driver entirely. Odds are you
aren't going to have any e1000 parts running on ARM anyway since most
of them are legacy PCI or PCI-X parts that were made over 10 years
ago. Most of your efforts would probably be best spent on igb, igbvf,
ixgbe, ixgbevf, i40e, i40evf, and fm10k.
