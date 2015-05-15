From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 15 May 2015 18:09:03 +0100
Subject: [PATCH v4 10/12] KVM: arm64: guest debug,
 HW assisted debug support
In-Reply-To: <87y4kpke91.fsf@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-11-git-send-email-alex.bennee@linaro.org>
 <20150515152346.GB23652@leverpostej> <87y4kpke91.fsf@linaro.org>
Message-ID: <CAFEAcA8Z1Na9LY3m-DvGXpjUtCkc_H3+uAKWVRB4EBZWP6enJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2015 at 17:16, Alex Benn?e <alex.bennee@linaro.org> wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
>> This gets more fun when you consider the context-aware breakpoints are
>> the highest numbered. So the set of (context-aware) breakpoints might
>> not intersect across all CPUs.
>
> I didn't see a reference to that in the ARM ARM. It seemed to imply any
> breakpoint could be context aware is .BT was appropriately set and
> linked to the VR.

No; see D2.9.2; there must be at least one context-aware
breakpoint, but no requirement for more than that.

-- PMM
