From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 18 Jan 2018 14:59:48 +0100
Subject: [PATCH v2 01/10] perf tools: Integrating the CoreSight decoding
 library
In-Reply-To: <20180118134139.GC18383@kernel.org>
References: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
 <1516039994-314-2-git-send-email-mathieu.poirier@linaro.org>
 <20180116121500.GB26643@krava>
 <CANLsYkyEnJ5QzYyuGwhCB5p_2mE+8DdjaU6=Vpa6=CeKR+DzWg@mail.gmail.com>
 <20180117080640.GD6183@krava> <20180118134139.GC18383@kernel.org>
Message-ID: <20180118135948.GA2940@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 10:41:39AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 17, 2018 at 09:06:40AM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 16, 2018 at 01:30:33PM -0700, Mathieu Poirier wrote:
> > > On 16 January 2018 at 05:15, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Mon, Jan 15, 2018 at 11:13:05AM -0700, Mathieu Poirier wrote:
> > > >> +++ b/tools/build/Makefile.feature
> > > >> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
> > > >>          bpf                             \
> > > >>          sched_getcpu                 \
> > > >>          sdt                          \
> > > >> -        setns
> > > >> +        setns                                \
> > > >> +     libopencsd
> > > >>
> > > >>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> > > >>  # of all feature tests
> > > >> @@ -108,7 +109,8 @@ FEATURE_DISPLAY ?=              \
> > > >>           zlib                   \
> > > >>           lzma                   \
> > > >>           get_cpuid              \
> > > >> -         bpf
> > > >> +         bpf                 \
> > > >> +      libopencsd
> 
> > > > we put in this list only generic libraries, this one seems arch
> > > > specific please put it into FEATURE_TESTS_EXTRA list
> 
> > > I was thinking that libopencsd should fall in the same category as
> > > libunwind-arm and libunwind-aarch64.  Both are not architecture
> > > specific and used to process traces acquired on ARM platforms.  As
> > > such I suggest to keep libopencsd as part of FEATURE_TESTS_BASIC and
> > > remove it from under FEATURE_DISPLAY - how does that sound to you?
>  
> > ok, that sounds good
> 
> Hi Jiri,
> 
> 	Shouldn't libopencsd be treated like libbabeltrace was before
> the required version was widely available in distros?
> 
> 	I.e. these csets should have the rationale for that:
> 
> Enabling it once it became widely available:
> 
>    24787afbcd01 ("perf tools: Enable LIBBABELTRACE by default")
> 
> Disabling it because we would need to get things from tarballs/git
> repos, build it in our machines, as requested by Ingo:
> 
>   6ab2b762befd ("perf build: Disable libbabeltrace check by default")

I think at that time we did not have a way to hide the check,
now we have FEATURE_DISPLAY seprated so we can still check
for it, but users won't be bothered with [ FAIL ] output

jirka
