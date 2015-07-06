From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jul 2015 10:03:24 +0100
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
Message-ID: <20150706090323.GB30342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 06:03:21AM +0100, Pratyush Anand wrote:
> Add all function symbols which are called from do_debug_exception under
> NOKPROBE_SYMBOL, as they can not kprobed.

It's a shame this has to be so manual, but I suppose it's done on a
best-effort basis to catch broken probe placement.

If we miss a function and somebody probes it, do we just get stuck in a
recursive exception, or could we print something suggesting that a symbol
be annotated as NOKPROBE?

Will
