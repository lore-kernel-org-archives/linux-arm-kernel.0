From: john.stultz@linaro.org (John Stultz)
Date: Mon, 1 Oct 2018 11:49:27 -0700
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
Message-ID: <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> Last sent 23 Nov 2016.
>
> The following 23 patches are rebased and resent, and represent a
> rewrite of the arm and arm64 vDSO into C, adding support for arch32
> (32-bit user space hosted 64-bit kernels) and into a common library
> that other (arm, or non-arm) architectures may utilize.

So I feel like this has gone around a few times w/o much comment from
the arm/arm64 maintainers. I'm not sure if there's a reason?

I worry part of the issue is the scope of this patch set is a little
unwieldy (covering two architectures + generic code) might leave
maintainers thinking/hoping someone else should review it.

It seems the patchset is already somewhat broken up into separate
sets, so I might recommend picking just one area and focus on
upstreaming that first. Maybe the in-arch cleanups for arm and then
arm64 and then maybe do the move to lib?

thanks
-john
