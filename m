From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 17 Sep 2016 16:38:25 +0100
Subject: [PATCH v3 0/2] KVM: ARM: Enable vtimers with user space gic
In-Reply-To: <CAKv+Gu_+txUFT158VzJqeE3Jwdd1LL1n2kzOzYKuk03UFxW3NQ@mail.gmail.com>
References: <1474007187-18673-1-git-send-email-agraf@suse.de>
 <57DBC782.7080305@arm.com> <060ADA14-786E-400E-9B11-61C34B7081B5@suse.de>
 <20160916122937.GA14140@cbox>
 <6b92c411-8b27-a4c0-6969-38e32bbf18ab@redhat.com>
 <10C5B047-6A7F-4255-BE56-5358AF88DA5E@suse.de>
 <CAKv+Gu_+txUFT158VzJqeE3Jwdd1LL1n2kzOzYKuk03UFxW3NQ@mail.gmail.com>
Message-ID: <CAFEAcA8JRscJox0Up3vRyDeOzy7PEHpm0p0cKBNeAYO6xeSZZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2016 at 16:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Another thing to keep in mind is that GICv2
> compatibility is disabled on the non-secure side if the secure side
> elects to configure its view of the GIC as v3 (i.e., in order to
> support >8 cores)

If I'm reading the 'legacy configurations' chapter of the GICv3
spec correctly, that is true for the NS host OS (ie the one
handling physical interrupts) but a guest OS can still use
the old GICv2-compat interface (assuming it was implemented
in silicon at all).

thanks
-- PMM
