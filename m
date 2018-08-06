From: dianders@chromium.org (Doug Anderson)
Date: Mon, 6 Aug 2018 15:55:53 -0700
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <20180726183922.GA4402@hector.mosconeconnections.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
 <20180724165942.GP13268@sirena.org.uk>
 <20180726183922.GA4402@hector.mosconeconnections.com>
Message-ID: <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Jul 26, 2018 at 11:39 AM, Andy Gross <andy.gross@linaro.org> wrote:
> + olof
>
> On Tue, Jul 24, 2018 at 05:59:42PM +0100, Mark Brown wrote:
>> On Tue, Jul 24, 2018 at 08:43:46AM -0700, Doug Anderson wrote:
>> > On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > > There was also some other thing called command DB as well which was a
>> > > separate series.  Ideally there'd be a branch I could pull as there's a
>> > > build dependency on rpmh so I can't apply until the code has landed in
>> > > my tree, don't know what command DB is exactly.
>>
>> > Yup.  That one landed in May and is already in mainline Linux.  Refer
>> > to commit 312416d9171a ("drivers: qcom: add command DB driver").
>>
>> That's good at least - the cover letter said it was still under review,
>> guess it just hadn't been updated.
>>
>> > Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
>> > can provide you with the branch.
>>
> Mark,
>
> The arm-soc guys merged the Qualcomm pull requests.  So you can just use my
> qcom-drivers-for-4.19 tag.  That won't change at this point.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
> qcom-drivers-for-4.19

Did Andy's idea of using the above tag work for you?  It appears that
there are a few patches you don't need there, but it shouldn't hurt to
pick them up too I think?  Here's what I see:

---

$ git log --oneline linux/master..qcom-drivers-for-4.19
78ee559d7fc6 (tag: qcom-drivers-for-4.19) soc: qcom: rmtfs-mem: fix
memleak in probe error paths
4da3b0452bc6 soc: qcom: llc-slice: Add missing MODULE_LICENSE()
6c805adf17d4 drivers: qcom: rpmh: fix unwanted error check for get_tcs_of_type()
efa1c257b3fc drivers: qcom: rpmh-rsc: fix the loop index check in
get_req_from_tcs
a0b1561f8461 firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
fdd102b52cfd drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children
2de4b8d33eab drivers: qcom: rpmh-rsc: allow active requests from wake TCS
c8790cb6da58 drivers: qcom: rpmh: add support for batch RPMH request
564b5e24ccd4 drivers: qcom: rpmh: allow requests to be sent asynchronously
600513dfeef3 drivers: qcom: rpmh: cache sleep/wake state requests
9a3afcfbc0cc drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
fa460e453a83 drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
c1038456b02b drivers: qcom: rpmh: add RPMH helper functions
fc087fe5a45e drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
2e4690a09fca dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
658628e7ef78 drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
a3134fb09e0b drivers: soc: Add LLCC driver
7e5700ae64f6 dt-bindings: Documentation for qcom, llcc
0b65c59e3a54 soc: qcom: smem: Correct check for global partition

---

It seems like it's too late to land RPMh-regulator for 4.19, so I
guess we'll have to aim for 4.20.  I'm not sure if that means you're
going to want to wait until 4.20-rc1 comes out to use as a base before
thinking about landing RPMh-regulator?  If so then I guess we've got
~3 weeks before something could land and we could start landing device
tree bits using RPMh-regulator.  If that's the plan then we'll
probably just start landing things in the Chrome OS tree now and suck
up the extra work of trying to resolve differences later...

Thanks!

-Doug
