From: gengdj.1984@gmail.com (gengdongjiu)
Date: Wed, 27 Sep 2017 23:37:18 +0800
Subject: [PATCH v6 6/7] KVM: arm64: allow get exception information from
 userspace
In-Reply-To: <8be64586-3722-cd96-80fd-6e815d2e911d@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-7-git-send-email-gengdongjiu@huawei.com>
 <59B17438.5070501@arm.com> <2a42d1ea-3456-2873-c9ea-d8a027b59789@huawei.com>
 <59BA7D72.4090403@arm.com> <92f2fecc-9833-15e4-30cc-b4dd5ba93cb7@huawei.com>
 <59C53FA7.2080803@arm.com> <8be64586-3722-cd96-80fd-6e815d2e911d@huawei.com>
Message-ID: <CAMj-D2AuCqAgQBRAp2CSf24HsHWteNLigZAUEKK8oKL_SAmBNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> What you may be seeing is some awkwardness with the change in the SError ESR
>> with v8.2. Previously the VSE mechanism injected an impdef SError, (but they
>> were all impdef so it didn't matter).
>> With VSESR_EL2 KVM has to specify one, and all-zeros is a bad choice as this
>> means 'classified as a RAS error ... unknown!'.
>>
>> I have a patch in the upcoming SError/RAS series that changes KVMs virtual-abort
>> code to specify an impdef ESR for this path.
> Before I remember Marc and you suggest me specify the an impdef ESR (set the vsesr_el2) in
> the userspace,

I pasted Marc's propose and your suggestion that set VSESR_EL2(specify
virtual SError syndrome) by the user space.
https://lkml.org/lkml/2017/3/20/441
https://lkml.org/lkml/2017/3/20/516


> now do you want to specify an impdef ESR in KVM instead of usrspace?
> if setting the vsesr_el2 in the KVM, whether user-space need to specify?
> May be we can combine the patches that specify an impdef ESR(set vsesr_el2) patch to one.
>
