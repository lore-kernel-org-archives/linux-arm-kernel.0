From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 14:27:28 -0400
Subject: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
 <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
Message-ID: <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2018 2:25 PM, Alexander Duyck wrote:
>> +               /* We need this if more than one processor can write to our tail
>> +                * at a time, it synchronizes IO on IA64/Altix systems
>> +                */
>> +               mmiowb();
>>         }
> The mmiowb shouldn't be needed for Rx. Only one CPU will be running
> NAPI for the queue and we will synchronize this with a full writel
> anyway when we re-enable the interrupts.
> 

OK. I can fix this on the next version. I did a blanket search and replace for
my writel_relaxed() changes as I don't know the code well enough. 

Please point me to the redundant ones.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
