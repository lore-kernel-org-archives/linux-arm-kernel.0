From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Wed, 4 Jul 2018 11:37:13 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180702160158.GD65296@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180702160158.GD65296@linux.vnet.ibm.com>
Message-ID: <42dbe9a2-9795-0269-1a90-a5a71fcbe970@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srikar,

On 07/02/2018 09:31 PM, Srikar Dronamraju wrote:

> 2. ref_ctr_offset is necessarily a consumer property, its not a uprobe
> property at all.


Sorry to ask this after agreeing :P

Initially, I thought this point is right. But after thinking more on this,
it seems wrong to me. Ex a python SDT probe:

    Provider: python
    Name: function__entry
    Location: 0x0000000000140de4, Base: 0x00000000001ddfb0, Semaphore: 0x0000000000268320

Here, "Semaphore" field is what we are referring to as reference counter.
Basically reference counter's job is to gate invocation of uprobe and
thus ref_ctr_offset becomes a uprobe property, not the consumer property.
No? Am I missing anything?

Thanks,
Ravi
