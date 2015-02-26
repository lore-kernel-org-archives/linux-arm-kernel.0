From: jcmvbkbc@gmail.com (Max Filippov)
Date: Thu, 26 Feb 2015 14:52:09 +0300
Subject: [PATCH 1/1] ARM: TLV320AIC23 SoC Audio Codec: Fix errors reported
 related to input routing signals.
In-Reply-To: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
References: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
Message-ID: <CAMo8BfLtzn3J5waTMCRgUxaoC_w=aNkRCHoFP3AFoH4dP9PTkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 2:32 PM, Gabriel Dobato <dobatog@gmail.com> wrote:
> From: dobatog <dobatog@gmail.com>
>
> The following patch, based on stable v3.19,  corrects the errors that are reported in the boot trace in reference to the Input Signals of the audio codec TLV320AIC23:
>
> tlv320aic23-codec 1-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input
>
> I am trying to set the sound system in a CM-510 (Compulab - SoM) based board with DT, using Simple-Card-Audio and  the TLV320AIC23 audio codec included in the SoM . I faced this problem and thanks to the help of Sebastian Hesselbarth who noticed the possible error located in the structure snd_soc_dapm_route tlv320aic23_intercon[] , now errors are not reported.
>
> Tested on CM-510 (Compulab SoM Board).

Tested-by: Max Filippov <jcmvbkbc@gmail.com>

> Signed-off-by: dobatog <dobatog@gmail.com>

I believe you need to use your real name here and in the From: line.

-- 
Thanks.
-- Max
