From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 06 Mar 2014 11:10:19 +0900
Subject: [PATCH v6 2/2] arm64: audit: Add audit hook in
 ptrace/syscall_trace
In-Reply-To: <20140228161558.GE29546@mudshark.cambridge.arm.com>
References: <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-3-git-send-email-takahiro.akashi@linaro.org>
 <20140228161558.GE29546@mudshark.cambridge.arm.com>
Message-ID: <5317D90B.3020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 01:15 AM, Will Deacon wrote:
> On Fri, Feb 28, 2014 at 05:17:15AM +0000, AKASHI Takahiro wrote:
>> This patch adds auditing functions on entry to or exit from
>> every system call invocation.
>>
>> Acked-by: Richard Guy Briggs <rgb@redhat.com>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/kernel/ptrace.c |   54 ++++++++++++++++++++++++++------------------
>>   1 file changed, 32 insertions(+), 22 deletions(-)
>
> I think you need to do something like I did for arch/arm/, where we have
> separate trace functions for entry/exit  to make sure that we invoke the
> various helpers in the correct order (for example, you want to invoke all
> the debug stuff *first* on entry, but *last* on exit).
>
> Will
>

If you mean syscall_trace_enter()/exit(), I will follow your suggestion
for readability.

-Takahiro AKASHI
