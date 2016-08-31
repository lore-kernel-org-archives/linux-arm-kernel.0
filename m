From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Aug 2016 15:55:46 +0800
Subject: [linux-sunxi] Re: [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
In-Reply-To: <20160831094959.2e5e6ae7@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-3-dannym@scratchpost.org>
 <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
 <20160831094044.1c3227d6@scratchpost.org>
 <CAGb2v67YGiZEzBezub5HcEBZ5689uF1yQYj2xJkbVdHyEpOm5Q@mail.gmail.com>
 <20160831094959.2e5e6ae7@scratchpost.org>
Message-ID: <CAGb2v66jkd7+GMUbihQjA0ec9nDZc=k2yDT3afD1q6qo57PVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 3:49 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi Chen-Yu,
>
>> My apologies. I didn't notice that VMIC was already in the driver.
>> In that your original patch did everything right.
>
> Don't worry about it :)
>
> But I have a question:
>
> If I replace DAPM_INPUT by DAPM_MIC it wants a callback that is supposed to
> fiddle with the bias.
> Do I provide one?
> If so, will it conflict with the supply?
>
> Or do I leave it as DAPM_INPUT ?

I think leaving it as DAPM_INPUT will do. Also, if you use DAPM_MIC or any
other widget type that takes a callback, the callback can be NULL.

I took a quick look at other drivers. The codecs only use non-endpoint
types, like INPUT/OUTPUT. It's up to the card to provide endpoints
(HP/SPEAKER/LINE/MIC) and route them to the codec INPUT/OUTPUTs.


Regards
ChenYu
