From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 1 Oct 2018 13:44:52 -0700
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
Message-ID: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2018 11:49 AM, John Stultz wrote:
> On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>> Last sent 23 Nov 2016.
>>
>> The following 23 patches are rebased and resent, and represent a
>> rewrite of the arm and arm64 vDSO into C, adding support for arch32
>> (32-bit user space hosted 64-bit kernels) and into a common library
>> that other (arm, or non-arm) architectures may utilize.
> So I feel like this has gone around a few times w/o much comment from
> the arm/arm64 maintainers. I'm not sure if there's a reason?
I am "forming an opinion"(tm) that ARM is not interested in any work on 
32 bit arm architectures. They have no manpower that they are willing to 
devote to this.

Despite the gain of 0.4% for screen-on battery life, where Android has a 
mix of 64 and 32 bit applications, thus still relevant _today_ on 64 bit 
architectures (providing vDSO32 for 32-bit applications).
> I worry part of the issue is the scope of this patch set is a little
> unwieldy (covering two architectures + generic code) might leave
> maintainers thinking/hoping someone else should review it.
Original was submitted by ARM author as a complete patch series. Failed, 
so I took it over and have broken them up into 5 logical groups of 
adjustments to divide and conquer.

Was submitted one group at a time, out of eventually 5, with more than a 
month between them with no up-streaming action. They were reworked based 
on comments and split into smaller pieces (the first 12 were a much 
smaller set for example). Over the years (yes, it has been years) I have 
settled on resending the 23 patches, still has 5 groups, and each 
individual patch is tested one at a time, so they can be taken 
individually from each set.

ARM has complained that they want them all at one time because 
individually they represent more work. So the whole set is here ready to go.
>
> It seems the patchset is already somewhat broken up into separate
> sets, so I might recommend picking just one area and focus on
> upstreaming that first. Maybe the in-arch cleanups for arm and then
> arm64 and then maybe do the move to lib?

They are in set-order, The first 12 can be taken one at a time to 
modernize arm so that it is up-to-date with the assembler code for 
arm64. More or less the order you just outlined.

TahDah :-)

-- Mark
