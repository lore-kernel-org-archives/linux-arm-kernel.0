From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 19 Apr 2017 11:45:33 +0100
Subject: [PATCH] fs: Preventing READ_IMPLIES_EXEC Propagation
In-Reply-To: <20170419103313.GA3238@e104818-lin.cambridge.arm.com>
References: <1492088223-98232-1-git-send-email-zhangshaokun@hisilicon.com>
 <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
 <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
 <CAFEAcA_wH1dDbcjEEBaLX0q8pfWsfYUGGL-zOC4MuxySqa=uvA@mail.gmail.com>
 <20170419103313.GA3238@e104818-lin.cambridge.arm.com>
Message-ID: <CAFEAcA_B+EJJG6gb3iVzL5VRQkGhmDPbYWrUw7UF4VNV0m7XCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2017 at 11:33, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Apr 18, 2017 at 09:01:52PM +0100, Peter Maydell wrote:
>>
>> > That's affecting most architectures with a risk of ABI breakage. We
>> > could do it on arm64 only, though I'm not yet clear on the ABI
>> > implications (at a first look, there shouldn't be any).
>>
>> Is there a reason why it isn't just straightforwardly a bug
>> (which we could fix) to make READ_IMPLIES_EXEC propagate to
>> child processes?
>
> While I agree that it looks like a bug, if there are user programs
> relying on such bug we call it "ABI".

Can there be any? Such a program would behave differently
depending on how the program that spawned it happened to
have been compiled, and for instance could break when
the OS happened to have its init binary updated even if
the kernel didn't change.

>> Behaviour shouldn't be variable across architectures either, I would
>> hope.
>
> The behaviour has already been variable for a long time. Even on x86,
> AFAICT x86_32 differs from x86_64 in this respect.

That also sounds like a bug to me.

> Anyway, the patch should be posted to linux-arch for a cross-arch
> discussion.

Agreed -- there may be something I'm missing, since it looks
like this behaviour of inheriting READ_IMPLIES_EXEC has always
been there.

thanks
-- PMM
