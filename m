From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 27 Mar 2018 10:48:11 -0400
Subject: [PATCH v7 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <CAKgT0UfeMY0WsJGARrVxNsHzr8OnNSJ2jaYbBTGQNkR_uizJuQ@mail.gmail.com>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcaxM8Mj9Y9fR0B+aafTm1SzTqh+gHT5ozgvyaoHvrzRQ@mail.gmail.com>
 <1521849496.15055.16.camel@intel.com>
 <862cdbeafb9cfd272a426b010943ffc5@codeaurora.org>
 <e3ada376-52a5-573b-33f1-9aa84af75f0d@codeaurora.org>
 <trinity-6d247cd1-94e3-4a58-a762-77724e895644-1522159460624@3c-app-gmx-bs61>
 <dcbd4406-73f7-4afa-850d-5f5d9f97ab02@codeaurora.org>
 <CAKgT0UfeMY0WsJGARrVxNsHzr8OnNSJ2jaYbBTGQNkR_uizJuQ@mail.gmail.com>
Message-ID: <6fe4e3a4-219f-68d7-25f1-72ab86aae42e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2018 10:38 AM, Alexander Duyck wrote:
>> We are being told that if you use writel(), then you don't need a wmb() on
>> all architectures.
> I'm not sure who told you that but that is incorrect, at least for
> x86. If you attempt to use writel() without the wmb() we will have to
> NAK the patches. We will accept the wmb() with writel_releaxed() since
> that solves things for ARM.
> 

I added netdev and you to the RFC on writel and writel_relaxed list. 
Feel free to raise your concerns.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
