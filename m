From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 14:43:06 +0000
Subject: [PATCH v2 06/18] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <20171120144147.7iawjcw644zc4xes@lakrids.cambridge.arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-7-samitolvanen@google.com>
 <20171120144147.7iawjcw644zc4xes@lakrids.cambridge.arm.com>
Message-ID: <20171120144306.z5uyeyectmce6plu@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 02:41:47PM +0000, Mark Rutland wrote:
> On Wed, Nov 15, 2017 at 01:34:16PM -0800, Sami Tolvanen wrote:
> > Use -fno-jump-tables to make sure clang doesn't generate branches
> > to EL1 virtual addresses.
> 
> Are there any other reasons that clang might generate absolute
> references/relocations?
> 
> It would be nice if there was the option to disable that more generally,
> rather than disabling individual optimizations. Is there any PIC/PIE
> option that we could use?
> 
> We might need something simnilar for GCC, even if we're not seeing
> problems today.

... and likewise for the EFI stub, which needs to be
position-independent much like the hyp code.

Thanks,
Mark.
