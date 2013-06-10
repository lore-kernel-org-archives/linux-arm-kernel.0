From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 10:10:12 +0100
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <CAAVeFuJuf2hrMaM5keoai65vAAg6JLrjDUvYm4e2zQvsw64_8A@mail.gmail.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <20130606110240.GA3320@localhost.localdomain>
 <CAAVeFu+o7oc4Rrn67xxzsgeZ9xrTBkaLd_E4amaVgcNBRsKC_g@mail.gmail.com>
 <20130607173004.GA29344@localhost.localdomain>
 <CAAVeFuJuf2hrMaM5keoai65vAAg6JLrjDUvYm4e2zQvsw64_8A@mail.gmail.com>
Message-ID: <20130610091012.GR18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 04:47:22PM +0900, Alexandre Courbot wrote:
> One could remove the naked attribute and put there registers into the
> clobber list, but then the function will be inlined and we will have
> to ensure the parameters end up in the right register (and having a
> function that cannot be inlined is convenient in that respect). So as
> far as I can tell, having the function naked and saving the registers
> ourselves seems to be the most convenient way around this.

If you use such a large clobber list, you risk the compiler barfing on
you that it's run out of registers.
