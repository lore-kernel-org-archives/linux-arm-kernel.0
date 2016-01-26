From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 26 Jan 2016 11:40:25 +0800
Subject: [PATCH v9 19/21] KVM: ARM64: Add a new feature bit for PMUv3
In-Reply-To: <CAFEAcA_fyEp3tihjbCyQBzU6vex4273Sp78J4Kg1UXkkyX+1Pg@mail.gmail.com>
References: <1452839275-19368-1-git-send-email-zhaoshenglong@huawei.com>
 <1452839275-19368-20-git-send-email-zhaoshenglong@huawei.com>
 <20160115110816.GE3915@hawk.localdomain> <569DE171.1070602@huawei.com>
 <CAFEAcA_fyEp3tihjbCyQBzU6vex4273Sp78J4Kg1UXkkyX+1Pg@mail.gmail.com>
Message-ID: <56A6EAA9.3010506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/26 0:47, Peter Maydell wrote:
> On 19 January 2016 at 07:10, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> > Yes, for checking the CAP true/false is enough. Maybe I think the number
>> > of host counters could be useful for QEMU to know the number and for
>> > supporting cross-type vcpu, but I'm not sure. If someone else has no
>> > other suggestion, I will change it to what you suggest.
> Do we care about the number of host counters?
Currently we don't care about it. Anyway it could be added if it's
necessary in the future.

> We might want to
> know how many counters the guest sees, but we can do that by
> using KVM_GET_ONE_REG to look at the guest PMCR_EL0, right?
Yes, right.

-- 
Shannon
