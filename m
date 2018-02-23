From: bp@alien8.de (Borislav Petkov)
Date: Fri, 23 Feb 2018 19:07:54 +0100
Subject: [PATCH 01/11] ACPI / APEI: Move the estatus queue code up, and
 under its own ifdef
In-Reply-To: <5A90572D.9010704@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-2-james.morse@arm.com>
 <20180220192852.GB24320@pd.tnic> <5A90572D.9010704@arm.com>
Message-ID: <20180223180754.GI4981@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:02:21PM +0000, James Morse wrote:
> Sure. I reckon your English grammar is better than mine, is this better?:

Bah, you must be joking :-)

> | In any NMI-like handler, memory from ghes_estatus_pool is used to save
> | estatus, and added to the ghes_estatus_llist. irq_work_queue() causes
> | ghes_proc_in_irq() to run in IRQ context where each estatus in
> | ghes_estatus_llist are processed. Each NMI-like error source must grow

s/are/is/ reads better to me, for some reason :)

> | the ghes_estatus_pool to ensure memory is available.

Other than that, yap, much better!

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
