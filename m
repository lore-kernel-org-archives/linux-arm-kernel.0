From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Nov 2017 09:40:16 +0000
Subject: [PATCH v4 00/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <64439dc3-909d-722f-68c3-d8e20e96ed9a@redhat.com>
References: <20171031183022.80775-1-salyzyn@android.com>
 <64439dc3-909d-722f-68c3-d8e20e96ed9a@redhat.com>
Message-ID: <20171101094015.GA14665@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 06:04:19PM -0400, Jon Masters wrote:
> On 10/31/2017 02:30 PM, Mark Salyzyn wrote:
> > Take an effort to recode the arm64 vdso code from assembler to C
> > previously submitted by Andrew Pinski <apinski@cavium.com>, rework
> > it for use in both arm and arm64, overlapping any optimizations
> > for each architecture. But instead of landing it in arm64, land the
> > result into lib/vdso and unify both implementations to simplify
> > future maintenance. This will act as the basis for implementing
> > arm64 vdso32 in the future.
> 
> In the original patch series, our QE folks found a problem that lead to
> its revertion from our internal trees. I've pinged them to check this
> latest version and followup if we see the same failures now.

Could you elaborate a bit on the problem you found, please? Even if you
don't see it with this series, it doesn't mean it isn't lurking somewhere
else (potentially even in mainline!).

Will
