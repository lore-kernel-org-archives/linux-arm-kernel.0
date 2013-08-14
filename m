From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 14 Aug 2013 19:01:05 +0100
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <20130814171854.GA11390@cbox>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr>
 <CAFEAcA8jgn9V1ANXXTsA_099BcsbC5NHPEMRh6=Rz1g8EDgBHA@mail.gmail.com>
 <abf9b3ef779ce43b1912bf9e3deea522@www.loen.fr> <20130814171854.GA11390@cbox>
Message-ID: <CAFEAcA9i59sm2pnX8YRsPsvHeuEiyNOS6yKLG3yoMBrJZz0V0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 18:18, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> How would we distinguish between a PSCI call that the kernel should
> support and a call to secure firmware that needs to be forwarded to
> QEMU?  Is this simply a binary config at VM creation time?

Kernel PSCI is always HVC (right?) so you could just say
that HVC is the kernel's business and SMC is the guest
firmware's.

If we make the kernel just restart the guest inside its
firmware blob without reflecting the SMC out to userspace
are we going to regret it later?

-- PMM
