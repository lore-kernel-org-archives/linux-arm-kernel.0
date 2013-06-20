From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Jun 2013 10:19:32 +0530
Subject: [PATCH v11 3/8] ARM: edma: Add EDMA crossbar event mux support
In-Reply-To: <CAD=GYpbVUu4H8vkLHYAGPUMqdzmbJncX4yOR+5k+5B8NJhfgAQ@mail.gmail.com>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
 <1371537499-12970-4-git-send-email-joelagnel@ti.com>
 <51C0344F.6010709@ti.com>
 <CAD=GYpbVUu4H8vkLHYAGPUMqdzmbJncX4yOR+5k+5B8NJhfgAQ@mail.gmail.com>
Message-ID: <51C289DC.1080604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/20/2013 6:06 AM, Joel A Fernandes wrote:

>>> +             /* Clear the xbar mapped channels in unused list */
>>> +             xbar_chans = info[j]->xbar_chans;
>>> +             if (xbar_chans) {
>>> +                     for (i = 0; xbar_chans[i][1] != -1; i++) {
>>> +                             off = xbar_chans[i][1];
>>> +                             clear_bits(off, 1,
>>> +                                     edma_cc[j]->edma_unused);
>>
>> Please fix the alignment here.
> 
> I noticed the alignment was off in a few other places in that driver.
> Fixed those up too.

If you do, please make it a separate (pre)patch.

Thanks,
Sekhar
