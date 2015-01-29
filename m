From: namhyung@kernel.org (Namhyung Kim)
Date: Thu, 29 Jan 2015 15:54:50 +0900
Subject: [PATCH V3 2/2] perf symbols: debuglink should take symfs option
 into account
In-Reply-To: <CAA3XUr1twCC6s=1Y3Fk7W3ER9t6hFKJBC57vyzx9zjTD9fMW1Q@mail.gmail.com>
References: <1422340442-4673-1-git-send-email-victor.kamensky@linaro.org>
 <1422340442-4673-3-git-send-email-victor.kamensky@linaro.org>
 <20150129013809.GB24182@sejong>
 <CAA3XUr1twCC6s=1Y3Fk7W3ER9t6hFKJBC57vyzx9zjTD9fMW1Q@mail.gmail.com>
Message-ID: <20150129065450.GD24182@sejong>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 08:08:30PM -0800, Victor Kamensky wrote:
> Hi  Namhyung,
> 
> On 28 January 2015 at 17:38, Namhyung Kim <namhyung@kernel.org> wrote:
> > Hi Victor,
> >
> > On Mon, Jan 26, 2015 at 10:34:02PM -0800, Victor Kamensky wrote:
> >> Currently code that tries to read corresponding debug symbol
> >> file from .gnu_debuglink section (DSO_BINARY_TYPE__DEBUGLINK)
> >> does not take in account symfs option, so filename__read_debuglink
> >> function cannot open ELF file, if symfs option is used.
> >>
> >> Fix is to add proper handling of symfs as it is done in other
> >> places: use __symbol__join_symfs function to get real file name
> >> of target ELF file.
> >>
> >> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> >> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: Waiman Long <Waiman.Long@hp.com>
> >> Cc: David Ahern <dsahern@gmail.com>
> >> Acked-and-tested-by: David Ahern <dsahern@gmail.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thank you for the Acks! Is there any action items on my side?
> Should I repost patches with your Acks? Or you or Arnaldo
> will add them once they got merged in proper tree for
> upstreaming?

I think Arnaldo will merge them with Acks. ;-)

Thanks,
Namhyung
