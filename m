From: bp@alien8.de (Borislav Petkov)
Date: Mon, 1 Oct 2018 19:59:56 +0200
Subject: [PATCH v6 05/18] ACPI / APEI: Make estatus queue a Kconfig symbol
In-Reply-To: <20180921221705.6478-6-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-6-james.morse@arm.com>
Message-ID: <20181001175956.GF7269@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:52PM +0100, James Morse wrote:
> Now that there are two users of the estatus queue, and likely to be more,
> make it a Kconfig symbol selected by the appropriate notification. We
> can move the ARCH_HAVE_NMI_SAFE_CMPXCHG checks in here too.

Ok, question: why do we need to complicate things at all? I mean, why do
we even need a Kconfig symbol?

This code is being used by two arches now so why not simply build it in
unconditionally and be done with it. The couple of KB saved are simply
not worth the effort, especially if it is going to end up being enabled
on 99% of the setups...

Or?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
