From: panand@redhat.com (Pratyush Anand)
Date: Wed, 15 Mar 2017 15:12:11 +0530
Subject: [PATCH V2 1/2] kexec: arm64: create identity page table to be
 used in purgatory
In-Reply-To: <281f2f04-842d-73d3-cd52-8774ab549c23@redhat.com>
References: <cover.1482129830.git.panand@redhat.com>
 <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
 <587E53A6.6020709@arm.com> <281f2f04-842d-73d3-cd52-8774ab549c23@redhat.com>
Message-ID: <8aba46a4-411e-0a4c-0e85-ea955348f631@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Wednesday 18 January 2017 01:13 PM, Pratyush Anand wrote:
>
>>
>>> +     * in kexec
>>> +     */
>>> +    if (next_tbl_cnt > 5)
>>> +        die("%s: No more memory for page table\n", __func__);
>>
>> die()? With a bit of juggling can't we return an error so we never try
>> to enable
>> the MMU+dcache instead?
>>
>
> OK. can do that.

It does not seem easy to do that. We will have to revert job of 
add_buffer_phys_virt() in case of failure, and it will need lot of new 
code. So, IMHO it would be better to keep die() as of now.
What do you say?

~Pratyush
