From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 10 Jun 2013 11:40:18 +0800
Subject: [PATCH 0/2] ARM: multiple-platforms: fix the kernel panic on
 non-SiRF platforms
In-Reply-To: <20130610001331.GA21645@quad.lixom.net>
References: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
 <20130610001331.GA21645@quad.lixom.net>
Message-ID: <CAGsJ_4yZJ4Fs2fOyv1D1vBLTzRnhNu=6E8qTA_0m7gnkPEE63A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/10 Olof Johansson <olof@lixom.net>:
> On Tue, Jun 04, 2013 at 10:34:13AM +0800, Barry Song wrote:
>> These two patches fix the kernel panic for multiple-platform kernel to run on non-SiRF
>> platforms.
>>
>> It depends on patches I sent in the pull-request mail
>> [GIT PULL] SiRF fixes for the v3.10 series
>> at:
>> http://www.spinics.net/lists/arm-kernel/msg247521.html
>>
>> And thanks for the original patchset from Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> Hi,
>
> A better and more narrow fix for 3.10 would be to gracefully abort the
> initcalls if the device nodes are not found, which is what I had as original
> feedback on these patches in the first place. Print an error but continue
> booting.
ok, for 3.10, let's do a quick fix, then i will ack haojian zhuang's:
[PATCH v2] ARM: prima2: fix incorrect panic usage

i had some discussion with Srinivas, and agreed with Srinivas about
moving these functions to callback of prima2 mach_desc. that will
avoid some redundant function calls for non-csr platforms. i'll make
it as cleanup in 3.11 then.

>
>
> -Olof
>

-barry
