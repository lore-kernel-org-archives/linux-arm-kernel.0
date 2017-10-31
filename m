From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 31 Oct 2017 11:42:39 -0700
Subject: [PATCH v3 0/3] arm64: Add CONFIG_KUSER_HELPERS
In-Reply-To: <20170920091555.GA3782@arm.com>
References: <20170911152635.95367-1-salyzyn@android.com>
 <CAGXu5jK-i_Eqfm1mZ-Kz5dqsKuCt_-MDymkb735VXCV9aOnvwQ@mail.gmail.com>
 <20170920091555.GA3782@arm.com>
Message-ID: <065fd365-4635-ddc7-b683-59a5cb16be8f@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2017 02:15 AM, Will Deacon wrote:
> On Tue, Sep 19, 2017 at 03:02:22PM -0700, Kees Cook wrote:
>> On Mon, Sep 11, 2017 at 8:26 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>>> Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
>>> config option (enabled by default). When disabled, all kuser
>>> helpers-related code is removed from the kernel and no mapping is done
>>> at the fixed high address (0xffff0000); any attempt to use a kuser
>>> helper from a 32-bit process will result in a segfault.
>>>
>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>>
>>> v2:
>>> - vectors_page and compat_vdso_spec as array of 2
>>> - free sigpage if vectors allocation failed
>>> - adjust makefile so one line for each of the assembler source modules
>>> - split off assembler changes to a new previous patch in series to reduce churn
>>> - modify slightly the feature documentation to reduce its reach
>>> - modify slightly the feature documentation to rationalize the yes default.
>>> - There are more ifdefs as a result of the rebase.
>>>
>>> v3:
>>> - rebase (minor conflicts)
>> This looks great to me. I'd love to see kuser helpers gone. :)
>>
>> Catalin, Will, does this need anything else?
> I haven't had chance to look at the patches yet (buried in other stuff), but
> I aim to get to it in the next couple of weeks.
>
> Will

Ping?
