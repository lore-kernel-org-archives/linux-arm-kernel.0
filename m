From: laura@labbott.name (Laura Abbott)
Date: Tue, 16 Feb 2016 10:48:31 -0800
Subject: [PATCH] arm64: mm: Mark .rodata as RO
In-Reply-To: <CAGXu5jLpj=ue49_N+LOYvtZcU3rpFR5=WTG15ySDOWprvRzFUA@mail.gmail.com>
References: <1455293599-6974-1-git-send-email-jeremy.linton@arm.com>
 <20160212182527.GG20262@leverpostej>
 <CAGXu5jLpj=ue49_N+LOYvtZcU3rpFR5=WTG15ySDOWprvRzFUA@mail.gmail.com>
Message-ID: <56C36EFF.9060900@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/16 10:10 AM, Kees Cook wrote:
> On Fri, Feb 12, 2016 at 10:25 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Feb 12, 2016 at 10:13:19AM -0600, Jeremy Linton wrote:
>>> Currently the .rodata section is actually still executable when DEBUG_RODATA
>>> is enabled. This changes that so the .rodata is actually read only, no execute.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>
> Yikes, good catch. Is anyone running the lkdtm tests that check these things?
>

I don't think the current lkdtm test would have caught this since the exec
test is using rw data and not ro data. That test could be expanded though
to include a rodata buffer as well.
  
Thanks,
Laura
