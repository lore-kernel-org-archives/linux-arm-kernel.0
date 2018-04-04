From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 4 Apr 2018 13:48:35 -0400
Subject: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
In-Reply-To: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
 <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
 <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
Message-ID: <9b0d7db3-0830-9661-6dc8-39523daa8f32@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2018 11:55 AM, Arnd Bergmann wrote:
> Yes, exactly, plus the same for write and in/out of course.

I was looking at this...

inb() and outb() seem to be calling writeb(). It gets the wmb/barrier automatically
when we fix writeb().

Did I miss something?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
