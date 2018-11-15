From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 15 Nov 2018 20:27:36 +0000
Subject: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <mvm8t1ug1pn.fsf@suse.de>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <mvmbm6tgunu.fsf@suse.de>
 <20181113105717.GA5664@yury-thinkpad>
 <20181115005109.73ll47dfwk4uc63r@localhost> <mvm8t1ug1pn.fsf@suse.de>
Message-ID: <20181115202727.GA25470@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 09:54:44AM +0100, Andreas Schwab wrote:
> On Nov 15 2018, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Hopefully the changes between 4.18 and 4.19 are smaller than .17->.18.
> 
> It's the other way round, unfortunately.

Hi Catalin, Andreas,

This is the 4.19-based series with fixes to regressions I mentioned above: 
https://github.com/norov/linux/commits/ilp32-4.19.2

Syscall machinery is rewritten in C in mainline kernel, so I aligned ILP32
with it. I think it's worth to revisit all the series with careful review, but
the following patches look the most affected:

73eb215286f0 arm64: ilp32: introduce ilp32-specific sigframe and ucontext
5a8f18457b58 arm64: signal32: move ilp32 and aarch32 common code to separated file
561dd666d5b4 arm64: signal: share lp64 signal structures and routines to ilp32
cd7dc1d3377a arm64: ilp32: introduce syscall table for ILP32
68ff08f76bf0 arm64: ilp32: share aarch32 syscall handlers

Next week, I'll finish all my testing and make a more 'official' announcement.
But I think that everything is generally fine, so please take an early
look, if you're interested in.

Thanks,
Yury
