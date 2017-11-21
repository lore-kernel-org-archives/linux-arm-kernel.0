From: npiggin@gmail.com (Nicholas Piggin)
Date: Tue, 21 Nov 2017 11:01:52 +1000
Subject: [v2,12/18] kbuild: add support for clang LTO
In-Reply-To: <20171120202152.GA89108@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-13-samitolvanen@google.com>
 <20171118132139.58ac5e4c@roar.ozlabs.ibm.com>
 <20171120202152.GA89108@samitolvanen.mtv.corp.google.com>
Message-ID: <20171121110152.23fb751a@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Nov 2017 12:21:52 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Sat, Nov 18, 2017 at 01:21:39PM +1000, Nicholas Piggin wrote:
> > Do you have any kind of numbers for this, out of curiosity? Binary
> > size, performance, build time?  
> 
> I don't have performance numbers to share. Are there any specific
> benchmarks you'd be interested in seeing? Build time typically
> increases with LTO and in my experience, binary size tends to increase
> by ~10-15% as well.

By deduction, then you must see some performance improvement? :) 

I just wonder are you doing this because there is some worthwhile
performance gain? Or to enable more testing and development of LTO?
Any clues for why a user would want to enable it.

> 
> > Why is this needed? It would have been nice to get rid of the
> > !THIN_ARCHIVES option if you can make the patches work with the thin
> > archives paths.  
> 
> I believe LLVMgold doesn't know how to deal with an archive of LLVM IR
> files, but I can certainly use thin archives as an index and extract
> the path names for linking. I'll look into it.

Thanks, if you could. Possibly file a request with LLVMgold too, it
seems to be that toolchain support for archives is quite strong, so it
will be good to keep pushing for that.

Thanks,
Nick
