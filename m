From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Tue, 27 Oct 2015 08:22:30 +0100
Subject: [PATCH 01/10] pwm: lpc18xx_pwm: use pwm_set_chip_data
In-Reply-To: <CAAEAJfD=Lvqx-4_SHJyhg9Q1T_CKhLaGYs+X_ttoVf_zh_Yvkg@mail.gmail.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
 <CAAEAJfD=Lvqx-4_SHJyhg9Q1T_CKhLaGYs+X_ttoVf_zh_Yvkg@mail.gmail.com>
Message-ID: <9D291167-A7CA-4954-AE33-A3ECC3A52FF2@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Ezequiel,

On October 26, 2015 10:58:18 PM CET, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
>(+ Ariel)
>
>Hi Oliver,
>
>Not sure why there's some many people in Cc for such a silly change.
>I guess you are using get_maintainers.pl on the entire patchset and get
>this rather long list.
>
I did indeed use the script and for v2 i'll split it up in several patches. The grouping that made sense to me was it was all pwm related. I'll do better next time. Sorry.

>IMO, the value of submitting patches as part of a larger series is to
>be able to
>push patches that need to be applied in some given order, or otherwise
>have some kind of logical relationship between them.
>
>However, this is not the case: it's just a very small change and has
>no relation to the rest of the patches in the series.
>I think a simple standalone patch would be better here.
>
>Also, get_maintainer.pl is just a hint, and not meant to be used as-is.
>In particular, you are missing the driver's author.
>
>On 26 October 2015 at 18:32, Olliver Schinagl
><o.schinagl@ultimaker.com> wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The lpc18xx driver currently manipulates the pwm_device struct
>directly
>> rather then using the pwm_set_chip_data. While the current method may
>> save a clock cycle or two, it is more obvious that data is set to the
>> chip pointer (especially since it is only a single int holding
>struct.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>>  drivers/pwm/pwm-sun4i.c       | 11 +++++++++++
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>
>...and this diffstat is obviously fishy.
It does.indeed, somehow i.must have accidentally merged two patches, stupid me. This.will also be addressed in the v2.

Olliver

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
