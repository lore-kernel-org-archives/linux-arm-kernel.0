From: jlinton@redhat.com (Jeremy Linton)
Date: Mon, 23 Nov 2015 09:46:35 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151123154122.GG4236@arm.com>
References: <564CA29A.9050905@arm.com> <20151118162932.GA13355@leverpostej>
 <564CB1DA.4090304@arm.com> <20151118180434.GB13355@leverpostej>
 <564CD206.9040402@arm.com> <20151119112923.GA24570@leverpostej>
 <20151120195243.GC14942@leverpostej>
 <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
 <20151123134911.GB28293@leverpostej> <56532748.4010508@redhat.com>
 <20151123154122.GG4236@arm.com>
Message-ID: <565334DB.7050001@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 09:41 AM, Will Deacon wrote:

> For these reasons, we have no viable option other than reverting the
> offending series until the underlying problem is fixed properly. With
> any luck, that's the 4.5 timeframe so we really only lose a single
> release (providing that you have time to rebase and repost).


That is fine but, I think you need to take this fix anyway (or something 
similar), because there _IS_ a TLB flush bug in that code path. I saw it 
when I wrote the original path, but discounted it assuming that the 
original authors had more insight on the hardware than I did.

Whether the fix takes the suggest form or another, the cont bit changes 
are only irritating an existing bug, not causing it.
