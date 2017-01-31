From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2017 09:44:42 -0800
Subject: [GIT PULL] Qualcomm SoC Updates for v4.11
In-Reply-To: <20170131071118.GA2821@hector.attlocal.net>
References: <1485240752-8339-1-git-send-email-andy.gross@linaro.org>
 <20170130002644.GP3133@localhost> <20170131071118.GA2821@hector.attlocal.net>
Message-ID: <CAOesGMg+2W_wnPpKz81n43XnxMNxBoOt7PDOJ-EssY89Gz_L8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 11:11 PM, Andy Gross <andy.gross@linaro.org> wrote:
> On Sun, Jan 29, 2017 at 04:26:44PM -0800, Olof Johansson wrote:
>> On Tue, Jan 24, 2017 at 12:52:32AM -0600, Andy Gross wrote:
>> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
>> >
>> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.11
>> >
>> > for you to fetch changes up to aabde95fc543a9ca68df06b9c7ea8e699702d7ad:
>> >
>> >   firmware: qcom: scm: Fix interrupted SCM calls (2017-01-23 10:01:49 -0600)
>> >
>> > ----------------------------------------------------------------
>> > Qualcomm ARM Based SoC Updates for v4.11
>> >
>> > * Add SMCC quirk support
>> > * Add Qualcomm SCM quirk to fix interrupted calls
>>
>> Hi,
>>
>> I replied on one of the patches. Not sure doing this through quirks is the
>> right way right now -- unless we expect a lot more quirks over time, and/or if
>> this is an "enhancement" that other vendors are also likely to pick up.
>
> I saw.  We originally tried adding our own calls, but with the advent of the
> arm_smccc call it was nice to be able to leverage that instead of adding a whole
> new copy of the thing.  And people didn't like the original implementation all
> that much because it somewhat abused the arm_smccc register conventions.
>
> If we added our own, it'd be a copy of the arm one with the extra register
> access.

Yep. Sorry to put you in a tight spot, but since Will was rejecting my
feedback, he gets to merge the code the way he wants it to look like.

Unless I hear otherwise I'm assuming the rest of the code in this pull
request is either going in with those changes, or will be submitted
once the dependent changes have landed upstream.


Thanks!

-Olof
