From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 10 Jun 2016 15:16:36 -0600
Subject: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
In-Reply-To: <20160610164721.GP13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610162555.GB6430@leverpostej>
 <20160610164721.GP13357@hector.attlocal.net>
Message-ID: <20160610211636.GA38979@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10 2016 at 10:47 -0600, Andy Gross wrote:
>On Fri, Jun 10, 2016 at 05:25:55PM +0100, Mark Rutland wrote:
>> On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
>> > On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
>> > > [+ Lorenzo]
>> > >
>> > > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
<...>
>>
>> > I chose to do this outside of the arm cpuidle driver because I didn't want to
>> > add any more DT information aside from the compatible, and I needed a separate
>> > place for the Qualcomm specific suspend code.
>>
>> Which suspend code is Qualcomm-specific? There shouldn't be anything on
>> the PSCI side, so I can only imagine that device management is left.
>> What am I missing?
>

>Qualcomm won't be supporting the psci suspend feature and will be doing their
>own thing.  As such, they need their own suspend ops.  In addition, we have
>platforms that don't use psci (32 bit).
>
Andy, which PSCI suspend feature are you referring to, here? On 8916, we
do support CPU_SUSPEND in PSCI.

You don't want to call SYSTEM_SUSPEND, as it requires the other CPUs to
be CPU_OFF (hotplugged off) before the last core calls this PSCI
function.

Lina
