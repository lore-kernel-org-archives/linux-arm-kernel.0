From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Nov 2018 11:31:37 +0000
Subject: [Bug Report] kdump crashes after latest EFI memblock changes on
 arm64 machines with large number of CPUs
In-Reply-To: <CAKv+Gu_1PNiGbgRqd3_0k6CGzh-2P+iAmqk=oSSek69kBCnb8Q@mail.gmail.com>
References: <CACi5LpOyy0YkhEzWWqt8hAQfKku2Vzp5+da_dGS23JMyHReNew@mail.gmail.com>
 <CAKv+Gu_1PNiGbgRqd3_0k6CGzh-2P+iAmqk=oSSek69kBCnb8Q@mail.gmail.com>
Message-ID: <f5c4c03a-e88f-ea42-b791-e50808e8247b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/18 11:11, Ard Biesheuvel wrote:
> (+ Marc)
> 
> On 1 November 2018 at 22:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> Hi,
>>
>> With the latest EFI changes for memblock reservation across kdump
>> kernel from Ard (Commit 71e0940d52e107748b270213a01d3b1546657d74
>> ["efi: honour memory reservations passed via a linux specific config
>> table"]), we hit a panic while trying to boot the kdump kernel on
>> machines which have large number of CPUs.
>>
> 
> Just for my understanding: why do you boot all 224 CPus when running
> the crash kernel?

FWIW, I've used these patches to kexec a kernel on a 256 CPUs system,
without any issue. Why am I not seeing this problem?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
