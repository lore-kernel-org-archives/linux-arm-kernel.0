From: drjones@redhat.com (Andrew Jones)
Date: Tue, 20 Dec 2016 10:43:39 +0100
Subject: [PATCH v8 01/16] FDT: introduce global phandle allocation
In-Reply-To: <80430161-b363-4740-0eef-8cb73bc2ecbd@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
 <20161104173203.21168-2-andre.przywara@arm.com>
 <be44a9ad-f820-9a62-9a5d-682867674e91@arm.com>
 <80430161-b363-4740-0eef-8cb73bc2ecbd@arm.com>
Message-ID: <20161220094339.6yg624kev2wqxidt@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 06:43:29PM +0000, Andre Przywara wrote:
> Well, yes. The problem is that AFAIK you cannot initialize an array
> easily with all the values getting set to something other than zero.

u32 phandles[PHANDLES_MAX] = { [0 ... PHANDLES_MAX-1] = FDT_INVALID_PHANDLE };

(Unrelated, but could you please add format.subjectprefix = PATCH kvmtool
 to your git config. I just suggested via a kvmtool README patch...)

Thanks,
drew
