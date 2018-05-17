From: bp@alien8.de (Borislav Petkov)
Date: Thu, 17 May 2018 15:39:24 +0200
Subject: [PATCH v3 07/12] ACPI / APEI: Make the nmi_fixmap_idx per-ghes
 to allow multiple in_nmi() users
In-Reply-To: <39bde8c5-4dfb-c1b9-02a4-ba467539ea24@codeaurora.org>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-8-james.morse@arm.com>
 <20180505122719.GE3708@pd.tnic>
 <1511cfcc-dcd1-b3c5-01c7-6b6b8fb65b05@arm.com>
 <20180516110348.GA17092@pd.tnic>
 <39bde8c5-4dfb-c1b9-02a4-ba467539ea24@codeaurora.org>
Message-ID: <20180517133924.GB27738@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 11:38:16AM -0400, Tyler Baicar wrote:
> I haven't seen a deadlock from that, but it looks possible. What if
> the ghes_proc() call in ghes_probe() is moved before the second switch
> statement? That way it is before the NMI/IRQ/poll is setup. At quick
> glance I think that should avoid the deadlock and still provide the
> functionality that call was added for. I can test that out if you all
> agree.

Makes sense but please audit it properly before doing the change. That
code is full of landmines and could use a proper scrubbing first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
