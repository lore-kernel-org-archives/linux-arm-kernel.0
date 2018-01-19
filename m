From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 19 Jan 2018 08:24:56 -0700
Subject: [PATCH v2 01/10] perf tools: Integrating the CoreSight decoding
 library
In-Reply-To: <20180119151237.GA13089@krava>
References: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
 <1516039994-314-2-git-send-email-mathieu.poirier@linaro.org>
 <20180116121500.GB26643@krava>
 <CANLsYkyEnJ5QzYyuGwhCB5p_2mE+8DdjaU6=Vpa6=CeKR+DzWg@mail.gmail.com>
 <20180117080640.GD6183@krava> <20180118134139.GC18383@kernel.org>
 <20180118135948.GA2940@krava> <20180118141423.GE18383@kernel.org>
 <20180118142743.GD2940@krava> <20180119145819.GC23453@kernel.org>
 <20180119151237.GA13089@krava>
Message-ID: <CANLsYkx5VPw6croP2SrxJ0HU=sC9HT1NdkknHuE_z=PiPGafjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 January 2018 at 08:12, Jiri Olsa <jolsa@redhat.com> wrote:
> On Fri, Jan 19, 2018 at 11:58:19AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Jan 18, 2018 at 03:27:43PM +0100, Jiri Olsa escreveu:
>> > On Thu, Jan 18, 2018 at 11:14:23AM -0300, Arnaldo Carvalho de Melo wrote:
>> > > Em Thu, Jan 18, 2018 at 02:59:48PM +0100, Jiri Olsa escreveu:
>> > > > On Thu, Jan 18, 2018 at 10:41:39AM -0300, Arnaldo Carvalho de Melo wrote:
>> > > > >       Shouldn't libopencsd be treated like libbabeltrace was before
>> > > > > the required version was widely available in distros?
>> > >
>> > > > >       I.e. these csets should have the rationale for that:
>> > >
>> > > > > Enabling it once it became widely available:
>> > >
>> > > > >    24787afbcd01 ("perf tools: Enable LIBBABELTRACE by default")
>> > >
>> > > > > Disabling it because we would need to get things from tarballs/git
>> > > > > repos, build it in our machines, as requested by Ingo:
>> > >
>> > > > >   6ab2b762befd ("perf build: Disable libbabeltrace check by default")
>> > > >
>> > > > I think at that time we did not have a way to hide the check,
>> > > > now we have FEATURE_DISPLAY seprated so we can still check
>> > > > for it, but users won't be bothered with [ FAIL ] output
>> > >
>> > > Ok, users won't be bothered with the fail output, but we tried hard to
>> > > get the build fast by having it only test for things that are widely
>> > > available, right? I.e. if we know something is not widely available then
>> > > we better not try to build with it and get faster builds, wasn't that
>> > > part of the rationale in the babeltrace case?
>> > >
>> > > If one has to build from sources some library, then its not a problem to
>> > > have in the make command line a LIBOPENCSD=1 switch?
>> >
>> > right, we can do it like that
>>
>> So I'm applying v2 and we can go on from there, to make progress, ok?
>> I'm adding your Acked-by to all but the build ones, ok?
>
> I think v3 was in better shape.. wrt tabs and overall display
>
> jirka

Jiri is correct - V3 should be considered.
