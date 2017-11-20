From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 20 Nov 2017 20:32:56 +0100
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171120180554.GM32488@arm.com>
References: <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
 <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
 <20171116191307.GC3624@linux.vnet.ibm.com>
 <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
 <20171120180554.GM32488@arm.com>
Message-ID: <20171120193256.e6fnn2arwqc5wqkp@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 06:05:55PM +0000, Will Deacon wrote:
> Although the current direction of the C++ committee is to prefer
> that dependencies are explicitly "marked", this is not deemed to be
> acceptable for the kernel (in other words, everything is always considered
> "marked").

Yeah, that is an attitude not compatible with existing code. Much like
the proposal to allow temporary/wide stores on everything not explicitly
declared atomic. Such stuff instantly breaks all extant code that does
multi-threading with no recourse.
