From: alex.popov@linux.com (Alexander Popov)
Date: Mon, 12 Dec 2016 00:37:16 +0300
Subject: [PATCH 2/2] kcov: make kcov work properly with KASLR enabled
In-Reply-To: <CACT4Y+bOd-Lzs45jyEr73GkRc7zZDxL8Z3fSc+TeZVRNVC6M-A@mail.gmail.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-3-git-send-email-alex.popov@linux.com>
 <CACT4Y+bOd-Lzs45jyEr73GkRc7zZDxL8Z3fSc+TeZVRNVC6M-A@mail.gmail.com>
Message-ID: <f3f9c3a3-349d-65ff-6c84-51878cfd8072@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2016 12:32, Dmitry Vyukov wrote:
> On Sun, Dec 11, 2016 at 1:50 AM, Alexander Popov <alex.popov@linux.com> wrote:
>> Subtract KASLR offset from the kernel addresses reported by kcov.
>> Tested on x86_64 and AArch64 (Hikey LeMaker).
>>
>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>> ---
>>  kernel/kcov.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> I think generally this is the right thing to do.
> 
>  There are 2 pending patches for kcov by +Quentin (hopefully in mm):
> "kcov: add AFL-style tracing"
> "kcov: size of arena is now given in bytes"
> https://groups.google.com/forum/#!topic/syzkaller/gcqbIhKjGcY
> https://groups.google.com/d/msg/syzkaller/gcqbIhKjGcY/KQFryjBKCAAJ
> 
> Your patch probably conflicts with them.
> Should you base them on top of these patches, so that Andrew can merge
> it without conflicts?

Excuse me, I can't find these patches in:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
git://git.cmpxchg.org/linux-mmots.git

Could you point at the tree which I can rebase onto?
Should I cherry-pick Quentin's patches manually?

Best regards,
Alexander
