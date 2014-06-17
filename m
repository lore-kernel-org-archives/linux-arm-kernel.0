From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 17 Jun 2014 10:15:10 -0700
Subject: [PATCH v3 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <7hvbrzbh1u.fsf@paris.lan>
References: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
 <7hvbrzbh1u.fsf@paris.lan>
Message-ID: <CAJAp7OhHr4Cgcp9pvQ3=MAie_zSnFJxG28Vf37qJ98BK7P1jaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:07 AM, Kevin Hilman <khilman@linaro.org> wrote:
> +Paul Walmsley
>
> Bjorn Andersson <bjorn.andersson@sonymobile.com> writes:
>
>> This series adds a regulator driver for the Resource Power Manager found in
>> Qualcomm 8660, 8960 and 8064 based devices.
>>
>> The RPM driver exposes resources to its child devices, that can be accessed to
>> implement drivers for the regulators, clocks and bus frequency control that's
>> owned by the RPM in these devices.
>>
>> Changes since v2:
>>   - Fix copy-paste error in dt binding
>>   - Correct incomplete move from mfd to soc
>>   - Correct const mistake in regulator driver
>>
>> Changes since v1:
>>   - Moved rpm driver to drivers/soc
>
> I'm not sure I follow the motivation for having this under drivers/soc?
>
Hi Kevin,

I've made the argument that to me this is conceptually a black box
handling regulators, clocks and other stuff; hence similar to a PMIC,
which would fit nicely into drivers/mfd.

I still think this is the case and now that I look back I didn't get
any pushback from Lee Jones so maybe the move was premature?

Regards,
Bjorn
