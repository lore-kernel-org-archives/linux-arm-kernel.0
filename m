From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 19:30:51 -0400
Subject: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
Message-ID: <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/14/2018 9:41 PM, Alexander Duyck wrote:
>>  }
>>
> So you missed the writel in e1000_xmit_frame. You should probably get
> that one too while you are doing these updates. The wmb() is in
> e1000_tx_queue().
> 

I brought wmb() outside along with the next descriptor assignment to be
similar to the rest of the other code.

if wmb() and writel() are not visible in the same function, let's not touch
the code.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
