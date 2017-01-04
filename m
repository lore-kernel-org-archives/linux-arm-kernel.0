From: panand@redhat.com (Pratyush Anand)
Date: Wed, 4 Jan 2017 19:33:04 +0530
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <CAKv+Gu_CRKb2TCKf+cC_SYMOg8o=tcOj6oj2CpO2rUXciDMK1A@mail.gmail.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
 <20170104111119.GD8329@leverpostej>
 <c23ad459-9dab-2085-2e0d-91ad4cedc987@redhat.com>
 <20170104120602.GG8329@leverpostej>
 <e83640e2-61ed-4c29-b047-23965e670c08@redhat.com>
 <CAKv+Gu_CRKb2TCKf+cC_SYMOg8o=tcOj6oj2CpO2rUXciDMK1A@mail.gmail.com>
Message-ID: <5399661f-4486-aca4-09a4-5530406988cb@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 04 January 2017 06:54 PM, Ard Biesheuvel wrote:
>> sg_init_one(&src, ctemplate[i].input, ilen);
>>
> This is the bug right here, and it is fixed already upstream. The
> crypto test vectors are part of the kernel image, and should not be
> used in scatterlists.
>

Thanks a lot Ard for bringing it. I see the following commit now in 
4.10-rc2.

02608e02fbec crypto: testmgr - Use heap buffer for acomp test input

CONFIG_DEBUG_SG enabled kernel would have blown it right here.

~Pratyush
