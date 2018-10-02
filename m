From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Oct 2018 09:50:41 +0100
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
Message-ID: <20181002085041.GV30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
> architectures (providing vDSO32 for 32-bit applications).

I don't think the issue is what you think it is.  0.4% gain is
equivalent to almost (but not quite) 1 minute extra for a lifetime of
4 hours.  Is that really noticable, and is it worth the churn from
merging this series?

Given that the gain is so marginal, I can see why people find it
difficult to get excited about this series to spend the time reviewing
it.

What I'm saying is that the reason that people should look at this
series hasn't been "sold" particularly well.  How does it look from
the system performance point of view - is there a speed-up there
that's more significant?

In any case, I suspect that if you compare the battery life from
kernels from two years ago with modern kernels, you'll see a
degredation over that period just because of the progressive
increase in complexity, and especially things such as the Spectre
work-arounds.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
