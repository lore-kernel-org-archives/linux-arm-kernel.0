From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 12 May 2014 10:02:16 -0400
Subject: [PATCH v9 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <20140512091047.GB3006@e106331-lin.cambridge.arm.com>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
 <1399472847-14377-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140512091047.GB3006@e106331-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-eadEXyabW2r_gSsnNyT2zQr3=Dwtq-_oDeryk-h4d6kUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 05:10, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ashwin,
>
> On Wed, May 07, 2014 at 03:27:25PM +0100, Ashwin Chaugule wrote:
>> The PSCIv0.2 spec defines standard values of function IDs
>> and introduces a few new functions. Detect version of PSCI
>> and appropriately select the right PSCI functions.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Other than those issues pointed out by Anup, this looks good to me,
> though I'd like to see the cpu_kill callbacks for arm (and arm64) go
> though at the same time (possibly folded in) so that implementations are
> exercised from the start and we don't have to add properties to later
> bodge around any current brokenness.

Yea. I'll fold it in the next revision.

>
> Have these patches been tested against an implementation?

Only boot tested on the ARMv8 FVP.

>
> Which tree are you planning on merging this through? Do we need to split
> the arm and arm64 parts?

IIRC all this PSCI work originally came via Catalins tree(?). But now,
these patches depend on a header introduced by Anups KVM patchset
which is merged in -
https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/log/?h=next

In a previous discussion (everyone here is CC'd) with Christoffer and
Paolo the 2nd option of the following was chosen:

1) Catalin can apply "Add common header for PSCI related defines", or
Ashwin can resend his series with the patch at the beginning.
Duplicate commits are fine, especially for seldom-modified files where
they do not cause conflicts.

2) Send Anup's patchset as a pull request to both me and Catalin,
relative to v3.16-rc1, both of us can apply it and Ashwin's series can
be commit on top.


To keep it simple it'd be better if it all goes via one tree, but if
there are objections or other suggestions, I'm happy to split this up.

Thanks,
Ashwin
