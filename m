From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 1 Nov 2017 07:45:00 -0700
Subject: [PATCH v4 00/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <20171101094015.GA14665@arm.com>
References: <20171031183022.80775-1-salyzyn@android.com>
 <64439dc3-909d-722f-68c3-d8e20e96ed9a@redhat.com>
 <20171101094015.GA14665@arm.com>
Message-ID: <4830d8b1-94f3-fb5c-9a6c-86719c736d7e@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 02:40 AM, Will Deacon wrote:
> On Tue, Oct 31, 2017 at 06:04:19PM -0400, Jon Masters wrote:
>> On 10/31/2017 02:30 PM, Mark Salyzyn wrote:
>>> Take an effort to recode the arm64 vdso code from assembler to C
>>> previously submitted by Andrew Pinski <apinski@cavium.com>, rework
>>> it for use in both arm and arm64, overlapping any optimizations
>>> for each architecture. But instead of landing it in arm64, land the
>>> result into lib/vdso and unify both implementations to simplify
>>> future maintenance. This will act as the basis for implementing
>>> arm64 vdso32 in the future.
>> In the original patch series, our QE folks found a problem that lead to
>> its revertion from our internal trees. I've pinged them to check this
>> latest version and followup if we see the same failures now.
> Could you elaborate a bit on the problem you found, please? Even if you
> don't see it with this series, it doesn't mean it isn't lurking somewhere
> else (potentially even in mainline!).
>
> Will

Interested too!

NB: I expect there can also be some patch series confusion

I have taken two separate, stalling and publicized efforts (arm64 
vdso64->C apinski@ and vdso32 Kevin.brodsky@), merged them, tested them, 
divided them into relatively orthogonal elements, then broke them into 
smaller independent patch series' (divide and conquer). The final set of 
vdso32 changes are still pending as I watch each of the three prior 
smaller patch series' morph on the road to approval. The broken up 
series created thus far are:

[PATCH] arm64: compat: Remove leftover variable declaration (approved)

[PATCH vx x/3] arm64: compat: Add CONFIG_KUSER_HELPERS (pending)

[PATCH] arm64: compat: Expose offset to registers in sigframes (pending)

[PATCH vx x/12] arm+arm64: vdso unification to lib/vdso (pending, this one)

My suspicion is the final vdso32 changes (blocked by all of these + 
clangizing, not yet republished as rebased) could be the culprit Jon 
Masters could be speaking of?

Sincerely -- Mark Salyzyn
