From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 28 Apr 2015 10:34:12 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <87wq0wr6dd.fsf@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
 <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
 <87wq0wr6dd.fsf@linaro.org>
Message-ID: <CAFEAcA85i_1JybEFBg91NA3-LpAzYh4RSDnqryOd=rZN7gZP5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 09:42, Alex Benn?e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Does the kernel already have a conveniently implemented "inject
>> exception into guest" lump of code? If so it might be less effort
>> to do it that way round, maybe.
>
> So you pointed out we can't just re-inject the exceptions we get as we
> need to map from things like ESR_ELx_EC_WATCHPT_LOW to
> ESR_ELx_EC_WATCHPT_CUR before re-injection.
>
> Of course if it is as simple as modifying the ESR_EL1 register and
> returning +ve in the handle_exit path then I can do that but I assumed
> if any other wrangling needs doing it should be done in userspace.

Well, somebody's got to do it, and it's the same amount of work
either way (fiddling with ESR, making sure we direct the guest
to the right exception vector entry point, maybe a few other
things).

-- PMM
