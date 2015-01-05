From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 5 Jan 2015 10:08:18 +0000
Subject: [PATCH 0/9] ARM Versatile multi-platform support
In-Reply-To: <54AA5E7C.1040706@arm.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CAFEAcA9pKdRNQ-fgKumQhjTjei-4NJ-OB1gSOxTCnCjShy10jw@mail.gmail.com>
 <54AA5E7C.1040706@arm.com>
Message-ID: <CAFEAcA8Nq6BPOerN7EhHpT_oa9W3+2Y_=5+zBuQD_c5fh0Yb1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2015 at 09:50, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 31/12/14 09:25, Peter Maydell wrote:
>> Will Deacon and Marc Zyngier are currently in possession of that h/w.
>> I'm sure they'd be delighted to pull it out of the cupboard and
>> give it a spin :-)
>
> I'll try to find some time (or a victim to do the testing... ;-)

To save you some time in trying to debug things which didn't work
before this patchset, the status last time I tested on h/w was:
 * PCI MMIO accesses work
 * PCI IO accesses work
 * PCI bus-master (DMA) doesn't work

with the failure symptom for DMA being that the card wrote to
the correct area of memory but only every other word, so you
got strings like "HellXXXXrld" with the Xs being garbage.
This feels to me like a h/w issue rather than a driver problem.

-- PMM
