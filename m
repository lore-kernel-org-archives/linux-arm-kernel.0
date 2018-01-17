From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 17 Jan 2018 09:06:40 +0100
Subject: [PATCH v2 01/10] perf tools: Integrating the CoreSight decoding
 library
In-Reply-To: <CANLsYkyEnJ5QzYyuGwhCB5p_2mE+8DdjaU6=Vpa6=CeKR+DzWg@mail.gmail.com>
References: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
 <1516039994-314-2-git-send-email-mathieu.poirier@linaro.org>
 <20180116121500.GB26643@krava>
 <CANLsYkyEnJ5QzYyuGwhCB5p_2mE+8DdjaU6=Vpa6=CeKR+DzWg@mail.gmail.com>
Message-ID: <20180117080640.GD6183@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 01:30:33PM -0700, Mathieu Poirier wrote:
> On 16 January 2018 at 05:15, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Mon, Jan 15, 2018 at 11:13:05AM -0700, Mathieu Poirier wrote:
> >> The Open CoreSight Decoding Library (openCSD) is a free and open
> >> library to decode traces collected by the CoreSight hardware
> >> infrastructure.
> >>
> >> This patch adds the required mechanic to recognise the presence
> >> of the openCSD library on a system and set up miscellaneous flags
> >> to be used in the compilation of the trace decoding feature.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>  tools/build/Makefile.feature          |  6 ++++--
> >>  tools/build/feature/Makefile          |  7 ++++++-
> >>  tools/build/feature/test-all.c        |  5 +++++
> >>  tools/build/feature/test-libopencsd.c |  8 ++++++++
> >>  tools/perf/Makefile.config            | 25 +++++++++++++++++++++++++
> >>  tools/perf/Makefile.perf              |  2 ++
> >>  6 files changed, 50 insertions(+), 3 deletions(-)
> >>  create mode 100644 tools/build/feature/test-libopencsd.c
> >>
> >> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> >> index e52fcefee379..dc3d97b248ab 100644
> >> --- a/tools/build/Makefile.feature
> >> +++ b/tools/build/Makefile.feature
> >> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
> >>          bpf                             \
> >>          sched_getcpu                 \
> >>          sdt                          \
> >> -        setns
> >> +        setns                                \
> >> +     libopencsd
> >>
> >>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> >>  # of all feature tests
> >> @@ -108,7 +109,8 @@ FEATURE_DISPLAY ?=              \
> >>           zlib                   \
> >>           lzma                   \
> >>           get_cpuid              \
> >> -         bpf
> >> +         bpf                 \
> >> +      libopencsd
> >
> > we put in this list only generic libraries, this one seems arch
> > specific please put it into FEATURE_TESTS_EXTRA list
> 
> Humm... Jiri,
> 
> I was thinking that libopencsd should fall in the same category as
> libunwind-arm and libunwind-aarch64.  Both are not architecture
> specific and used to process traces acquired on ARM platforms.  As
> such I suggest to keep libopencsd as part of FEATURE_TESTS_BASIC and
> remove it from under FEATURE_DISPLAY - how does that sound to you?
> 

ok, that sounds good

jirka
